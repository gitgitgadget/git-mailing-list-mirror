From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSoC] git-compat-util.h:rewrite skip_prefix() as loop
Date: Sat, 1 Mar 2014 23:53:04 -0500
Message-ID: <CAPig+cRFbk8CzXrHrDgjweevns8+AJ+FuWZVa8zphwHz16=8Jg@mail.gmail.com>
References: <1393713731-55358-1-git-send-email-kyriakos.a.georgiou@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: kgeorgiou <kyriakos.a.georgiou@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 05:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJyPB-0004Al-9e
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 05:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbaCBExG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 23:53:06 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:58240 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaCBExF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 23:53:05 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so2453525yha.14
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 20:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2YT0QsBsH3aF6E/wx0ur57fa+7olak9i9mLK4zRrkzw=;
        b=olAjXkJLVgZ4DWPpfvB0rjiA7TWGkpBuLLfPCa5fnYix7A2ciFC6cNkkQZ851tnyb7
         dFZ/v6T7dCoabdOao6a3Fbf5ITFQ8G7N8EkITS3wnS+waCqR3XYpc1rPUm9KZPl5BGDX
         BYuhxC1pjEI+AmCIMljUrBw/Q6GJD5M5l70Gj5jJ87V9LKBqZHCebcYqOzpvAMDtDvUt
         jbZRC1m9oSj5uT8tH2NXSlD3cdbAkkzShtbySoZ3WU7DAt68+xH98WgILT5Yp2cW6aP0
         vfg2uDHpRcMmS6bukkWqoeR2i+En/HuOv/GzEEFJgVpXGBh0HzDWRc9sLfH6pm2vC2NU
         zbmA==
X-Received: by 10.236.207.73 with SMTP id m49mr13372845yho.5.1393735984420;
 Sat, 01 Mar 2014 20:53:04 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 20:53:04 -0800 (PST)
In-Reply-To: <1393713731-55358-1-git-send-email-kyriakos.a.georgiou@gmail.com>
X-Google-Sender-Auth: EcOgZlVfVc_xCe-FBEoeFWLmCe0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243131>

Thanks for the submission. Minor comments below to give you a taste of
what it's like to contribute to this project...

On Sat, Mar 1, 2014 at 5:42 PM, kgeorgiou <kyriakos.a.georgiou@gmail.com> wrote:
> Subject: git-compat-util.h:rewrite skip_prefix() as loop

Space after colon. You might be able to provide more information in
the short summary of the subject. Perhaps something like this:

    Subject: skip_prefix(): avoid scanning 'prefix' twice

> Rewritten git-compat-util.h:skip_prefix() as a loop, so that it doesn't have to
> scan through the prefix string twice as a miniproject for GSoC 2014.

Good description. In this project, use imperative tone:

    Rewrite skip_prefix() as loop...

> (I've just noticed that this miniproject has already been tackled by another
> contributor, if that's a problem I can pick something else.)

That's okay. The purpose of the miniprojects is for you to get a taste
of what it's like to contribute to this project and to understand what
will be expected of you as a GSoC student; and to give the GSoC
mentors a chance to judge your abilities and observe how you interact
with reviewers.

> Looking forward to any kind of feedback.
>
> - Kyriakos Georgiou

There are two types of information you want to convey to readers. (1)
Patch description, explanation, justification before the "---" line
which is recorded in the permanent project history. (2) Commentary
below the "---" line for readers of the patch but not of interest once
the patch is accepted officially. The "as a miniproject for GSoC" and
all lines following it are just commentary which should go below the
"---" line.

> Signed-off-by: kgeorgiou <kyriakos.a.georgiou@gmail.com>

This project prefers real names, so:

    Signed-off-by: Kyriakos Georgiou <...>

> ---
>  git-compat-util.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 614a5e9..713f37a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
>
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -       size_t len = strlen(prefix);
> -       return strncmp(str, prefix, len) ? NULL : str + len;
> +       while(*prefix && *str == *prefix) {

Style nit: space after 'while'.

> +               str++;
> +               prefix++;
> +       }
> +       return *prefix ? NULL : str;
>  }
>
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
> --
> 1.8.3.2
