Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD621FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 11:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbcLLLpC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 06:45:02 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:19021 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbcLLLpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 06:45:01 -0500
Received: from PhilipOakley ([92.22.43.52])
        by smtp.talktalk.net with SMTP
        id GP2QcoDjzg5ctGP2QcCIeh; Mon, 12 Dec 2016 11:44:59 +0000
X-Originating-IP: [92.22.43.52]
X-Spam: 0
X-OAuthority: v=2.2 cv=bdMpa6HB c=1 sm=1 tr=0 a=TiUaNfyp0frjGcgCwpSSeA==:117
 a=TiUaNfyp0frjGcgCwpSSeA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=lA2rK6zZORSxTSK1rqEA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <775B98CA998147CC9A68CF6040B86CE1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "David Aguilar" <davvid@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Git ML" <git@vger.kernel.org>
References: <20161210032144.25503-1-davvid@gmail.com> <20161210032144.25503-2-davvid@gmail.com> <37d8bc43-9f24-b8e8-cb52-de9cc9b2adde@kdbg.org> <20161212071646.5bqnnjpfnmnj6fm4@gmail.com>
Subject: Re: [PATCH 2/2] mergetools/tortoisemerge: simplify can_diff() by using "false"
Date:   Mon, 12 Dec 2016 11:44:59 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNMhz+X0CAJaYSNdpdkkrR1pN0CwpnF0VtTKkYZFbCiWbAQbFgpReYJhzhl+IDGYfqFKzqo8osAKb+FIEPdw+0oP+Dc/GZA8Kkd10asVyM+pOGu25TuQ
 K/tavVLOa3bM/37TQOsfS7R1kzF7GFEv28/gLIik8mMYZlPpThz7D4cjzLx7RHOlfkjgY6la1rfl3q4epgfbwz8U5YAVIdYIsYpD0VbfML59lyaavB/1wSue
 7w4oZC5n0Ab20fXYDWhaMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "David Aguilar" <davvid@gmail.com>
> On Sat, Dec 10, 2016 at 09:15:34AM +0100, Johannes Sixt wrote:
>> Am 10.12.2016 um 04:21 schrieb David Aguilar:
>> > Signed-off-by: David Aguilar <davvid@gmail.com>
>> > ---
>> > This patch builds upon da/mergetool-trust-exit-code
>> >
>> >  mergetools/tortoisemerge | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
>> > index d7ab666a59..9067d8a4e5 100644
>> > --- a/mergetools/tortoisemerge
>> > +++ b/mergetools/tortoisemerge
>> > @@ -1,5 +1,5 @@
>> >  can_diff () {
>> > - return 1
>> > + false
>> >  }
>>
>> Why is this a simplification?
>>
>> My concern is that 'false' is not necessarily a shell built-in. Then this 
>> is
>> actually a pessimization.
>
> The "simplification" is semantic only.
>
> Motivation: if someone reads the implementation of can_diff()
> and it says "false" then that communicates intent moreso than
> reading "return 1", which a programmer unfamiliar with shell
> conventions might misinterpret as boolean "true".
>

Is this a case where a short comment would be informative?

 + return 1 /* shell: false */


> I care less about semantics then I do about making things better
> for Windows, so we can forget about these two patches.
> -- 
> David
>
--
Philip 

