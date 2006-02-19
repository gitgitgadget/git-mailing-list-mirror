From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/2] Add 'stg uncommit' command
Date: Sun, 19 Feb 2006 10:51:06 +0000
Message-ID: <43F84D9A.2010905@gmail.com>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com> <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 11:51:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAm9q-0008DJ-CA
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 11:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWBSKvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Feb 2006 05:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBSKvL
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 05:51:11 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:14609 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932394AbWBSKvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 05:51:10 -0500
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20060219105108.GYND15056.mta07-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Sun, 19 Feb 2006 10:51:08 +0000
Received: from [192.168.1.101] (really [86.15.186.141])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20060219105108.OONH11424.aamta11-winn.ispmail.ntl.com@[192.168.1.101]>;
          Sun, 19 Feb 2006 10:51:08 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16428>

Karl Hasselstr=F6m wrote:
> Add an uncommit command, which is exactly the opposite of 'stg
> commit'.

Applied with two minor modifications. See below:

> --- a/stgit/commands/commit.py
> +++ b/stgit/commands/commit.py
> @@ -28,8 +28,9 @@ usage =3D """%prog [options]
>  Merge the applied patches into the base of the current stack and
>  remove them from the series while advancing the base.
> =20
> -Use this command only if you want to permanently store the applied
> -patches and no longer manage them with StGIT."""
> +Use this command if you want to permanently store the applied patche=
s
> +and no longer manage them with StGIT. If you should change your mind
> +later, use 'stg uncommit'."""

I removed this change because, even if uncommit does the opposite of
commit does, the intended use is not to use commit/uncommit in pairs.

> diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
> new file mode 100644
> index 0000000..4ac0dfb
> --- /dev/null
> +++ b/stgit/commands/uncommit.py
> @@ -0,0 +1,80 @@
> +__copyright__ =3D """
> +Copyright (C) 2006, Catalin Marinas <catalin.marinas@gmail.com>

I added your name on the copyright since this is a new file.

Thanks,

Catalin
