Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A1A20401
	for <e@80x24.org>; Mon, 19 Jun 2017 03:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbdFSDCt (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 23:02:49 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:32837 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbdFSDCs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 23:02:48 -0400
Received: by mail-io0-f170.google.com with SMTP id t87so55917873ioe.0
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 20:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u38v9JRfNOkqWdtpaArr7aC/+GWeaivw+N8xmZrGoo4=;
        b=gv4t9q0rP8n3l43NevEpwv0eM/dsCyuBgbt1jZsCb2f/8NTxl+ZyGv/4af85+F6s86
         c1Fj1t7Z9XXXQ29BN3AcBdvgU/AodI31wC2yxypVC3hVOYz9rbTVKGs1jLKMv1uwVkok
         wEKifoRGeqIZeXyRy1tbzEKwGZBg78lFnYt+2C7QMt7ri+0qZ3zbvCybKqdy1JMJNQdN
         fpoZfVOBYSBoDcq5A6KQDut3om7j19vjLZ9eQ88zcpjOtwkfhFyyANtuqvjp80ASRwsy
         UyR5gJVTNndrnqpwOqnyKiUAjwEG9nl4W3wr++hE3+MMIytuFskhJCxpTsBXLX53yfSD
         L2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u38v9JRfNOkqWdtpaArr7aC/+GWeaivw+N8xmZrGoo4=;
        b=LIFHQiTrRvjBztWD6d/drujieDttsP4iCmDAGWOoJYepaUavb5X5QqqhvCv34XGYsu
         VGGPtOV3QOmNxQssGzrKYQxQ2SRVeIFbiYYsFvTGJJoIY782pIqqjzcdmcoUZca557C/
         1bt6k/mSxwomxVV7+WPlv0WvxPLj03a0/RTER0suemt70Rl9vWGKBlCT+zr+K86Vs7DV
         pqpZOFxShUp6lLPlQWT7d5DpMcFj5+Mpc0tCWpUCDMzY0u2azw+c6uitU9WrrFHJ40S0
         rSmkurcVKRK8L3e4Mn+k+2/vQ4KJWIZDiPSD8uFe2spfX1PbEGKKeKTLivPH1nAT9dLz
         wrMQ==
X-Gm-Message-State: AKS2vOyxWymIoAt5lOlnZ75P4JQelfOz+IgWn3Qk7Hi3RZCebXq/t88W
        o7FMopUPgyNtShHXMUR46Rbt91onuQ==
X-Received: by 10.107.181.22 with SMTP id e22mr22562663iof.85.1497841367635;
 Sun, 18 Jun 2017 20:02:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Sun, 18 Jun 2017 20:02:07 -0700 (PDT)
In-Reply-To: <20170619021033.22968-1-davvid@gmail.com>
References: <20170619021033.22968-1-davvid@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sun, 18 Jun 2017 23:02:07 -0400
Message-ID: <CAJZjrdV5k2nUm3SRrA-AqQ=fJBm1CeLc1VLmGkWL1Wh+p9MNDg@mail.gmail.com>
Subject: Re: [PATCH v3] mergetools/meld: improve compatibiilty with Meld on
 macOS X
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 10:10 PM, David Aguilar <davvid@gmail.com> wrote:
> The macOS X fork of Meld[1] requires a "=" in the "--output"
> argument, as it uses a wrapper[2] script that munges the
> "--output" argument before calling into the common "meld"
> script.
>
> The macOS X wrapper script[2] accepts "--output=<filename>"
> only, despite the fact that the underlying meld code accepts
> both "--output <filename" and "--output=<filename>"[3].
>
> All versions of meld which accept "--output" accept it in
> the "--output=<filename>" form, so use "--output=<file>" for
> maximum compatibility.

Aha, then if that's the case this looks fine to me. Thanks!

> [1] https://github.com/yousseb/meld
> [2] https://github.com/yousseb/meld/blob/master/osx/Meld
> [3] https://github.com/yousseb/meld/issues/42
>
> Reported-by: Matthew Groth <mgroth49@gmail.com>
> Helped-by: Samuel Lijin <sxlijin@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> I cloned the meld repo and could not find the code reported in the original
> issue, but I did find that same exact code existed in a macOS fork.
>
> After more investigation, this turned out to be a macOS-only issue.  The
> commit message has been updated to better reflect what's really going on.
>
>  mergetools/meld | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergetools/meld b/mergetools/meld
> index bc178e8882..7a08470f88 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -10,7 +10,7 @@ merge_cmd () {
>
>         if test "$meld_has_output_option" = true
>         then
> -               "$merge_tool_path" --output "$MERGED" \
> +               "$merge_tool_path" --output="$MERGED" \
>                         "$LOCAL" "$BASE" "$REMOTE"
>         else
>                 "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> --
> 2.13.1.453.gc0395165f3
>
