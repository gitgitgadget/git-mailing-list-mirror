Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D6720248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCTBPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:15:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37800 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCTBPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:15:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so877844wro.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uFQPW35fCtKTMKAlLAdCCHkyOw+XCPPI+mc+FGAuY9U=;
        b=ayfXQDRR+cUrOqtQZPzY2ThaGIUBaFksUv0rA5mlqKRf88v2NzmxYQhIgBnM0LIvpN
         /+5Cz+Sr4dUf/fCxik6UyfE/xZOJdPyXJ84IIrb3VtpPrIPpbfnBb7NvxUEX/XZrTaPy
         Szs0VYtqplLl2gSbI9OrnxDrw7Chq3wxTWA++hZryXnqImDrMCU9BrMgG+dIY4+uWU+y
         jwD3fgEvCCMZ+5XqYNd+RQ1DZ3Tg2BAUfR2PM02LnN/Uy1afS/NlDIEHLZEH1+uPFnYf
         Onb38BS/jmbcWmVxEPPnGogca5v5Sh0RC3TCFTs4+ck8sUoxTwM5Kv9U8J7Kvoi/3PXh
         6Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uFQPW35fCtKTMKAlLAdCCHkyOw+XCPPI+mc+FGAuY9U=;
        b=OdpHOWQb5+P5YufD1bfAiW/zNxEy4G0O5ybMFwgCgBegIEs9SWqTCOVf9EzLwncdIy
         P3kVOODYNLkLSOUBsBtytZW14186bqrm+m1WSPPh5/F4qsLBw5jbLZ33v5tf6Mfy/bhc
         wC9VyeNOUTFgiJM5110bVuKjTmmVY8+hwO3b6MGpBrXS6E1nQ3hj6M3paKDRYh1LAVQ2
         kHcHbyHClL3faSt11n6E9Fg5Qvhd27q9+mCsdE7PIQuOenUIGwtLct1eqiNjrKLHFxkF
         D3Gl+AcoTdRNUFPtuiB4P3U47kVJUDcvHlWZG2D8WRjXl6tiIkxdnDeEMX9Irr/Vq/vh
         P36A==
X-Gm-Message-State: APjAAAXV+5/TMKRuBeyYCdBg/u+s31EaDEcY3ieZlrz3G06FmLjaUmsQ
        JuxHU+XlvK2/VkmwYhPbsQs=
X-Google-Smtp-Source: APXvYqyMzeYfC/svoXCpz/I6ezXRiKzTt9YxVo8KlC2r6ikAIGpPMLGDUE0j3q+plpDyaeXvSf6A8Q==
X-Received: by 2002:a5d:5703:: with SMTP id a3mr12848896wrv.175.1553044549669;
        Tue, 19 Mar 2019 18:15:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x22sm559574wmc.19.2019.03.19.18.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:15:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dave Huseby <dhuseby@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] t/lib-gpg.sh: fix GPG keyring import options
References: <20190319232013.t5pmbgfgojjbczqh@localhost>
Date:   Wed, 20 Mar 2019 10:15:48 +0900
In-Reply-To: <20190319232013.t5pmbgfgojjbczqh@localhost> (Dave Huseby's
        message of "Tue, 19 Mar 2019 16:20:13 -0700")
Message-ID: <xmqqo966wdkr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby <dhuseby@linuxfoundation.org> writes:

> Fix the way GPG keyrings are imported during testing to prevent GPG from 
> prompting for approval to change the default config. This appears to have no
> adverse affects on GPG users with "normal" configurations but fixes the
> always-interactive prompting I see with my multi-keyring setup.

I do not quite follow.  If you are personally setting "always
interactive" somehow, would it be possible to solve the issue more
directly by unsetting "always interactive" here?  After all, the
"${GNUPGHOME}" we see in the test helper library is not referring to
your setting but our throw-away setting used only during the test,
so...

> v2: fixed the whitespace.

This line goes below "---"

>
> Signed-off-by: Dave Huseby <dhuseby@linuxfoundation.org>
> ---
>  t/lib-gpg.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 8d28652b72..e72e0554f1 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -32,8 +32,8 @@ then
>  		GNUPGHOME="$(pwd)/gpghome" &&
>  		export GNUPGHOME &&
>  		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> -		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
> -			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
> +		gpg --import-options merge-only --homedir "${GNUPGHOME}" 2>/dev/null \
> +			--import "$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&

This patch, without any explanation in the proposed log message,
gives an impression that '--import-options merge-only' somehow must
be inserted before '--homedir "${GNUPGHOME}"'.  If that is truly
required, the reason why it must be done before --homedir needs to
be explained in the log message.  If not, inserting before --homedir
is making the patch unnecessarily misleading.  If the lines were
like so:

-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+		gpg --homedir "${GNUPGHOME}" 2>/dev/null \
+			--import-options merge-only \
+			--import "$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&

the patch wouldn't have forced readers wonder why the new option
has to come first.

But as I said earlier, there needs a better explanation why it helps
to have --import-options to squelch prompts---the cause-effect linkage
is a bit too weak to make a convincing case to support why this is
the right fix to a problem worth fixing.

Thanks.

>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
>  			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
>  		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
