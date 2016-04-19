From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 6/6] tag -v: verfy directly rather than exec-ing verify-tag
Date: Tue, 19 Apr 2016 15:06:47 -0400
Message-ID: <CAPig+cQrnrO2+hzg5nc_uBbENOn1_JH1PfHYCg-ivZVTtYRvXg@mail.gmail.com>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
	<1461088041-19264-7-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaz7-00016t-2N
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929AbcDSTGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:06:49 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35695 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933452AbcDSTGs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:06:48 -0400
Received: by mail-ig0-f196.google.com with SMTP id fn8so3675077igb.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=6df5a9ZGWN2RDmnNkydjLhp9mv6U2i5/4DNvdq1B0r8=;
        b=bun7HjQc/W7MvHZiI5roLPg6F0PaK9EwP1/udSTYZ45wECHJVvFwV7/5n7v/MjVPrt
         HK3MQaGm03YUdEP3DxLVCYsikW6+0rRMpK0/rCdETHokuC8grGtxbB0WHErzsMyxq/oI
         GTT0w+3bQFJoNYjTgCB3NLS4IEbdoB50E14sLIINnQzE6osChTU6VAMYvS3rBb4UW5No
         +GqA6ST0BwbgvUhKS3gh0rTNjbaVITalKqIOoZxIGg3zv5Fyiir8DF4+JNtJHqTSSQbw
         +Ag0bLcoTa0ab3JopItp2cnhBLHEYVBMigJtGqq5ygntw2eeHgKAeUbwbZgkhOwJhs0L
         4BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6df5a9ZGWN2RDmnNkydjLhp9mv6U2i5/4DNvdq1B0r8=;
        b=QbnJOpI0dWIay4JMiOvDhQHA9eQ/51dh653854SH1U/ii9kQR2ty1rK+2uJhFkK2A7
         BwgGg0DtSGNqqpLRrkBs9965rtZy4oOU9ZYa9LnmZL38L7m+vpDS4fmMWavyxnoMF6i+
         DPu7/K8TD1RNYDYg7eoEBFrdneHSymKF5sQeUlypmoQLT512watu83+R1wlXqwR7CAIb
         rQ/v1avJg+4yFmu52dKnHluwV2H91unOR1wB17Wh2aEAweuWp9oVzk3djI2fhD01hrzt
         UtkZI6Kgl0EzkuJ/yLet7Ahrg/s/bcuAQH1VLGW6GqNe2aK2vRDHZ4OwC5AJaKPGdS99
         VK1g==
X-Gm-Message-State: AOPr4FVFT7ktE1SW3wOyI54dyFM3QCQNf1z/3GYg9ZD1MHzVLjvqeCZcb/hOr9Fes4gKTe+4QQM+/U1a4ItOLA==
X-Received: by 10.50.189.233 with SMTP id gl9mr25553999igc.73.1461092807164;
 Tue, 19 Apr 2016 12:06:47 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 19 Apr 2016 12:06:47 -0700 (PDT)
In-Reply-To: <1461088041-19264-7-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: jKf-Hi2EjZVhPDvNGgkAd4h721M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291907>

On Tue, Apr 19, 2016 at 1:47 PM,  <santiago@nyu.edu> wrote:
> tag -v: verfy directly rather than exec-ing verify-tag

s/verfy/verify:

> Instead of having tag -v fork to run verify-tag, use the
> gpg_verify_tag() function directly.

This description is easy enough to understand. Thanks.

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..7b2918e 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>                                 const unsigned char *sha1)
>  {
> -       const char *argv_verify_tag[] = {"verify-tag",
> -                                       "-v", "SHA1_HEX", NULL};
> -       argv_verify_tag[2] = sha1_to_hex(sha1);
> -
> -       if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
> -               return error(_("could not verify the tag '%s'"), name);
> -       return 0;
> +       return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
>  }
