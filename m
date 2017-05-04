Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4023F207D6
	for <e@80x24.org>; Thu,  4 May 2017 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbdEDRJj (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 13:09:39 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32911 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdEDRJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 13:09:37 -0400
Received: by mail-pg0-f43.google.com with SMTP id y4so11753242pge.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gfW36/WwJDu9ppoC0XAURfdBaU/l7IF7/2BQJugqVys=;
        b=HZQM3CCzosaPX3S/odOt9WrV5GDDFIKfA82RXJyVtwM+2Xoos6IXb0LZbzUN3Tr8D6
         aNBQggN+zjkvDGmplj6Evdj//NVd1KgXuaRoeA/FQomBf9ujnd3Ex+XAFqqXwlRuXEn2
         BzKUmdQmYJsiGwRQEoJfnGB1byQ/wcCyVzzVlX3pkupyIvZFptunUoP+KoLUf3c3FbPd
         rGKcMuSWx12AjsMmvVvHkJWNTvLVO8JTWLO8LyIfCIyI59pco23a9ViD0lu/metvAMaO
         lQuUCxAA+BLQl3kQCTNZLeB/FQnn9i1aPYrvgMkW4jvgqREOOpzrplYX3BmaHOwarwuf
         9PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gfW36/WwJDu9ppoC0XAURfdBaU/l7IF7/2BQJugqVys=;
        b=NlVHUXsG+ViaWNLQA2ZZD6SUNQFXjwb+2CseoFgYw0SO0DmjEXftziZp99KXqrFdoi
         XRNkFhkeZgrRBgLt5Rp+bQrqiYoOpYlVdcbNh4bRDOJSQAt/ADHaO1xSmnyl1ombks9U
         /VF2O2eIqyfA+b3P8KnmqPrS5MJRHIN7lhUDjS3EJS4OMYZ6uY5XCmWpH6COD1IHct2J
         m8mzAkpElCICKewovGFucVPBJSaZXC3+rjdIbeHjYUDz20vOY6jm0N7tj0yAC9YVzqWA
         MPNie6voiRZwF+B6re8JH4KhjcFpLnez8cqQR0GI4DR2f5iKnr0wmlno91/UU5xzLBsb
         H8xw==
X-Gm-Message-State: AN3rC/73lSeLAC5lifRuuM/XK98DDKSoNH0m1+m1j9ZntNO03hV88iFn
        6NZwPAo+HdIFrmaX
X-Received: by 10.84.136.135 with SMTP id 7mr21244436pll.33.1493917776681;
        Thu, 04 May 2017 10:09:36 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:4d04:502:5b1a:dba1])
        by smtp.gmail.com with ESMTPSA id p6sm4772066pgn.9.2017.05.04.10.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 10:09:35 -0700 (PDT)
Subject: Re: Proposal for missing blob support in Git repos
To:     Junio C Hamano <gitster@pobox.com>
References: <20170426221346.25337-1-jonathantanmy@google.com>
 <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
 <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
 <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
 <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
 <xmqq37cof320.fsf@gitster.mtv.corp.google.com>
 <CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com>
 <CACBZZX6jQtO_3zYjnvq0dhtWvUxb7vYLtQUWpFHLw1v-SteHcQ@mail.gmail.com>
 <daed427f-b39e-c3d9-76ee-9c37203e1988@google.com>
 <xmqq1ss5b5xh.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Kevin David <kevin.david@microsoft.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <3abf3663-b09d-0196-e719-6cef02f01482@google.com>
Date:   Thu, 4 May 2017 10:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1ss5b5xh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/2017 09:29 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> I see the semantics as "don't write what you already have", where
>> "have" means what you have in local storage, but if you extend "have"
>> to what upstream has, then yes, you're right that this changes
>> (ignoring shallow clones).
>>
>> This does remove a resistance that we have against hash collision (in
>> that normally we would have the correct object for a given hash and
>> can resist other servers trying to introduce a wrong object, but now
>> that is no longer the case), but I think it's better than consulting
>> the hook whenever you want to write anything (which is also a change
>> in semantics in that you're consulting an external source whenever
>> you're writing an object, besides the performance implications).
>
> As long as the above pros-and-cons analysis is understood and we are
> striking a balance between performance and strictness with such an
> understanding of the implications, I am perfectly fine with the
> proposal.  That is why my comment has never been "I think that is
> wrong" but consistently was "I wonder if that is a good thing."
>
> Thanks.

Noted - if/when I update the patch, I'll include this information in.
