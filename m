Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF7C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiGKL1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGKL1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:27:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B271729
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:04:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so4430678pgb.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3i42qct7wNmt/XvGVw0k3Tpq4Z/9jZjuaEOkjTAXfM4=;
        b=FDDCCs+80oPTo9lw3YabjAnQMvEhDi3nqg0Xem8/PhKgHESg/jRWIdPwbd9EjV+4Jq
         UKkUO36KmN9dD1CtmPObPmL4g+Wi5BBx9mMPvSyTAVeQUCWIKdsB33eAdfG8UXNT+7p1
         mkWDEjuK55zFjWLzuR0MUZvccVnSwIaQ+AgmN6qn6tIyjmQ9O6HztZgxUncG9ZR1DvWW
         R84DUnuFJu0Dis+YaeUYZNZ7CjGhWo3c/Q3/NpC/kShVKR+bWIOvpktfzZ9nYEZkv0JU
         wcmBUW8FNEJB69dJfSyJXBRtuLSXxWpmqKOpLudAGEbUxOkzEN0hWeBgi9V/irFPFCcg
         A+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3i42qct7wNmt/XvGVw0k3Tpq4Z/9jZjuaEOkjTAXfM4=;
        b=y74oGB8O+3/skPFYWr9bwsetMtLxZ1eiGm4GbGU2EYrqzENr1WmLjKbIhkhYfBDVjJ
         mMDfMQvU0ifVeBTjS4mDX+RTxBPThyvJJGpVkK5S430VHYcF9vjCR7enUlGG/DmXX82L
         erFNQ7ermNEcZiscC8V2L0ENfGaB4cvQAO7cEqP1XusgvVF9Wscqwy/V5G7ba2DWXyGq
         e2sLp/AFuxqKrSAfqDnE49ArZWY3RVfH8TQfSJlV9oo/QK2HQ16oxqbwbVMkgCRqVUpc
         vWFGOzP6rXECSq1kO050YwggRAwuyudDNJaMvgq3Bakn4cOSaChPOl078YqRaH2l4CGe
         Hnig==
X-Gm-Message-State: AJIora9t4E8vw0NploulTMOphMtiCDMvjbC0uyxzfvKSLcpJW2RZLPjN
        D6Ltn+p18Tm2VCL5g38ZGKHSxwGbfXw=
X-Google-Smtp-Source: AGRyM1uqqsAGZ2UZm8IF7CzD9ioNVmnT2ikmv05GjNg/zvGQM5sKgmm+9hV1UCUTwJ8i2Ph9hzS+ag==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr15749397pgw.599.1657537454437;
        Mon, 11 Jul 2022 04:04:14 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id lj1-20020a17090b344100b001e87bd6f6c2sm6732708pjb.50.2022.07.11.04.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:04:14 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
Date:   Mon, 11 Jul 2022 19:04:03 +0800
Message-Id: <20220711110403.47391-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <xmqq8rp43m7v.fsf@gitster.g>
References: <xmqq8rp43m7v.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To retrieve is to get/bring something back and regaining possession
> of, which implies that the thing existed somewhere already but at a
> wrong/different place, and the only thing you are doing is to move
> it to the right place, but in this case, the translations did not
> exist.  The patch is marking more strings for translation.  And the
> act of marking them for translation will cause i18n/l10n folks to
> translate these strings, which will (finally) allow _("...") to
> retrieve the translated strings at runtime.
>
> So "retrieve" is indeed involved somewhere in the process, but using
> the verb skips a few steps.
>
>     Subject: [PATCH 4/5] pack-bitmap.c: mark more strings for translations
>
> perhaps?

Yes. The explanation is clear.


> Sorry, but I am not sure what you are asking.  What I meant is that
> a hunk like this from the patch in discussion:
> 
>  	if (bitmap_size < 0) {
> -		error("Failed to load bitmap index (corrupted?)");
> +		error(_("Failed to load bitmap index (corrupted?)"));
>  		ewah_pool_free(b);
>  		return NULL;
>  	}
> 
> makes translators to first translate the above string, but we will
> fix the "C" locale version (that is, the string inside _() that is
> used as the key to the .po database when retrieving the translated
> version) to follow our error message formatting convention to read
> something like
> 
> 	error(_("failed to load bitmap index (corrupted?)"));
> 
> or even
> 
> 	error(_("failed to load bitmap index (corrupted?): '%s'"),
> 	      filename);
> 
> And the translators have to redo the work.  If a preliminary patch
> fixed these up before bothering translators with more strings to
> translate, they do not need to translate the current, known to be
> faulty, version of messages.

Yes. I understand a bit of that, maybe.  So, if the string is not C locale,
translator will redo because it cannot be a translate key. Another scence is,
if the string is not following the guideline like capitalized first letter,
translator will redo too, we should avoid that. 

> In practice, yes, but the code is following the convention to reduce
> common confusion caused by leaving some lower precedence but common
> environment variables (i.e. LANG) as their original values.

OK.

> Does the line in the completion script have anything to do with
> [PATCH 4/5], or is this merely your curiosity?  Avoid mixing in
> unrelated things into the topic, which will only make the review
> cycle unnecessarily longer, but raise a separate discussion if you
> have to.

Curiosity. 
Sorry for that, I will raise a separate one next time.

Thanks.
