From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: contrib/diff-highlight: stop hard-coding perl location
Date: Mon, 22 Feb 2016 00:56:58 -0500
Message-ID: <CAPig+cSE77JbD9CShrxnFsDLd9DrG9L15BSecERk_Qih9CMOig@mail.gmail.com>
References: <CA+boQ6YWWkudgwC7zn-3UPWqfkw+uJZgwcBWcGvJDcCUakjzHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Peter Dave Hello <hsu@peterdavehello.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 06:57:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXjUU-0004KP-OC
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 06:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbcBVF47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 00:56:59 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:32805 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbcBVF46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 00:56:58 -0500
Received: by mail-vk0-f45.google.com with SMTP id k196so121576585vka.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 21:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JxakNqCgnFXik6ZCAsnpUvjODeOLtRSBjxlpd4/w26Q=;
        b=sEMZdbcazAMYFKu5593XnikMt+xVv6EcNueWIxJ75J/2hiFOtyxhUlcllrn9TKhzjR
         8V0Dz029J+sX/GnB33TBKyNuaIe/iE/5LIQpNaV6TjGiUaJjydhBAUtu18Q0YuELPwGo
         xlDHslQm+UYdp2HTknSuuNlhAfD+g48ojULFAkftTvGP7VQUf8laF6b9Apuym1gxUFMI
         44PGLnCl2UiDp+8MQxtDwhzMJVS787yVSK507ZFADUWhpQ1CeRbR5MLYoNkazX87gXm4
         BhfbiUdl91q4GiXVoEySA5+vR6OuKpqgUATjkOzXdZY/Rk+EwxmqA3jLXcfHBqHz0e9S
         /W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JxakNqCgnFXik6ZCAsnpUvjODeOLtRSBjxlpd4/w26Q=;
        b=mMaxFsmH6FnEsu/PGxGchDeA5Slv8C25kQ/REGGhkvB4y41KW9LaxMhnvQZwwveGJQ
         Ktj+9AY8AqncM+1NcIdf99sKr1hnyBZXW+dTp8qeGumYPHqtJubHpMNjitopceRWWl0w
         i0XYbvTNBvuSl8h2HURSikr3y19cWDNylWoLBBZDjwNbNF3uRW8UFJmFkafg1XwtJvPe
         9c74GJYsP8thvXjJbYdSQz7UHtmtXLtSfs5WzLu7kPEC9kvel6OPKlFXyiY1zy8yOnJw
         ogC9fcfyvLSoWDz9Pefbkr8tUUZmkWQoYYMRNLe3HWvCWwjp/WZ/oQZDL3Jv+mdnv22Y
         S1Gg==
X-Gm-Message-State: AG10YOT+3BSAl8LXDQ8gomDit4xxm129cGAeCf6CLJXj1vpe/PV2Fq1cmfq4o+HQz5cdAyMbbKcIogX2PbjE4w==
X-Received: by 10.31.141.2 with SMTP id p2mr22132593vkd.37.1456120618234; Sun,
 21 Feb 2016 21:56:58 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 21:56:58 -0800 (PST)
In-Reply-To: <CA+boQ6YWWkudgwC7zn-3UPWqfkw+uJZgwcBWcGvJDcCUakjzHA@mail.gmail.com>
X-Google-Sender-Auth: AeSVQc8sNKtV9YKru18cZvKJzPE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286883>

On Mon, Feb 22, 2016 at 12:54 AM, Peter Dave Hello
<hsu@peterdavehello.org> wrote:
> From: Peter Dave Hello <hsu@peterdavehello.org>
>
> Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`,
> the util "env" can help located the "perl",
> so that it can work on FreeBSD and other platforms.
>
> Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>

Better, thanks.

> ---
>  contrib/diff-highlight/diff-highlight | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/diff-highlight/diff-highlight
> b/contrib/diff-highlight/diff-highlight
> index ffefc31..b57b0fd 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -1,4 +1,4 @@
> -#!/usr/bin/perl
> +#!/usr/bin/env perl
>
>  use 5.008;
>  use warnings FATAL => 'all';
