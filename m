Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C231F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbcIFXa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 19:30:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36332 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755801AbcIFXa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 19:30:27 -0400
Received: by mail-pa0-f43.google.com with SMTP id id6so17284574pad.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=awKTLOjjYq9XQXRlUlsWSyKJ/zfdOoBLzFDoS8vF7WQ=;
        b=oIHEd84oa+F19/X2bFD72nywvGseAdzuG5JN9CH1Gt1ot+CRLXnzoDImWMcJf+8hKO
         EdsPLJicZC3A1kxgllo3JD+0AMqi2hnnysg3UrbwZTM0+SAfdDDmA65cLmmMlYg9Pu7A
         HlCkvRR3Yag5B5SuzNib8oVRVJ25rtOglmz2ceIoGhDn72286vUqbSver4UX2wtIDccl
         sRfVBOLwSWtGtTB0Fsl6i53nOKOROwwDV7blmWgCG4Ov1sPofbBB9O+SlC2uAwlSpvSM
         MCcCjwOvLsh+9FBW48920xSTbfYGtMO6DblbB8M4P++1vgDfLhltFYFWfbw6H8CWB5Fh
         QJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=awKTLOjjYq9XQXRlUlsWSyKJ/zfdOoBLzFDoS8vF7WQ=;
        b=Axka92alyCiwaLRi/8GyjpWrjnppta/WxXFQDWPHjEaCzBweo89u6Q2rTgCedPEP5S
         XojbOx5wDar9HEy3n4nvbjHQrLWJrqSG5OHoq/cNGxRVJjLl3eGKd+bXvAA0UzCnCICP
         aSpyTQ57MGwF71Rr7jpPDuol4Un1IYqYZy16TorYiXmrZ2z6LlL3zUoYoNOg/MTEs4x/
         TUknJaI5yb5fHU6AOdKKpQ19O0MK7Z4Y5MnIhWT60UBOFXGN0IW9vAuajLUa2rgMZ6d3
         41VZ9vrZgFF2iyPQ+KYZd0xV4euIOVItxaPZX09wHOawlb7NfzYdur4+JGK/oHXM0f3I
         OcGQ==
X-Gm-Message-State: AE9vXwNmc9AOayzmdw6hHlxIUuPIXrwn0uUC2r+ldjAc1i7oVWUw6QbgprF+HRPMv2pfKvid
X-Received: by 10.66.159.195 with SMTP id xe3mr78109492pab.159.1473204626042;
        Tue, 06 Sep 2016 16:30:26 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:4170:9855:c486:2b8c])
        by smtp.gmail.com with ESMTPSA id zk7sm43554530pac.41.2016.09.06.16.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 16:30:25 -0700 (PDT)
Subject: Re: [PATCH] sequencer: support folding in rfc2822 footer
To:     Junio C Hamano <gitster@pobox.com>
References: <1472846322-5592-1-git-send-email-jonathantanmy@google.com>
 <xmqqy439rabb.fsf@gitster.mtv.corp.google.com>
 <29cb0f55-f729-80af-cdca-64e927fa97c0@google.com>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <fbdda11c-c53e-f9fc-8b3a-934810215c5f@google.com>
Date:   Tue, 6 Sep 2016 16:30:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <29cb0f55-f729-80af-cdca-64e927fa97c0@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2016 03:08 PM, Jonathan Tan wrote:
> On 09/02/2016 07:23 PM, Junio C Hamano wrote:
>> A slightly related tangent.  An unconditionally good change you
>> could make is to allow folding of in-body headers.  I.e. you can
>> have e.g.
>>
>>     -- >8 --
>>     Subject: [PATCH] sequencer: support in-body headers that are
>>          folded according to RFC2822 rules
>>
>>     The first paragraph after the above long title begins
>>     here...
>>
>> in the body of the msssage, and I _think_ we do not fold it properly
>> when applying such a patch.  We should, as that is something that
>> appears in format-patch output (i.e. something Git itself produces,
>> unlike the folded "footer").
>
> OK, I'll take a look at this.

It turns out that Git seems to already do this, at least for Subject. 
Transcript below:

$ echo one > file.txt
$ git add file.txt
$ git commit -m x
[master (root-commit) 2389483] x
  1 file changed, 1 insertion(+)
  create mode 100644 file.txt
$ echo two > file.txt
$ git commit -am 'this is a very long subject to test line wrapping this 
is a very long subject to test line wrapping'
[master ca86792] this is a very long subject to test line wrapping this 
is a very long subject to test line wrapping
  1 file changed, 1 insertion(+), 1 deletion(-)
$ git format-patch HEAD^
0001-this-is-a-very-long-subject-to-test-line-wrapping-th.patch
$ cat 0001-this-is-a-very-long-subject-to-test-line-wrapping-th.patch
<snip>
Subject: [PATCH] this is a very long subject to test line wrapping this is a
  very long subject to test line wrapping
<snip>
