From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Fri, 14 Mar 2008 01:22:08 +0200
Message-ID: <e29894ca0803131622mbea0c95j2d3b4fd4ee8eca1@mail.gmail.com>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
	 <47D9A836.9010601@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZwl9-0006bO-7K
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYCMXWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbYCMXWM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:22:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:64934 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbYCMXWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2008 19:22:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4222892wah.23
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gKmqWwvOTqwnM5slLmcjUWDITHqFK9YVSFcV8kNPMkY=;
        b=npF3s1DU4wnrIKu4rPAkoREGESVt0SPSYzFdG8Uze4W51v2wfSVy4wDMyMXVKVCfqGxhcCDjzaA4Py03swBNXecSiuNwbolwh1IQgEqu0BssPu3wUJ4bd7Z/0eGvnKoK90gYjramJ8w+GykF3yXpPF8nLO9gTi0XqSJueJBbQw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EC67i2YM59yhfUyveHDxkD5C9FUpJql78T8ehpyGCDa9EWuFBCsWrG185W+G93yMWDmFwz3HraASAH/pvB8g5IPzg1WRsO6l3e/vvwHihpsdBb/Ng71TcymNmNMHh48E2KjbV9+XjCk1+tUjv9OHnjUe7SrQHXtscvX6VGrmtFA=
Received: by 10.115.77.1 with SMTP id e1mr10550683wal.103.1205450528736;
        Thu, 13 Mar 2008 16:22:08 -0700 (PDT)
Received: by 10.114.60.4 with HTTP; Thu, 13 Mar 2008 16:22:08 -0700 (PDT)
In-Reply-To: <47D9A836.9010601@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77147>

Hi

On Fri, Mar 14, 2008 at 12:18 AM, Martin Langhoff
<martin@catalyst.net.nz> wrote:
>  > -     unless ($last_branch) {
>  > +     if (-f "$git_dir/$last_branch") {
>
>  Note that the file won't exist there in any modern git. It will be i=
n
>  $git_dir/refs/heads/$last_branch. Did you test this patch?
>

git-symbolic-ref HEAD do return "refs/heads/master" on my initial
in-the-middle checkout (I still have a copy),

So it seems correct for now, but i'll change it to use rev-parse
instead as it seems more correct.

Regards

--=20
Marc-Andr=E9 Lureau
