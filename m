From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 21/25] fetch: define shallow boundary with --shallow-exclude
Date: Thu, 18 Feb 2016 20:35:54 -0500
Message-ID: <CAPig+cRHOKkaGmSRioEqYYmWzDazNinq2owwYmKyQwOFDLvjig@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-22-git-send-email-pclouds@gmail.com>
	<CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
	<CACsJy8B=p0frmU8ahc9bnk-uoDPNUT_6UB0MVRPiLc9DqNz3vQ@mail.gmail.com>
	<CAPig+cR01WCgyJQuDcq-j5Z6u3S-LO5kUVuT+g-jdu-hoH-5yw@mail.gmail.com>
	<20160215081539.GA12609@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 02:36:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWZzj-0000W5-9S
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 02:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948121AbcBSBf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 20:35:57 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33911 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948102AbcBSBfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 20:35:55 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so61639044vkb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 17:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Qf1URTlEZNX8B16TprFJ64atSlF+fWEsBQav5jea/QM=;
        b=G6/v+cISUgnYG0m2FZjSwDroTqwJQiMi8Y1/EwxvGhvLv15tzkQApY2/BHf/4QBuGI
         fJ/m0A+/A/a7ujRRIX8oW5vNvK2Qrv8KEJsXD/bluFBFsIy1JY9bZqf9ujNzOm6b7uvl
         u95u4ErGzpcNBsiemxCsehCT++KlFT2Ovw4ASjI8jH/01wKnNRoHW5hxjtlM1RsCgW0m
         iU7FiQCA75sP53hBdSmCM/1/+bJF6ieWZfqSf852jQ+6YqNhfde0SrIzRIeSCsMe8lbZ
         DMcIeRso73n8edprQ4pxLjnHBerzOQUysV9dcHMosFLNjyCmwscIUrH4ST8xfr0BILPP
         n7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qf1URTlEZNX8B16TprFJ64atSlF+fWEsBQav5jea/QM=;
        b=HukYAKLclaaQyBEiKvSeSQAsCoS5veZQD+2aJBVzf7TE6Qsa+c8vtX7SJbvoJmqGbR
         YNX5sVvH4FVQhtrjQ6qokXVBbbvISSZ9Mbia3vGbqcQ2ROAPOVtI3uBzlaiWvFKjwvl7
         Vm6ETa23WVndFRZTmJCtaIUwGnv0unR1c7MJ0sJtjd9uNs0QY1+I1eTjZUrCD6am3vOg
         XBGW6rgqDHEY+oAURPcwMQZLiHq+LCvLaW/hr7fSDZdyvg+r3LH8KXjZKf7QKh3Gosp4
         qhORxu+S2tWxX/e/jV9BOqFULYt8SS8dsjkkdAdrxLLuhp1dLHJmV4Qr+PPoOZDdwF53
         fWLg==
X-Gm-Message-State: AG10YOR/WqWVjAKce+76bYvUpI5LmmfzCGtfNYTW493r3uhMCCGOcZlFAp8w53B10rLwcq3kcoqYvdNBZYhWuQ==
X-Received: by 10.31.182.143 with SMTP id g137mr8744461vkf.45.1455845754769;
 Thu, 18 Feb 2016 17:35:54 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 18 Feb 2016 17:35:54 -0800 (PST)
In-Reply-To: <20160215081539.GA12609@lanh>
X-Google-Sender-Auth: wLgJAFQSjQADAg95O4jFwntXSKs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286652>

On Mon, Feb 15, 2016 at 3:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 15, 2016 at 12:52:26AM -0500, Eric Sunshine wrote:
>> Yes, dropping 'const' was implied. I didn't examine it too deeply, but
>> it did not appear as if there would be any major fallout from dropping
>> 'const'. It feels a bit cleaner to keep it all self-contained than to
>> have that somewhat oddball static string_list*, but it's not such a
>> big deal that I'd insist upon a rewrite.
>
> Dropping 'const' is not a big deal. But before we do that, how about
> this instead? I think the code looks better, and the compiler can
> still catch invalid updates to deepen_not.

I like this better, too.

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 0402e27..07570be 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -50,6 +50,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>         struct child_process *conn;
>         struct fetch_pack_args args;
>         struct sha1_array shallow = SHA1_ARRAY_INIT;
> +       struct string_list deepen_not = STRING_LIST_INIT_DUP;
>
>         packet_trace_identity("fetch-pack");
>
> @@ -108,6 +109,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>                         args.deepen_since = xstrdup(arg);
>                         continue;
>                 }
> +               if (skip_prefix(arg, "--shallow-exclude=", &arg)) {
> +                       string_list_append(&deepen_not, arg);
> +                       continue;
> +               }
>                 if (!strcmp("--no-progress", arg)) {
>                         args.no_progress = 1;
>                         continue;
> @@ -135,6 +140,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>                 }
>                 usage(fetch_pack_usage);
>         }
> +       if (deepen_not.nr)
> +               args.deepen_not = &deepen_not;
>
>         if (i < argc)
>                 dest = argv[i++];
> --
> Duy
