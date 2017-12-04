Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D206F20954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbdLDVeI (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:34:08 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41143 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdLDVeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:34:07 -0500
Received: by mail-wr0-f169.google.com with SMTP id z18so18931534wrb.8
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 13:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BQ8TCh1ArOg+gxkylgdFACvgtKFnOmpMLNq/m5CV7N8=;
        b=NkZHzzbqstmk7A6CwqCuSIorzfPBijmx+crSjn1uiF9/7a4Dk+aZvtwCJ9zl3CzzoC
         52zOjxQ4il3aAPvTfjQpT34ejnNVNfsuhM/oSx6B9Uj5Z3kaxP6o7S9Ibo38Ixm3ze1E
         przjtM7DJYWqoluObUG21Slsc3c1bV4KKGrxcibK8RHUfxS6bl6M4Si4oyY1eA1AVQQr
         JxoCtbxEM7JlfINp6Pb9JiL5O95aBtnayXjlt4WowFrflfPVr0MmJevHAR24u88eK0Nt
         M+RuVuqvLsmd4/QFk8P9eFA/cbQslnLLgIiy8tkxLPODBkekt8kKqFJu6kiWCFircybS
         6uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BQ8TCh1ArOg+gxkylgdFACvgtKFnOmpMLNq/m5CV7N8=;
        b=nKnEbGR5vannyC8QYxyBh5uwobOshUjA8GGpnUALze9WKxV8eEcGEZw6kHNWtdwq+j
         jZJDY+Ojb/pIjijgP+bbmXPpw4IWg1VFjDS+IfaKI3MH7jc2zKgRZxiCW+7qhIjSVxdE
         61EXj3sklUP8xZYJAFLJqqyVjGeg7Hufy0yhwikDc47maGKNG9uN1qjEgLp78DdJ+Xai
         zYSdlgOzOCLCkyaiuDQdSqSQOu4VVCOFHluo7CwB1Nl04nCD36iDVbL9St9sYt7Cp8J5
         1cJuzwabKUTqGOeQXH5hn2fn9xK3MTtrhh6tFUKjj+/cJVXvq/pZ8W9gCf4j7hESAHtL
         qI2Q==
X-Gm-Message-State: AJaThX6GiuE3dRpECJguEcFpJSAjGncBJkaYUxaw55X5e8bTMedip81d
        6wSIRf5mgsYyvlfNicwZ07U=
X-Google-Smtp-Source: AGs4zMaed67TXAWqeIpcRixVEqyrZ7qL+s5Yu31RkemOcwVqcGXPKN+Bu1TSyvza7AFcIDNHX52N/A==
X-Received: by 10.223.201.2 with SMTP id m2mr13174369wrh.274.1512423246161;
        Mon, 04 Dec 2017 13:34:06 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6B70.dip0.t-ipconnect.de. [93.219.107.112])
        by smtp.gmail.com with ESMTPSA id i8sm13362032wrb.29.2017.12.04.13.34.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 13:34:05 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171204173223.GF13332@sigill.intra.peff.net>
Date:   Mon, 4 Dec 2017 22:34:04 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <599BA6A0-0CAB-4C77-8428-F7E46064DF14@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129143752.60553-3-lars.schneider@autodesk.com> <20171130205137.GC3313@sigill.intra.peff.net> <xmqqvahojssu.fsf@gitster.mtv.corp.google.com> <D3A5C7E6-A63C-431C-97B5-070632EE3540@gmail.com> <20171204173223.GF13332@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Dec 2017, at 18:32, Jeff King <peff@peff.net> wrote:
> 
> On Sun, Dec 03, 2017 at 01:47:04PM +0100, Lars Schneider wrote:
> 
>> I am on the fence here. I like consistency but I don't want to
>> bother Git users.
>> 
>> @Peff: Do you lean into either direction? Could you imagine that
>> novice/regular users are bothered? (I don't expect experts to be
>> bothered too much as they would likely be able to find and set 
>> the advice config).
> 
> I also am on the fence, and am OK with any of the options discussed.
> 
> But now I've said my reservations on the list, so I can say "I told you
> so" if people complain (and naturally refuse to admit my objections if
> people love it). :)

Well, since you and I are on the fence, I will follow Junio. Then we
can at least argue that the feature is consistent on all terminals.

- Lars
