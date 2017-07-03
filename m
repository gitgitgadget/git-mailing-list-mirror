Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12799202AB
	for <e@80x24.org>; Mon,  3 Jul 2017 20:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbdGCU3S (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:29:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35058 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCU3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:29:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so45758040wrb.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PcTh3MAZEv/v6J/cD3IWKn7k95cdpS1DFIzZK4drTJw=;
        b=PqzhP02Uwyu6nHo25blBA9KU3J4HECI+3Jm/5L6BF04QcnyskLcKQg79TaqubWhl4Q
         ZclX7pG/BhQKoQ4EmABU7L/ZpVQx4QsHWTfOsHSTvyiYfqLhxDlVMUUKnCjoU1Wkmov0
         Gkd4pjZRYM88e3BC6ankSV3kXYR35O5aAyQkktvQz1o9UwFAzq2dZbIXL8v2o7vpxWvx
         /gFBYeyaLMvkL9VrOPMxkvHgipWuVvU1jrMVImO8yYv+KfrkucRujvMx668XFqSPICHb
         ofZNeNYLo0PVqkCPYuSE9JuIk59qS7/Hn+xE0Tn2dHhnouzFyj+WJpZpAJWQ5QPZGaWi
         vNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PcTh3MAZEv/v6J/cD3IWKn7k95cdpS1DFIzZK4drTJw=;
        b=pNDYLIrrWKUvkn9/uMXt/Wg/yquOxOZodZz3IXs/Iq5ba3Xehr8CgIRlqMhXrVU4j7
         GsVYZ6mxSzBMPHexYuhJmSoJT2YnZNcCOQKgdoFyNxQjZq+wdoF7t4fINE+gohTnoaDv
         pxvl7fLqwRAcBw3dkKVeY+1yi7VJnxH5S0ltkBu/bj0n5a9UxeAKMkVKLPOwqWh5BT0I
         aEqKixuMetPI+QKLgIpYuHqAr0UdPUguTnlYdM2VdrXnmlD2xteAq+vkQYaFpih8b53C
         tS2KnJGnaTRaYN8J9cx4VzBHLQBnaLjX9HT3pQTqYzBL1TVxEVICoQ2R37dGaeAPV50u
         TPMw==
X-Gm-Message-State: AKS2vOyRxUzLPUUWXEA2qRpa18aJ+OFl+7pKvAdLXIrV3k0aokIr3TW6
        yAozvyyPG3uBrw==
X-Received: by 10.223.134.117 with SMTP id 50mr37925014wrw.62.1499113756350;
        Mon, 03 Jul 2017 13:29:16 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id 5sm13264309wrq.60.2017.07.03.13.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 13:29:15 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dS7y5-0004VP-Nc; Mon, 03 Jul 2017 22:29:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170701220547.10464-1-avarab@gmail.com> <20170627121718.12078-1-avarab@gmail.com> <20170701220547.10464-3-avarab@gmail.com> <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 03 Jul 2017 22:29:13 +0200
Message-ID: <874lutclie.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 03 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Add an option to use the sha1collisiondetection library from the
>> submodule in sha1collisiondetection/ instead of in the copy in the
>> sha1dc/ directory.
>>
>> This allows us to try out the submodule in sha1collisiondetection
>> without breaking the build for anyone who's not expecting them as we
>> work out any kinks.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  .gitmodules            |  4 ++++
>>  Makefile               | 12 ++++++++++++
>>  hash.h                 |  4 ++++
>>  sha1collisiondetection |  1 +
>>  4 files changed, 21 insertions(+)
>>  create mode 100644 .gitmodules
>>  create mode 160000 sha1collisiondetection
>>
>> diff --git a/.gitmodules b/.gitmodules
>> new file mode 100644
>> index 0000000000..cbeebdab7a
>> --- /dev/null
>> +++ b/.gitmodules
>> @@ -0,0 +1,4 @@
>> +[submodule "sha1collisiondetection"]
>> +	path = sha1collisiondetection
>> +	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
>> +	branch = master
>
> Do we need to say this "branch" bit?

Yes, it's to make future updates easier, see b928922727 ("submodule add:
If --branch is given, record it in .gitmodules", 2012-12-19).

> Other than that looks good to me.
>
> Thanks.
