From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Fri, 19 Sep 2008 16:38:53 +0400
Message-ID: <bb6f213e0809190538m5bbfeb38o5510d06fa6757dd1@mail.gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-4-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-5-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-6-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-7-git-send-email-angavrilov@gmail.com>
	 <48D396A8.4050607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 14:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgfHK-00040F-12
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 14:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbYISMi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 08:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYISMi4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 08:38:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:37614 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYISMiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 08:38:55 -0400
Received: by ey-out-2122.google.com with SMTP id 6so122005eyi.37
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MPUkReSeNi1C2B7BcKMk+NrI+XLtfsnd8COXL9XyVjA=;
        b=sN8Uxlt1oo213HA7So24/26kRX8txY94qznQbva+iyPxOBmdJgVvLfcUGygC2LLR51
         LZfHVBkldcCnLtHy0oixDde7eEL/VGb4Ff8voR4I4IcahSrjY5zrvxu8nuvbYTbWSbzX
         Jf+muzf7DlRDYJtRjv8Si6AmSAvnKPx3NeAxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EB/+oneEFfybTmfJhVx0U26/N1aGBQI//CMHx+6ZUFnb00OJjH3/+NfRRpoJPWZB/e
         gDV1tu3GDgZMsvWWl+bRk/a3p1iin9z81/VkD4j0W5Ih9yVOZ14znu0ElmRHH+LxK4XO
         SZ5D6uhjgQAKqjL03hzww+9mqj9Emm48JwBhw=
Received: by 10.103.223.9 with SMTP id a9mr3966557mur.87.1221827933269;
        Fri, 19 Sep 2008 05:38:53 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Fri, 19 Sep 2008 05:38:53 -0700 (PDT)
In-Reply-To: <48D396A8.4050607@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96280>

On Fri, Sep 19, 2008 at 4:10 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> If I run
>
>  $ LANG=C gitk 146ed90
>
> with this series on the git-gui repository, then I hoped to see the text
> in the patches in the right encoding. But I understand that I expected too
> much - the patch text is just a stream of bytes that comes from different
> files, and the best you can do is to apply the system encoding.
>
> But if the view is switched to the tree view, and file contents are
> inspected, then this patch should help. But it doesn't. If you look at
> po/ja.po, it is appearent that the file was not read as UTF-8, which is
> dictated by .gitattributes.

On my system everything works. You must have made a mistake somewhere. Namely:

1) Did you apply ALL patches to gitk? The first one is absolutely
useless without the other two.
2) Did you install it? I.e. do you actually run the patched version?
3) Do you have .gitattributes checked out?

Also, it should work in the patch mode as well: it reads the patch as
binary, and decodes each line separately, based on the encoding
determined for the current file.

Alexander
