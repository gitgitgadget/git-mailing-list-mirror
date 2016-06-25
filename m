Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFCB31FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 14:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbcFYO7m (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 10:59:42 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36759 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcFYO7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 10:59:41 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so5716409ith.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 07:59:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nVnyR5Xr5h96I8LD9gCApcFLyf+RnWX4H91OX/X0Nm0=;
        b=mNU91uHKyZfTMxaYbVVGzK4GxaHWrR2esh/fkNU8KE097KiAJ8GExKtSXRKqImtQtk
         IOy9pw9kCS3gSH3t8Y2/MZzYk5RrA7iqqa011yq8i2KaBmibber98HbKbCei0WCGoaPO
         GxpI9sKI2TgTZjT8I+QnT9WxAT9qt79v7BWgtq+OKyLrKm9y/LO/D3wRs0BMpeLuhLqO
         /AIcxAP87wbedlrrPPDOkpRoa38xLoHoUT6v8it1TJI99HXLHQYBz9caGDFrQOJxgJzU
         8by0HJWAttsedQCjexVrX5JdwJMX9doNsCTEhX+KY6zPpl7iRjJKtD9WXnrA8+fAI/5E
         8X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nVnyR5Xr5h96I8LD9gCApcFLyf+RnWX4H91OX/X0Nm0=;
        b=iZnHF7aVevJ8PG+2aK9362MrCCrdPgYTZZXqHmnhfFKACH3cucxGSQkeE+W5BrXbPt
         dQNsycMTYbHQQwhaIMkFgMsAaAZCr2OImHIQMdS+Bqba7LYTPONT0ERxtpER9uKrd9Zp
         WwGml/WiQXSq75cNHU6Qx99RoxyJRsQUDJ2Ciu8aDQapBTtS7pJ77ohTURyFH8gWP5mu
         outwc7KwptuZjAjLaeRnImhCh5papCfpNXgOU+aOOREgRdl/LKE5OrBzEtBFSxyfbJxq
         pHatZ+uGojtxdH7U1G75Kam0PIY6LpRp5szhQ1GvB3IsixpzWrvVa3lVki3xlZyD/Cre
         kRpQ==
X-Gm-Message-State: ALyK8tLZu18ZCC6VnUEFcf+FMgPdlSmJ+MMiF5MyP+ADtjAY8vWDv7OtjZBKGufOsbVbCW+DLLZqrjpyKAJZIg==
X-Received: by 10.36.81.15 with SMTP id s15mr2591683ita.57.1466866780476; Sat,
 25 Jun 2016 07:59:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 07:59:11 -0700 (PDT)
In-Reply-To: <1463694357-6503-10-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-10-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 16:59:11 +0200
Message-ID: <CACsJy8CG3y3VM-RgzV8G46BP5POqEV7vBa5uN-5GJq4gSEKx3A@mail.gmail.com>
Subject: Re: [PATCH v12 09/20] read-cache: add watchman 'WAMA' extension
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> @@ -1222,8 +1225,13 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>                         continue;
>
>                 new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
> -               if (new == ce)
> +               if (new == ce) {
> +                       if (ce->ce_flags & CE_WATCHMAN_DIRTY) {

I would add a note here since it took me a bit of time to understand
why we cleared this. Maybe something like this?

"The rule is index-helper sets watchman-dirty when a file is changed,
then git clears it when it has verified that in-index entry now
matches the worktree version. index-helper does not clear the bit and
git does not set it. We have verified here that stat info (and even
content) matches, so it's safe to clear watchman-dirty now"
-- 
Duy
