Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7E21F597
	for <e@80x24.org>; Wed, 25 Jul 2018 08:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeGYJld (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 05:41:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39076 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGYJlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 05:41:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so6530893wre.6
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BznRFJXx4rIDSOLBEc5SLI/sCAQjpfrWno/Pa38A/z4=;
        b=rzKm969IWwkq7B5nLt9MSpviQ4GrL2V44HZoV8CO8quTvS89Ot7W59+Kf4/kY+SuTh
         cjz4ryrzplGCvGuRzguo5/qInC4n8jux5mlyLDytFL896D0MLACc7sMt+eXIN5rI80s/
         DnrdyVJmfYGrllmF/j8FN/I0qO6YqF+5aXe5/fRDv6Pne+0u+kr5IKxoWMNpjAAURIuS
         aSPz47Op7KNliMM78tLmvMD7MitLTlsuLsvmss5+R9RawKBrwk6/+tv0OL0pXiioSf9H
         CisclF01E4lc2dPjcWAdMcuQXJnips9px6mm9ioXQMywjRPHTrvvdQ42txYzBmFmj80K
         iG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BznRFJXx4rIDSOLBEc5SLI/sCAQjpfrWno/Pa38A/z4=;
        b=grJUbu7b2tl/jAxzKfi/SZnCrBO7V24INjJEMlNwg7HSXiGbdCn9lz+k+c6zerQ6eu
         JamWc9V1BjOSJi63qjjEDLAV9unNKmeh2NcUt+Tk68nkD9Xnt7f39kyL6nhIzwmebnj9
         MwmrVruOONgENJAsCe4sR+kV/AHLPoXtD+6aQebOarHwAE081mUMEjN9L51WHxdUgf6+
         vXSeAJpYZg1zifJUZBGRvxfWhSqIfosKvixy9WyhlUAeTMIMTPMIqFOEpm6wWfcDSeb2
         XPwjqXYvj/pASYE4Y3tPipZL2F8i5Xwgjz/G066danGenfwxexw5LTk9cVtNiLuq0fsR
         r8zQ==
X-Gm-Message-State: AOUpUlE5DV2fdCabuJLFoHa7qu6qm+TyyPiNuQGIpRCDR1td1rBM756P
        RZypKz7KFVSf+E6waZXpTf96YbEf
X-Google-Smtp-Source: AAOMgpfIbEPv19mr+s+xGEb122p+F361dbGuUPpX9JiNCvZEIapF6e5TRGsrgGhaDjdMfDXfqj3vqA==
X-Received: by 2002:adf:93c3:: with SMTP id 61-v6mr13309199wrp.18.1532507454297;
        Wed, 25 Jul 2018 01:30:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v1-v6sm35836323wrs.34.2018.07.25.01.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 01:30:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] document that NewHash is now SHA-256
Date:   Wed, 25 Jul 2018 08:30:22 +0000
Message-Id: <20180725083024.16131-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24 2018, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Tue, Jul 24, 2018 at 12:01 PM Edward Thomson
>> <ethomson@edwardthomson.com> wrote:
>>>
>>> Switching gears, if I look at this from the perspective of the libgit2
>>> project, I would also prefer SHA-256 or SHA3 over blake2b.  To support
>>> blake2b, we'd have to include - and support - that code ourselves.  But
>>> to support SHA-256, we would simply use the system's crypto libraries
>>> that we already take a dependecy on (OpenSSL, mbedTLS, CryptoNG, or
>>> SecureTransport).
>>
>> I think this is probably the single strongest argument for sha256.
>> "It's just there".
>
> Yup.  I actually was leaning toward saying "all of them are OK in
> practice, so the person who is actually spear-heading the work gets
> to choose", but if we picked SHA-256 now, that would not be a choice
> that Brian has to later justify for choosing against everybody
> else's wishes, which makes it the best choice ;-)

Looks like it's settled then. I thought I'd do the grunt work of
updating the relevant documentation so we can officially move on from
the years-long NewHash discussion.

Ævar Arnfjörð Bjarmason (2):
  doc hash-function-transition: note the lack of a changelog
  doc hash-function-transition: pick SHA-256 as NewHash

 .../technical/hash-function-transition.txt    | 192 ++++++++++--------
 1 file changed, 102 insertions(+), 90 deletions(-)

-- 
2.17.0.290.gded63e768a

