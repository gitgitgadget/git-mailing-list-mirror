From: Martijn van Oosterhout <kleptog@gmail.com>
Subject: Re: git filter-branch --prune-empty not removing commits
Date: Fri, 8 Feb 2013 17:53:24 +0100
Message-ID: <CADWG95skLryj0gxSzmxviP1E=9T8oN0r64gpu3_7P6qMZkDq_g@mail.gmail.com>
References: <CADWG95sHx6Z2Ukon8FAHKa1qUOj4shd4MbCwahwX++FVWJPDDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rCv-0002lJ-DA
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 17:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946614Ab3BHQx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 11:53:26 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:51808 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946584Ab3BHQxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 11:53:25 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so3153799lbb.12
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 08:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=AdSlmdmZEJu5mM0A+Fe0aA0CK76LpRMXFbIP2vjkj2I=;
        b=iMutb155UwI/8UpD/U1Otkzfg+lJhQPVZmhnyUvTUmjK2a/wypiwTsVJTq5mHFx1nX
         iO2KRq5x0PlHAzJ/MwRnMYIcnj0AnD34vTATCzFJLCbAUGcsqP6bKGBijU3HLNTWZITz
         yu8x4vBWy61dN1y+8wjhm5qpurN08bT7fvBXPd6M+8JGtR6WuSJBmB4P5UwgWQ7A0aDC
         PFvwPkXb1+rGJ5MUBSyVNBV77pa2xoFJfGcW+H0T0Q+F35/sy+TpxBTvgY6kl/AQfOqd
         QJVfwpVUPHAH7TEzxap2FKuFlwLnhuy8rN7fIuG8CV84MWZTNFMzSgoxpkAnzgtulizE
         LU4w==
X-Received: by 10.112.84.228 with SMTP id c4mr2481088lbz.113.1360342404254;
 Fri, 08 Feb 2013 08:53:24 -0800 (PST)
Received: by 10.114.16.35 with HTTP; Fri, 8 Feb 2013 08:53:24 -0800 (PST)
In-Reply-To: <CADWG95sHx6Z2Ukon8FAHKa1qUOj4shd4MbCwahwX++FVWJPDDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215780>

On 8 February 2013 16:23, Martijn van Oosterhout <kleptog@gmail.com> wrote:
>  git_commit_non_empty_tree()
>  {
> +        if test $# = 1 && test -z "$(git ls-tree $1)" ; then
> +                skip_commit "$@"
> +        fi
>          if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
>                  map "$3"
>          else
>                  git commit-tree "$@"
>          fi
>  }

This bit is a but bunk, the fi should be an else, otherwise it does nothing.

Have a nice day,
-- 
Martijn van Oosterhout <kleptog@gmail.com> http://svana.org/kleptog/
