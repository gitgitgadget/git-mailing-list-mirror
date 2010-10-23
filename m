From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in
 non-trivial places
Date: Sat, 23 Oct 2010 13:44:29 -0500
Message-ID: <20101023184429.GG21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9j8k-0007Vs-6W
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175Ab0JWSsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:48:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52372 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619Ab0JWSsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:48:20 -0400
Received: by gyg4 with SMTP id 4so1344464gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PsDXlA0a4/FUBgSfRM2GYronDTCus92rHg+fdbYEKyI=;
        b=qbfYjKqERA0fZKvWyacoCzjNBzV/rQcLqOrgNPEOJ7entuk1tnJ78BcHHSzQMV574A
         2FT1kqlBAuKXa675gaPZfx9TOMCaojvPwWvl4dbXN1Z5dT095SZqrg9i5nVKCnicbBxb
         8QOPgLuEwmyTJ6BlYzcqYegfUBIq11FhDVMBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WokiNJ3MVRN/Dp4fH1z3nkm7Ev5SZ7mTKhLC+s2M3I0txcwNvH7BzrCq6tFEdBN0B0
         xtw3kjAYhv0I7CZ11uNyF3Zp97dFhoF5Qh3+1nGdF2U38bVKEE/Zij52Wik0k8IJW0ni
         psidm3KYGvuYFHGAbl6CYZUOIaa8JXcGOxEOM=
Received: by 10.150.213.7 with SMTP id l7mr9074048ybg.235.1287859699596;
        Sat, 23 Oct 2010 11:48:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q4sm994291yba.14.2010.10.23.11.48.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:48:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-4-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159809>

Matthieu Moy wrote:

> --- a/Documentation/everyday.txt
> +++ b/Documentation/everyday.txt
> @@ -180,12 +180,12 @@ directory; clone from it to start a repository on the satellite
>  machine.
>  <2> clone sets these configuration variables by default.
>  It arranges `git pull` to fetch and store the branches of mothership
> -machine to local `remotes/origin/*` tracking branches.
> +machine to local `remotes/origin/*` remote-tracking branches.

I find this scans better as "tracking branches", but consistent use of
jargon might trump that.  Maybe it could be reworded somehow?

	<2> clone sets these configuration variables by default.
	They arrange for `git pull` to fetch and store the branches
	of the mothership machine to local `remotes/origin/*` tracking
	refs.

Not sure.  remotes/origin/* are not branches for local development, so
calling them "branches" without a "remote-tracking" caveat can be
confusing.

> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -89,7 +89,7 @@ are not part of the current project most users will want to expire
>  them sooner.  This option defaults to '30 days'.
>  
>  The above two configuration variables can be given to a pattern.  For
> -example, this sets non-default expiry values only to remote tracking
> +example, this sets non-default expiry values only to remote-tracking
>  branches:

The rest of the changes in this patch would have been caught by the
"perl -pi ..." command, except line wrapping got in the way.  They are
obviously good.
