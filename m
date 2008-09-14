From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 05/16] ls-files: add --narrow-checkout option to "will checkout" entries
Date: Sun, 14 Sep 2008 11:55:06 -0700 (PDT)
Message-ID: <m34p4io8vt.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
	<1221397685-27715-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 20:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kewle-00014x-P9
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 20:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYINSzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 14:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbYINSzL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 14:55:11 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:39961 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbYINSzJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 14:55:09 -0400
Received: by gxk9 with SMTP id 9so22940117gxk.13
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=TByquSJzhU1BGhG6HBP+qVH0e85gZBA0nmzTGHX7QCc=;
        b=LzRtD45lhz1EXfPVjd9eWSC0rVpuW707rkYEUaPzzi8O84bCoqez+K1Cj1KDjWfe0Y
         F66heM8EWC2ihTUm+VzstgScGo7GNPFEWrhoVxS725N6p1nePHRlQL18AoY//F4aw7FG
         E4g9uQbqHO22HzEaNOGHK2ZKAMpAa/QBfD7e8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=SVkTB+sDaQwh98iTK/S1qBwsM/oA8ke6bkmHc4vtkVeB0oZOF6voP8C2fd3jaLEqhK
         jdnU/6jk6fIopCYtwMaSywW3812UO26r6yvyDbVY9Ouz3rHcuNQRTJIboYM9moC1i2hB
         P8s8Okvi/4k4zfdjYjnFBbJn+Kj1m2blzXMyM=
Received: by 10.102.228.2 with SMTP id a2mr4810498muh.79.1221418507916;
        Sun, 14 Sep 2008 11:55:07 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id s10sm25252186muh.12.2008.09.14.11.55.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 11:55:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8EIt3sZ014114;
	Sun, 14 Sep 2008 20:55:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8EIt2lM014111;
	Sun, 14 Sep 2008 20:55:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-6-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95853>

I will comment only on the documentation...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Even in narrow checkout mode, "git ls-files --cached" (and --stage)
> will show all entries in index. When those options are used together
> with --narrow-checkout, no-checkout entries will be skipped.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> index 9f85d60..f74b212 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -72,6 +73,11 @@ OPTIONS
>  	to file/directory conflicts for checkout-index to
>  	succeed.
> =20
> +--narrow-checkout::
> +	When narrow checkout is being used, this option together with other
> +	index-based selection options like --cached or --stage, only narrow=
ed
> +	portion will be printed out.
> +

I would rather say, that if git-ls-files is requested to show index
content (by using selection options like --cached or --stage), then
by default it shows all entries, also those marked "no checkout".
With this option git-ls-files would show only files that would get
checked out.

BTW. I think here --narrow-checkout is a good name, even though
I prefer 'partial checkout' or 'sparse checkout', because here it
is about narrowing the list of paths from index shown.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
