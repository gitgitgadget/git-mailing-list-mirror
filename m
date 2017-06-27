Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8AAB20401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbdF0SMk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:12:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35418 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0SMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:12:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so5184710pgc.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vWD5SXYv/jKWha1pjG/FYeKHEPsOeiL4GgiRDe3TE/8=;
        b=f7JLNIIs2Jkox/vfLKPrSDQSRYJ5qWsxcicRK5zbDXgYOj8K7pQPX70Gn7T5tde5jc
         esiN3SI/VNQ2Sfvm0dkC65bmtBHayG916TGMiZ/UO98aqo1O7HmBMPNeY5uQDGsd7JbP
         W1f83UDFdbebCLXg1LwJwnq4AItDApCblLJndwVgo6mi/8H1oDKMckjZS3ChVrCnbZit
         uO/0EP6aQOLAAusGYX0nhEtws9M8zKU4n97di9NTxwcb+0h5dBv23ZboDSfhOhb7BMxs
         ooytrNK4fMoqc/dP/+z2W3+oaw/M29GQ4383koOT11sLlkx8GHWxwEk3jc8tZzyqtP7T
         KDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vWD5SXYv/jKWha1pjG/FYeKHEPsOeiL4GgiRDe3TE/8=;
        b=gPcSELycvyb5EKsBLF5gxklMOodsROQx3/cHslu/Y0s5CwbNzyiEC1unR/XwEQPtk2
         eF/FYP2Rrx8cQkBJtvq6Y8C6Aqw3sz2teKwfVoErXUc57QFWDhrCBuVNjIntFlUr0Fqd
         rHgOCkZKlKoWKkVEFSRNYSlqifo6y65ST5w7PtWlIfpKAoFVZlPBDrjeHmaRyCoCIJbV
         dIqkZuCYkbvvfSwjgnZWaR5NuDpLkGXrTby4gXRAvKBLYEfJ9NSZYuQabxRn3JqIJGGy
         7y1myopjbxFnRBhsKqWz8wK0fJYwRL1Q3D7Wign5WloyG0qtW7hmhkPs0EAqg8eWE06z
         jPQQ==
X-Gm-Message-State: AKS2vOxMC131++yQyrIiEOJe05ZaRl3oUoCt1tQcOOa97fLhspOFgwSf
        QpvKAJdO3+8UBQ==
X-Received: by 10.99.1.88 with SMTP id 85mr6602659pgb.14.1498587158392;
        Tue, 27 Jun 2017 11:12:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id p5sm6610232pgf.50.2017.06.27.11.12.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 11:12:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
        <87zictjoff.fsf@gmail.com>
Date:   Tue, 27 Jun 2017 11:12:37 -0700
In-Reply-To: <87zictjoff.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Tue, 27 Jun 2017 20:06:12 +0200")
Message-ID: <xmqqo9t91eqy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 27 2017, Junio C. Hamano jotted:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> Update sha1dc from my PR #36[1] which'll hopefully be integrated by
>>> upstream soon.
>>
>> Please be careful about the title of the patch.  "log --oneline"
>> does not even let you tell your readers who calls this as "my"
>> change, and readers would be clueless what PR #36 is.  Something
>> like
>>
>>     sha1dc: correct endian detection for Solaris
>>
>> may give us more relevant information in the oneline output.
>
> Will fix. Can you integrate it as-is into pu anyway? I'm going to need
> to re-submit it regardless once we get some testing on it & upstream
> merges the PR, but having it in Travis et al in the meantime would be
> great.

I somehow thought that your throwing a pull request at git.git would 
automatically trigger a Travis test, without you having to wait for
me to do anything?  Am I misinformed?

