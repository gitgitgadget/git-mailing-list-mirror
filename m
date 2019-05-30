Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86BD1F462
	for <e@80x24.org>; Thu, 30 May 2019 19:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfE3T0d (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 15:26:33 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:16117 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3T0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 15:26:33 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id WQh3h9OtIWIpcWQh3h8Wi3; Thu, 30 May 2019 20:26:30 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=NkpywU9UMNdMBJRXH48A:9 a=QEXdDO2ut3YA:10
Subject: Re: Request: git add --interactive: split hunk: When can't split
 further, split on empty lines
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Harvey <jamespharvey20@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CA+X5Wn5bt-3zHUqtRDWtc0A82SFmWPuQ0+RvRLaAV6Vn24nf4g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905301644020.44@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <aad93135-6280-ac6a-c72a-8a325fbbaf67@iee.org>
Date:   Thu, 30 May 2019 20:26:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905301644020.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfPMcKfrRS6nSNUwy/FBQp5MY7O6b/HrT603YhmrGab6fs9+Nh9Y7A1u93LOOAfG9mvEHo1bF4AcBF7XH/BKCC45AR9cbHSmTw/fv0PSHu2eKadtm8xCW
 k/MTLORecEKw3U5+IO22iWZ15cqMuZjJ6xtiAT296uWMAXcXqnrdBxQwaNQqDpv7T2OK+iVSpOHLyPwkzGMqVFqMkSWSZI2MBtLybO4KQj2MQZqnxQmqpybO
 A5tOVnlD0fMgpfT7yvCiWWddebi4HgI41X8jZo0gj3sweH0uGtDQLkV4e0XNJaVxXgWwK5mcAF09W7JzXROnkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,  some minor comments.
On 30/05/2019 15:53, Johannes Schindelin wrote:
> Hi James,
>
> On Wed, 29 May 2019, James Harvey wrote:
>
>> When adding interactively, 's' can be used to split the current hunk.
>> Once it gets down to where 's' reports "Sorry, cannot split this
>> hunk", it could be useful if it would then start splitting based on
>> empty lines, probably leaving empty lines at the top of the split
>> hunks.  It certainly wouldn't be perfect, and might create many hunks,
A binary search style split may be an option to avoid the 'many hunks' 
issue.
>> but it would be a nice alternative to manually editing the hunk.
>> Certainly someone could still manually edit the hunk if they didn't
>> want to use it in a particular situation.
> While a neat idea from the users' perspective, I think that it is
> technically a bit challenging, as you then have a problem to coalesce the
> patches appropriately.
>
> The thing with the splitting at context lines is that you have a much
> easier time to merge individual split-hunks into a "coalesced" hunk
> because the context lines stay context lines.
>
> Having said that, there was a patch series recently to add the ability to
> stage individual lines,
I believe that the git-gui (in tk/tcl, but using git commands) was 
already able to stage individual/selected lines, so there may be some 
ideas from there.

> and I think that your feature request could be
> implemented on top of that.
>
> In the meantime, an Outreachy intern and I worked on turning `git add -i`
> into a built-in (it was written in Perl, and the built-in is written in
> portable C instead), and I *think* that the plan with the patch series to
> stage individual lines was to re-implement it on top of the built-in patch
> series.
>
> Would you be interested in participating in that project?
>
> Ciao,
> Johannes
--
Philip
