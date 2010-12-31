From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: HTTP push not respecting .netrc
Date: Fri, 31 Dec 2010 12:03:24 +0800
Message-ID: <AANLkTi=4cE711TtqE0E-05s9Pk72C8OymNf_-5NhrfXS@mail.gmail.com>
References: <AANLkTik84-zRwi+0dGGFoTUrj6Zr3bxO=fE9P_3MuZdZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: David Borowitz <dave@bwitz.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 05:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYWDE-00009h-Gz
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 05:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab0LaED0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 23:03:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64468 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab0LaED0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 23:03:26 -0500
Received: by fxm20 with SMTP id 20so11643341fxm.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 20:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=lcIi/9ofOf3zBwqT235c9ErbCpkG+fxyTfQ0AEGAfKg=;
        b=rM73g1A1mUbnpRjhCkOiFGM289sWMlZVXmnzp92iMu/Wu+QGvcJ4jvIBzDtyJRs5rV
         ScX/az7Q/VJoHwleNtXhLSfJCnwwMRO1uj5+t70uyr4RBIX3/Y+yLGBpwajvs5v5xw5/
         ++PcZWlF0O71rQ44vpV7NxVBsm0Zua4KOxa8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QehPyVzA2ViPYafmteDaHytMiZKalNdnna+SDyLUCHko6itPcDmmHE3FOjRudrrZKU
         +WqyqL6pZ/gArQhJwZC0mwC0YH0FcJcbwxD+uYcl7axPvHfz/PcWt87ZtpccPyKFSk/Z
         ww4uvMAD+nE6IwsoE6Lvxz8T/QeGGXJjlcfyQ=
Received: by 10.223.74.11 with SMTP id s11mr578897faj.2.1293768204801; Thu, 30
 Dec 2010 20:03:24 -0800 (PST)
Received: by 10.223.123.18 with HTTP; Thu, 30 Dec 2010 20:03:24 -0800 (PST)
In-Reply-To: <AANLkTik84-zRwi+0dGGFoTUrj6Zr3bxO=fE9P_3MuZdZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164378>

On Thu, Dec 30, 2010 at 2:56 PM, David Borowitz <dave@bwitz.com> wrote:
> I'm trying to push to a smart HTTP remote using the following command line:
> http_proxy=localhost:4242 git push -v http://xxxxx:25989/git/foo
> +refs/heads/*:refs/heads/*
> (The weird proxy and port are not under my control.)
>
> The webserver should return 401 for unauthorized access, and indeed it does:
> error: RPC failed; result=65, HTTP code = 401
> (The rest of the error text from git push is not particularly useful,
> but I'm not worried about that at the moment.)

Could you run the push with the environment variable GIT_CURL_VERBOSE=1?

> [2]
> GET http://xxxxx:25989/git/foo/info/refs?service=git-receive-pack HTTP/1.1
> User-Agent: git/1.7.4.rc0
> Host: xxxxx:25989
> Accept: */*
> Proxy-Connection: Keep-Alive
> Pragma: no-cache

Try having a entry for xxxxx:25989 in your .netrc - that should be
sufficient to demonstrate to you that git+curl reads your .netrc.

-- 
Cheers,
Ray Chuan
