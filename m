Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F472036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdJCTsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:48:12 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43522 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdJCTsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:48:11 -0400
Received: by mail-qk0-f172.google.com with SMTP id w134so9430683qkb.0
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mPbNFUHITSxVSOXos+duewpyknGuItKfyN2a8EHhSis=;
        b=sd2wlg1JEg9uH2h7RTD4ihpmXQsTS+/hyt+yqCab8gigABWFK6uXOcuThFt1S8ItgU
         iIIBUOcv40TRBc0/bDmGrCT11GP3yB3UAyacKI7L33HVRrAxHf+vP04YNOEDgRRIiq8l
         +A6D9z5jw4RWLDixAp+dMO6imA4gKPRaPTKLvCdPAvPzqR1BzAktlViE3nKoE9ADXdI9
         YRQwZQxJd7pPLr4inaIGKCm4Xlw7+xbqhDCICgjzaf/iyISF/v1RpKCMxnhREvGd/tq1
         mvmYC1O8H5n1Vd5ZuEyl1COpre9SgJstmiQ6aTV4ngODS2chKeh391KbVj6xasufOCjN
         E6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mPbNFUHITSxVSOXos+duewpyknGuItKfyN2a8EHhSis=;
        b=KmBa9vuQ8ezWJsydtF5sltl89xDi9DJhldNyRasIx7UZfLFfmGqslftGtuQs6j4VFD
         1podEdK6RJ/0fw5KiLud4a/cp0sqz5haZx1pg8GpkzZArpnozluht7RzwT1y5cyE4u6T
         oyKpphN6WEobogWXDJzFSa4Gm4uaA/j7ipE7r3rZTVY0/r2szp79NExFjuWttQ5+ir6C
         H06h+UVdBvWQ4gDZMhtOTNqwUBEzGKh3usLTI5fGw/WuKSmBtBn69+a5L9L+KIAbedO5
         Uh7IhJDZeO8T5ImHY0Zd4bKSrdWG9BD3Asfiejk/n2iBVaYK56dTRFf6j7XxkC4Ov9zu
         IsUg==
X-Gm-Message-State: AMCzsaWVj/LoFpB73nal7MlxdegDe26x7z/WpEYOL+eXPXAtTK/X2Q3Y
        91a3y7irJydsvUQ732Pu0cg=
X-Google-Smtp-Source: AOwi7QDtWxjSjfY4BAk27xPOLozdVPU6iTSUq675TrezXIRM7qs9GtcB826i9xdFuVMK4rmUikW5PQ==
X-Received: by 10.55.210.71 with SMTP id f68mr20564236qkj.150.1507060090047;
        Tue, 03 Oct 2017 12:48:10 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id c7sm9048010qtg.30.2017.10.03.12.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 12:48:08 -0700 (PDT)
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
 <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
 <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <fd972756-4ad3-4b96-23d0-e2c9e59189d1@gmail.com>
Date:   Tue, 3 Oct 2017 15:48:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/2017 4:24 AM, Junio C Hamano wrote:
> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
>> I had accumulated the same set of changes with one addition of removing
>> a duplicate "the" from a comment in the fsmonitor.h file:
>>
>> diff --git a/fsmonitor.h b/fsmonitor.h
>> index 8eb6163455..0de644e01a 100644
>> --- a/fsmonitor.h
>> +++ b/fsmonitor.h
>> @@ -4,7 +4,7 @@
>>   extern struct trace_key trace_fsmonitor;
>>   
>>   /*
>> - * Read the the fsmonitor index extension and (if configured) restore the
>> + * Read the fsmonitor index extension and (if configured) restore the
>>    * CE_FSMONITOR_VALID state.
>>    */
>>   extern int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
>>
>>>
>>> Thanks.
> 
> OK, now my copy has the same, so we are in sync.  Unless there is no
> more comment that benefits from a reroll of the series, let's run
> with this version for now and merge it to 'next'.  Further updates
> can be done incrementally on top.
> 
> Thanks.
> 

Well, rats. I found one more issue that applies to two of the commits. 
Can you squash this in as well or do you want it in some other form?


diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 7ceb32dc18..cca3d71e90 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -36,7 +36,7 @@ my $system = `uname -s`;
  $system =~ s/[\r\n]+//g;
  my $git_work_tree;

-if ($system =~ m/^MSYS_NT/) {
+if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
         $git_work_tree = `cygpath -aw "\$PWD"`;
         $git_work_tree =~ s/[\r\n]+//g;
         $git_work_tree =~ s,\\,/,g;
diff --git a/templates/hooks--fsmonitor-watchman.sample 
b/templates/hooks--fsmonitor-watchman.sample
index 870a59d237..c68038ef00 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -35,7 +35,7 @@ my $system = `uname -s`;
  $system =~ s/[\r\n]+//g;
  my $git_work_tree;

-if ($system =~ m/^MSYS_NT/) {
+if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
         $git_work_tree = `cygpath -aw "\$PWD"`;
         $git_work_tree =~ s/[\r\n]+//g;
         $git_work_tree =~ s,\\,/,g;

