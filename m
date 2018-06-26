Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D181F516
	for <e@80x24.org>; Tue, 26 Jun 2018 17:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeFZRIA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 13:08:00 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:56951 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeFZRH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 13:07:59 -0400
Received: by mail-yw0-f202.google.com with SMTP id l136-v6so13364766ywb.23
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=4bdcAJV1W08ExVhUuRakozJW5Uiukky9yk6Cu3bIXBA=;
        b=efn4PsjwsH9P0fLM8Mp6l/T7wsVlctdK2owpP7IZPt6qa2bwY20jz3edou7swW4NuD
         rDgMEUtq5j+pr3DGPMvBD1b/p82zlO6IKreZAcvGVvqMSj3UAmv0SPKQp5ZOBCD/agU6
         7d6DT6DezJAFlih1GPxP9xKIj0WDQb1F287bgzWaqXKDn1LHqxkE8paFvUMdcdKiUKPp
         feEAu0QQBLFbaKcwxmX2+JmCRtL5KCuiO3mG86N3cGnThnGfnGr0dipczqD7sPbU7oyd
         aTzO+CT3Xle6DAQshINtCHni4byeaZACZ5/N21ooY2u8dLNjsYWf/tNdSsyxmvf8Lqfc
         +s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=4bdcAJV1W08ExVhUuRakozJW5Uiukky9yk6Cu3bIXBA=;
        b=qigU3te+qY1hryJBpkkIciaHYw7m7clYVsFlUQOa1nqp14cXKoYUyJ/b2hAcEI2BWE
         1ZPZry8qjcTMwlT/0o0citBGRT9ZWGkpdyA/S6f8vG7OCzWUQ7Z7Bn0xW+yZnpvw7H9K
         f6QTJ4QFk0A78VmpRj5OB9PO4463xirprNZ4TQ7hDXfdpZCIfQyyYva29w9BMqK3b2em
         vPxdKyRt+X7B9I5BFo08HGCrh3JurZVOJMe+XE1u891HUMLAVcyP1fowPeBUUnkDDwDf
         yWUOAQZ1kNvhzkA5gfaXcTi212vktQwCmsaICISI8qR/gQgRDsW6gS8wVn71ufRcww/V
         f0aw==
X-Gm-Message-State: APt69E1HQVQdc5AaXb15PP1TgGCaLNWlEOXQWOC9jLuXikLRFRGH7U8j
        KRVkgIAkrmZjqCmhtg8lcAGqhC+gz35ydocqSQeF
X-Google-Smtp-Source: ADUXVKJLmeaN5SNN1Ge+9ADFOBQvDfpaFtdPw0Kh2H0cJ4mDw5avWOJ4jBLTPuiKEZOOUXxNgcVG2miIOP/VyvDIZi8r
MIME-Version: 1.0
X-Received: by 2002:a81:4cce:: with SMTP id z197-v6mr636974ywa.141.1530032878787;
 Tue, 26 Jun 2018 10:07:58 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:07:55 -0700
In-Reply-To: <20180626073001.6555-11-sunshine@sunshineco.com>
Message-Id: <20180626170755.134929-1-jonathantanmy@google.com>
References: <20180626073001.6555-11-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 10/29] t9001: fix broken "invoke hook" test
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        szeder@ira.uka.de, sbeller@google.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index e80eacbb1b..776769fe0d 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1966,11 +1966,11 @@ test_expect_success $PREREQ 'invoke hook' '
>  
>  		# Verify error message when a patch is rejected by the hook
>  		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
> -		git send-email \
> +		test_must_fail git send-email \
>  			--from="Example <nobody@example.com>" \
>  			--to=nobody@example.com \
>  			--smtp-server="$(pwd)/../fake.sendmail" \
> -			../another.patch 2>err
> +			../another.patch 2>err &&
>  		test_i18ngrep "rejected by sendemail-validate hook" err

Thanks for catching this. Indeed, "git send-email" is supposed to fail
because the validate hook greps for the string "add master", which does
not exist in the e-mail to be sent. (Above this is a test that shows
that the same validate hook succeeds if the e-mail contains "add
master".) This looks correct to me.
