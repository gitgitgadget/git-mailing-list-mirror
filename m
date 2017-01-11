Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCE6205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 18:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbdAKSgo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 13:36:44 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34157 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbdAKSgn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 13:36:43 -0500
Received: by mail-qk0-f182.google.com with SMTP id a20so219054157qkc.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MogwMwBdLC1TOyuUpIkilxrzdlRelnsgL3Oac0dKiVc=;
        b=ryWE5pfCEw3Iiwi25SqJ7fLrMXDPushDjnxx6RfBeR2HSfDZDf64hHzwKuXVBYDW1u
         ukGdcx20WquUJmuiEfwnBr4pUxE8C5VrznyEDo75M7qMeMVDzJpcIQy584SqDbx29uup
         dUEjjEni99WJWeUWdlYSBJNn2lEH3W5yzt0z5boMrNj8E8CNczS4C6gcXqN8zXPp4060
         pj+OkgH8IDwGNwD+wyT+d/LbEoGrqgoEWxPWh5//eli5HwVISTNRD6gvlG4gFx0OFl2M
         aRFAQVFDRVarLB0GLZq/QnApZy4iNThQuil2siiWLK354qHpNbw0E2sqTejZRe39rpjW
         fw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MogwMwBdLC1TOyuUpIkilxrzdlRelnsgL3Oac0dKiVc=;
        b=m2GjQPKLBkyQrqbrd1yzUkAU/JI6pMyu6E3j88khCdaaIZwKJoFX8XqTIaKS5+iUXH
         DZtQ1CbNIs+kVXuAW9gTco00iTTnACk5rg9ftzcMDu87Hg/JKnHs7E3pjolPOMPIvAWC
         gcXe1n6OS7P9MQdjxcB1U7wfqPjD4qIHTbJFw5Zk6by+Afg4wK3s+Lgz18RKptmn+rrV
         7tzLWgi4XEeNQnSg67Z6aipcjtk6TmzpbKALojbIZ30Cir5BRPWJNoTZdjnTUtb6qv9R
         WjyehJnXJbyxj3CB7EKm/I+zy09E06JA/Q10Tv3tC+MDmi0/O1A8sGmlLzdStsWHUfNd
         H9HA==
X-Gm-Message-State: AIkVDXIgH5NCbPu+uURkmcQEdPTUTSoduPcO2+QwBXYIXF3tTmzANPeJM0uNDSCOhZZFtIVK
X-Received: by 10.233.239.143 with SMTP id d137mr10260914qkg.284.1484159802295;
        Wed, 11 Jan 2017 10:36:42 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:8459:597d:aa56:dd3a])
        by smtp.gmail.com with ESMTPSA id e33sm4663406qtb.31.2017.01.11.10.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 10:36:41 -0800 (PST)
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
To:     Junio C Hamano <gitster@pobox.com>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170110004031.57985-3-hansenr@google.com>
 <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
 <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com>
 <xmqq60lmpb4j.fsf@gitster.mtv.corp.google.com>
 <21b416ae-8bf6-4f82-25d3-e51a574e7746@google.com>
 <xmqqwpe1o43k.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Richard Hansen <hansenr@google.com>
Message-ID: <2fb4296d-f084-4a76-44f3-7dc7d7cca7b1@google.com>
Date:   Wed, 11 Jan 2017 13:36:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqwpe1o43k.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-11 13:15, Junio C Hamano wrote:
> Richard Hansen <hansenr@google.com> writes:
>
>> On 2017-01-10 21:46, Junio C Hamano wrote:
>>> Richard Hansen <hansenr@google.com> writes:
>>>
>>>> I was looking at the code to see how the two file formats differed and
>>>> noticed that match_order() doesn't set the WM_PATHNAME flag when it
>>>> calls wildmatch().  That's unintentional (a bug), right?
>>>
>>> It has been that way from day one IIRC even before we introduced
>>> wildmatch()---IOW it may be intentional that the current code that
>>> uses wildmatch() does not use WM_PATHNAME.
>>
>> You are the original author (af5323e027 2005-05-30).  Do you remember
>> what your intention was?
>
> Yes.
>
> Back then we didn't even have wildmatch(), and used fnmatch()
> instead, so forcing FNM_PATHNAME would have meant that people
> wouldn't be able to say "foo*bar" to match "foo/other/bar"; with
> wildmatch, "foo**bar" lets you defeat WM_PATHNAME so having
> WM_PATHNAME always in effect is less of an issue, but with
> fnmatch(), having FNM_PATHNAME always in effect has a lot of
> downside.

Ah, that makes sense.

>
> I'd expect that orderfile people have today will be broken and
> require tweaking if you switched WM_PATHNAME on.

OK, so we don't want to turn on WM_PATHNAME unless we do it for a new 
major version.

I'll do another re-roll and document the non-WM_PATHNAME behavior. 
Perhaps I'll encourage users to prefer ** over * if they want to match 
slash (even though they are equivalent) so that migration is easier if 
we ever do turn on WM_PATHNAME.

-Richard
