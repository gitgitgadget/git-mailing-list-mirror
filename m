From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 18:10:59 +0100
Message-ID: <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xfu-0006wH-AW
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab3AaRLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:11:22 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:32874 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab3AaRLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:11:21 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so3111518obc.19
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 09:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6n0qH+bpBJHR06linqdClW0v1MpQf5pJFzNEwhBoaqA=;
        b=tOIIvJjcvkLsyGSwFuJx2MVTgQjLMTl7ydYYE6gwyi+0aXs6U8R6QHXnWbUJzvtjn8
         zjNg/eGwguHedy4nFA4Bg/GrgHQ5e2tyXFJUqyFeXWB04aW4aheewvpl9P40UKV1bFdI
         gdp2m8M4GBcpumR7PbfwjiYNv9hPPYwzwIbgQ6rYGgQZ93Uyf0mNbIfokpGwjBpIvrnS
         /4Yu9KB8C8Rdsn9v3NpoGaBMXsXqyIlcqRbZ1o5vDz7OGVwQp7Z/Hv9Kg7k4OJD283jB
         zVw0nZPZCoRrCrYBtoROXQQukaynjt0/it3Pc1ZFsS4nDQPZ1r6aoUFrQBZzjtkqV24c
         iy6g==
X-Received: by 10.60.7.167 with SMTP id k7mr7413904oea.20.1359652280091; Thu,
 31 Jan 2013 09:11:20 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Thu, 31 Jan 2013 09:10:59 -0800 (PST)
In-Reply-To: <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215128>

On Mon, Apr 23, 2012 at 10:37 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> It's been deprecated since 53c4031 (Johan Herland, Wed Feb 16 2011,
> push.default: Rename 'tracking' to 'upstream'), so it's OK to remove it
> from documentation (even though it's still supported) to make the
> explanations more readable.

I don't think this was a good move for the documentation. Now every
time I find an old repo with "push.default=tracking" I end up
wondering what it was a synonym for again, and other users who don't
know what it does will just assume it's an invalid value or something.

We can't treat existing config values we still support as any other
deprecated feature. They still exist in files we have no control over,
and in people's brains who are reading "man git-config" trying to
remember what it meant.

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Feel free to squash into previous one if needed.
>
>  Documentation/config.txt |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e38fab1..ddf6043 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1693,7 +1693,6 @@ push.default::
>    makes `git push` and `git pull` symmetrical in the sense that `push`
>    will update the same remote ref as the one which is merged by
>    `git pull`.
> -* `tracking` - deprecated synonym for `upstream`.
>  * `current` - push the current branch to a branch of the same name.
>    +
>    The `current` and `upstream` modes are for those who want to
> --
> 1.7.10.234.ge65dd.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
