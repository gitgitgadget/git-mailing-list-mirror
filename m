Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5AF1F406
	for <e@80x24.org>; Fri, 11 May 2018 03:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeEKDyO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 23:54:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43135 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKDyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 23:54:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id v15-v6so3886529wrm.10
        for <git@vger.kernel.org>; Thu, 10 May 2018 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HR/KSQkQ9oLonJ5o3v4fBIzLPGEkLx4pYKdrspp2xxw=;
        b=UxRDvq62Wj9rOptjXqnpNj9ejMhb6mUd5ILcEGxW3hNBfpoQeJCq3MnKYY6blhO/ik
         k2CsJtgbUT7aEe6OtST8/KvqV/s95IuAimg6TgDmEUVKlVaF1/JgJvV7q7e8+L/PlU7p
         JDCTN+ZKn1ScNMpaFnSlQH7ACDm13EHgI2Ja5bEV2qeSabAZFMhPRmFxr1lyj1kHwx3g
         Er2voxMGhEZCNyP6GTCPSxP4u2fzL7tGAxtjQjuxgfz/MzMcZMD58ZPx7gJ/3wDpq453
         LdGUKOIZaTPqbleSOWPzTev7VyQOQKo+NOiHIGmleJHU1a+6tJlcO41pOSxMW+d+Gnb1
         j1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HR/KSQkQ9oLonJ5o3v4fBIzLPGEkLx4pYKdrspp2xxw=;
        b=QntmWIK1GOPEwoRjjYGMV9ye4+uMu5g5qgMdotB3Vjxgunue9L5Edapb5kx7v0SMLm
         oAEF+n5K7xudvO900XmcfQmHzloGbGdpxYY17CpWJ1SZ5Zn20oMVsvm3KYnczGeu0x/O
         JIjv8Gs16Ss54FX7wFh8NVZjekwLsLiOEIRyCE/nMdT/zbnnN9Z6zbDFsFgj+WFf67mF
         zB79FA2aC8T2Ce3Xr1Kcd6PIKH7GHzrBoKVMEaSixAO8r1oyqpoECPooiorI0UqSxtdg
         1IL3aB6hMot63KL7DBoR71Ne9BHcRfh83sUwNfDLdHnIIUQGMpxOyGctoNf0zG3kBFMC
         CM7w==
X-Gm-Message-State: ALKqPwd2ulQxeyeeAxQlPgUGbhcTQQj3MtmrEgpULXPXlN2j3KFp9TWc
        +R7y/3MQjiXCcMJiARo8Nnc=
X-Google-Smtp-Source: AB8JxZrPVFjoCF9GHDvtwtpr3HhCxADdr2+QJ3Ik9rDxxFX5Iq/AdkxzFDuWWGDnumAZOR6TEQie8Q==
X-Received: by 2002:adf:a0ea:: with SMTP id n39-v6mr3083536wrn.87.1526010852379;
        Thu, 10 May 2018 20:54:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 90-v6sm2254492wrl.79.2018.05.10.20.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 20:54:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        sandals@crustytoothpaste.net, sbeller@google.com, stolee@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2] pack-format.txt: more details on pack file format
References: <20180508155627.19245-1-pclouds@gmail.com>
        <20180510150939.25399-1-pclouds@gmail.com>
Date:   Fri, 11 May 2018 12:54:10 +0900
In-Reply-To: <20180510150939.25399-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 10 May 2018 17:09:39 +0200")
Message-ID: <xmqqefiihmot.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +Both ofs-delta and ref-delta store the "delta" against another
> +object. The difference between them is, ref-delta directly encodes
> +20-byte base object name. If the base object is in the same pack,
> +ofs-delta encodes the offset of the base object in the pack instead.

Those of us who know how delta works would understand it, but "delta
against another object" followed by a mention of "base object" may
not necessarily click to readers that "another object" and "base
object" refer to the same concept.

	... store the 'delta' to be applied to another object
	(called 'base object') to reconstruct the object.

perhaps?

> ...
> +  +----------+---------+---------+---------+---------+-------+-------+-------+
> +  | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
> +  +----------+---------+---------+---------+---------+-------+-------+-------+
> +
> +This is the instruction format to copy a byte range from the source
> +object. It encodes the offset to copy from any the number of bytes to
> +copy. Offset and size are in little-endian order.

"any the number"???  Ah, s/any/and/ that is.

Other than that, looks good to me.

Thanks.
