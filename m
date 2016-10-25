Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4652022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965563AbcJYK4h (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:56:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36093 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbcJYK4g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:56:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id e12so6369465oib.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PdXtw/iWkFddkj6MYg/eawoeHTVujurKuG2zkjasdQU=;
        b=WPvGTaqjJ6OqSSEpdVwHSkMsLrXnFyQEX94bbQ4Q+HKIkW5ya7M2RfCUIC3+Dsslfw
         H7wzLCDjuHeexNW9ozMMzqZh3AtvsIOiqvkavGaBsZTvxMSzU/jjx01Uzd+KummB+jHm
         rcZg2X4ufCM+F1c8uPoQ1ar0s2sDgu9dK0rYs4Q+5fFf8lAxTHPaZ1Dxs4Ca8rQ9UfLt
         5vRGpwseeqZ73hXneUM5dtivo28edM/gO1RXrAEovidM3D4C5TWAOy4S3inA4PlXo6Vg
         15WWl3A8VPTpXTqSDWGkQUWQiKKmnRMYkdWoosmqmEiG/emTu2JNWkLgru7FIE+CjkRj
         Y3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PdXtw/iWkFddkj6MYg/eawoeHTVujurKuG2zkjasdQU=;
        b=FG8gd7+UL8BKBPDWaVPROwSheBY/gV8xc/l/IKblkMoGevxgMTH9qvI0E4noB/9Q3f
         2EffAzSr2/hAugJh9I8m7c3JAwRstgX5pxJyeG3ON60REI37lS16yBkT6WRbNrYnKtkY
         w4U8JUifwZY+Dsg1pOx1hzVKLe8y8lmRBbDqNF6K3OR610U1UAM6qsPIjcrksHdCK6ol
         ViFIO8q79XSOk68QhWagYMOcCJtl0FEY0e4kQ/1JVMbQOdNUFbY+yHr0dP/L5L+XORol
         gKzNeNIWDjErGdapqSX3Y24UCqhZadyAJQpinVewWKarLy/OucJsjhiKjM3liBkTGrNb
         KN9Q==
X-Gm-Message-State: ABUngvdATHekSlDUNRMtZCa7dM58pzxYIICIVhXAu6l4TxqpBSDMg9wBH51pcltKaMbHSTg9aoLjfRFpqdHEUw==
X-Received: by 10.36.54.69 with SMTP id l66mr1101811itl.3.1477392256959; Tue,
 25 Oct 2016 03:44:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 03:43:46 -0700 (PDT)
In-Reply-To: <20161023092648.12086-17-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <20161023092648.12086-17-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 17:43:46 +0700
Message-ID: <CACsJy8C4Qd76LSYxk9BJtN3n3Knv_RCDgBOO-ybkNHFZK61ahQ@mail.gmail.com>
Subject: Re: [PATCH v1 16/19] read-cache: unlink old sharedindex files
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> +static int can_delete_shared_index(const char *shared_sha1_hex)
> +{
> +       struct stat st;
> +       unsigned long expiration;
> +       const char *shared_index = git_path("sharedindex.%s", shared_sha1_hex);
> +
> +       /* Check timestamp */
> +       expiration = get_shared_index_expire_date();
> +       if (!expiration)
> +               return 0;
> +       if (stat(shared_index, &st))
> +               return error_errno("could not stat '%s", shared_index);
> +       if (st.st_mtime > expiration)

I wonder if we should check ctime too, in case mtime is not reliable
(and ctime is less likely to be manipulated by user), just for extra
safety. If (st.st_mtime > expiration || st.st_ctime > expiration).

> +               return 0;
> +
> +       return 1;
> +}
> +
> +static void clean_shared_index_files(const char *current_hex)
> +{
> +       struct dirent *de;
> +       DIR *dir = opendir(get_git_dir());
> +
> +       if (!dir) {
> +               error_errno("unable to open git dir: %s", get_git_dir());

_()

> +               return;

Or just do "return error_errno(...)". The caller can ignore the return
value for now.

> +       }
> +
> +       while ((de = readdir(dir)) != NULL) {
> +               const char *sha1_hex;
> +               if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
> +                       continue;
> +               if (!strcmp(sha1_hex, current_hex))
> +                       continue;

Yeah.. make sure that the shared index linked to $GIT_DIR/index stay,
even if mtime is screwed up. I wonder if we should have the same
treatment for $GIT_DIR/index.lock though, as an extra safety measure.
If you call this function in write_locked_index, then
$GIT_DIR/index.lock is definitely there. Hmm.. maybe it _is_
current_hex, current_hex is not the value from $GIT_DIR/index...

> +               if (can_delete_shared_index(sha1_hex) > 0 &&
> +                   unlink(git_path("%s", de->d_name)))
> +                       error_errno("unable to unlink: %s", git_path("%s", de->d_name));

_()

>  static int write_shared_index(struct index_state *istate,
> @@ -2211,8 +2269,11 @@ static int write_shared_index(struct index_state *istate,
>         }
>         ret = rename_tempfile(&temporary_sharedindex,
>                               git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
> -       if (!ret)
> +       if (!ret) {
>                 hashcpy(si->base_sha1, si->base->sha1);
> +               clean_shared_index_files(sha1_to_hex(si->base->sha1));

This operation is technically garbage collection and should belong to
"git gc --auto", which is already called automatically in a few
places. Is it not called often enough that we need to do the cleaning
up right after a new shared index is created?
-- 
Duy
