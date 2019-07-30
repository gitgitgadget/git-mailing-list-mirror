Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9581F462
	for <e@80x24.org>; Tue, 30 Jul 2019 21:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfG3VKR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 17:10:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfG3VKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 17:10:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so64048175wrm.8
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MdtqX8YVY3WGcIKmzLCgmxtjPZqnNWZDmemYdI0VO0Q=;
        b=FVGlZZDpTHo1zICmb/yvktA+mhMW6TLm0QSAEH0h/1Jft3ZI0hKrLgaXrbcns7eaUT
         5YLArnXxZuzONigs8w2NoHoStMBGyakS3eb0Gp0QJ+QRRBUJ0Q8WYp9TRd3s2nckJ2Oi
         GsPtnRqu/wvimfHHo3NqhHS/fBD5uYNdnw4+wJGhUUH794ukxMyLP4zBK4i4oWV45iu6
         7jGdFEt4RtkVcee24rvU/if56a7BPZKvBCWrNTT+aeTuczjFsjCJ//XW2q+b/wP27QqH
         +zo6qcMBph2/Kil5YvvocTL4d5b/lY9zpQvSAC5J8/UqDyYy1L/q6fpxrIGWGkX5CWyK
         IfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MdtqX8YVY3WGcIKmzLCgmxtjPZqnNWZDmemYdI0VO0Q=;
        b=Q8jqWZIkwRUJsv3gnTCV4D8YNPTxJ+9Mr4tOkJ7EYZ6DtVzEwZfLueqMNV8w7kPmho
         MFgN73yT3SV1YhJ+KT1EIKjmb0AYyj56R1n5XOFaVv01ZnO5pH++NX40vXGdPJoL+xws
         P4jO2gkBH85r0WPipjOk1JuZYaTpxKBrVfeJJTqP9v9rH08bkChgSpaC4z64tODYT77P
         HM/O03V8qFeTIZ10Hn2HcqRdS5i2Y9WXYUobKrwZVIcsQmh8k9+RcnmPs1wzXRS71zHa
         km5rQTG7ujbVblpQikmLPlfihJSNNJCGB0I9Hr24QiJo6vBprF7E7Ld/Oj5V22JyzoAS
         hpHw==
X-Gm-Message-State: APjAAAVSCyFPliDFMbeFbNHMbYoDNOIQS9jlPjy0Imy376PXFdY1MOLp
        N7qCTQAXTc+6mRHtiO5upAY=
X-Google-Smtp-Source: APXvYqz/rvoXY+AGMty97V0LdRcdTrBdr9G0cx74+cPKrl/1tG/x3qXGvh7iA1dFLT3voeRW/iCGKg==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr2369813wrw.349.1564521015204;
        Tue, 30 Jul 2019 14:10:15 -0700 (PDT)
Received: from szeder.dev (x4dbe512f.dyn.telefonica.de. [77.190.81.47])
        by smtp.gmail.com with ESMTPSA id a67sm73111919wmh.40.2019.07.30.14.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 14:10:14 -0700 (PDT)
Date:   Tue, 30 Jul 2019 23:10:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCHv3] send-email: Ask if a patch should be sent twice
Message-ID: <20190730211012.GS20404@szeder.dev>
References: <20190730203327.30958-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730203327.30958-1-dima@arista.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 09:33:27PM +0100, Dmitry Safonov wrote:
> @@ -589,6 +591,19 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success $PREREQ 'ask confirmation for double-send' '
> +	clean_fake_sendmail &&
> +	echo y | \
> +		GIT_SEND_EMAIL_NOTTY=1 \
> +		git send-email --from=author@example.com \
> +			--to=nobody@example.com \
> +			--smtp-server="$(pwd)/fake.sendmail" \
> +			--validate \
> +			$patches $patches $patches \
> +			>stdout &&
> +	! test_i18ngrep "Patches specified several times: " stdout

You should write this as 'test_i18ngrep ! <...>'.  When running the
test with GIT_TEST_GETTEXT_POISON=true, then 'test_i18ngrep' is
basically a noop and always returns with success, the leading ! would
turn that into a failure, which then would fail the test.

Sorry for not being specific enough.

