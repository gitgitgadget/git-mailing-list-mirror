Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8FE21F991
	for <e@80x24.org>; Tue,  8 Aug 2017 10:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbdHHKTT (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 06:19:19 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:24490 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdHHKTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 06:19:18 -0400
Received: from [192.168.2.201] ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id f1bVdMuF2iSHaf1bWd0LPg; Tue, 08 Aug 2017 11:19:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1502187557; bh=jZdkF7+IOG/koGO/LWGxh9d8w1LP8rDj26hRmtP/FZM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JUESYh2VfYhj1tKq6SdnxDK35gOuxhRn8DI/n5Vk9CzZ2Dt1SHqqMJ7fOADNfUhep
         9slzt3i+aMp0A5NjUfihE1+F41JuW1CjAAy/Aorlx/5K6WixwCPxeExufOF9dIIF2Y
         qGRWDcalfS7YuQnac0yKveOlfNkKehIy/Y9FISmI=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=nN7BH9HXAAAA:8 a=evINK-nbAAAA:8 a=Hch8RmjGfV37O2t2vpwA:9
 a=WsVQF6AVmxf3viEG:21 a=CL3Rsg6AOTFQ_DpA:21 a=QEXdDO2ut3YA:10
 a=SHUmGpGg8TAA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1] am: fix signoff when other trailers are present
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170807102929.25151-1-phillip.wood@talktalk.net>
 <xmqqfud3qndj.fsf@gitster.mtv.corp.google.com>
 <20170807110817.3cf7d8ff@twelve2.svl.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <532d2ea6-0562-e9d0-b1a6-43b3805854c8@talktalk.net>
Date:   Tue, 8 Aug 2017 11:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170807110817.3cf7d8ff@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCQcx0nKH4qbHXa0OybM37C+ENLx1dN4L9A9lI7n0ZBSRT1DSn3Us4GQRP/Qo0jhu0vALFwvyzpFavgQ6Mpa/tCcmwyX8cTaogZrj+/bCZzdHR/pcLJb
 XgoHzIV7QHhnD1fVVreugtMGy47uOpKR1XE2oQ6UOTMzbL/CDzxqkWnTMOiIN4lRGRMenl4lPTi0gpT/1lepkUQes7QnGhiTVsFO+iFZdxcTOFk3qGvvXqry
 Wn9kXmddLskAuE7cuoPpBPj6i/GLD7VWQs3J2Ayv1XwmALy31VUi3/I46E6sn9Z48sdFMZiVr4melvaBY0aRnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/17 19:08, Jonathan Tan wrote:
> On Mon, 07 Aug 2017 10:49:28 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> If there was no 'Signed-off-by:' trailer but another trailer such as
>>> 'Reported-by:' then 'git am --signoff' would add a blank line between
>>> the existing trailers and the added 'Signed-off-by:' line. e.g.
>>>
>>>     Rebase accepts '--rerere-autoupdate' as an option but only honors
>>>     it if '-m' is also given. Fix it for a non-interactive rebase by
>>>     passing on the option to 'git am' and 'git cherry-pick'.
>>>
>>>     Reported-by: Junio C Hamano <gitster@pobox.com>
>>>
>>>     Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Fix by using the code provided for this purpose in sequencer.c.
>>> Change the tests so that they check the formatting of the
>>> 'Signed-off-by:' lines rather than just grepping for them.
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>> I'm not sure if this should be calling ignore_non_trailer() or not -
>>> git commit does but git cherry-pick does not. This follows commit and
>>> cherry-pick in ignoring the value of trailer.ifExists for the signoff.
>>> I'm a bit surprised they do that - is it correct?
>>
>> These built-in "sign-off" machinery long predates the "trailer"
>> thing, so I am not surprised if they do not behave the same.  I
>> vaguely recall having discussions on this earlier this year, but
>> details escape me.  
>>
>> Asking Jonathan, who did a series that ends at 44dc738a ("sequencer:
>> add newline before adding footers", 2017-04-26), and Christian, who
>> is the original contirbutor to the "trailer" machinery, for input.
> 
> Regarding ignore_non_trailer(), I believe that's because "git commit"
> wants to tolerate blank lines and comments after the "real" commit
> message, whereas "git cherry-pick" doesn't need to. As far as I can
> tell, this "git am" case is similar to "git cherry-pick".
> 
> Regarding trailer.ifExists, the then existing behavior was to refrain
> from writing a new sign-off line only if it would be a duplicate of the
> last one, regardless of trailer.ifExists (as Junio says, back then, the
> sign-off mechanism and the trailer mechanism were independent). I
> preserved that behavior.
> 
Hi Jonathan

Thanks for the background. I'll remove the call to ignore_non_trailer()
