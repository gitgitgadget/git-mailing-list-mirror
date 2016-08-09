Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A521FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbcHILzQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:55:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47069 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366AbcHILzO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 07:55:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 93D1F20231;
	Tue,  9 Aug 2016 07:55:13 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 09 Aug 2016 07:55:13 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ce465pom1Az2oxH+j5RRJBD4bWY=; b=JJrfJR
	TqZ6c3u5QxWYEItWodZ2G5QyuC70frMe5DZQPS4uV2pDPPSVRa4+OutO6Ahj50Rc
	ow83L8MtmHBV3W457GjaLooafD9ZQTEegsDLi66RQY2eBjq7sc3q1hXXw/xh78+q
	IcgVpIELfeg1bMqi78SkKky1hw3ond1ay8kCU=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ce465pom1Az2oxH
	+j5RRJBD4bWY=; b=r+4/dSq33MUQHO/1B2D9gNUvMMebacEPZONiiFb6eMJFIRl
	OjNfkXyUabGFiMDhNTG86LfFcjT8o0ntjUEylaOPrwbb5eDO0KVDhsZr9koAytBE
	L7gyLwBhLtpzz1OSP+KomAf/i3C0gZinf780yKjCaOE5PjZ0Ra7yufkCgwn4=
X-Sasl-enc: 11IfyyID75R7vucqx5b3enj2bTvjKBvNkybnsYu7Mmzc 1470743713
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id C0E0ACCDC0;
	Tue,  9 Aug 2016 07:55:11 -0400 (EDT)
Subject: Re: Thunderbird woes, was: Re: patch submission process, was Re:
 [PATCH v6 06/16] merge_recursive: abort properly upon errors
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <CANQwDwe7_op_L9UkmFUO39s7z9t4xgS+Ui_2FkA3oKG7T5wBxA@mail.gmail.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Newsgroups: gmane.comp.version-control.git
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <1daae316-8527-8c43-95fe-58d8421721bd@drmicha.warpmail.net>
Date:	Tue, 9 Aug 2016 13:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <CANQwDwe7_op_L9UkmFUO39s7z9t4xgS+Ui_2FkA3oKG7T5wBxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski venit, vidit, dixit 09.08.2016 10:24:
> On 9 August 2016 at 10:11, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>> My own setup
>> ============
>>
>> My usual MUA is Thunderbird because of its integration with calendars
>> and address books. I usually read and post to mailing lists via
>> nntp/gmane, that works best for me for several reasons (e.g. archive
>> available when I need it).
>>
>> For git-ml, I had to learn early on to answer by e-mail to git-ml rather
>> than by nntp-reply because proper nntp-replies somehow didn't meet the
>> expectations of the e-mail users (double copies because of the cc-policy
>> or such, I don't remember).
> 
> I use either KNode or Thunderbird with NNTP/Gmane, and I don't have
> any problems when doing "Reply All" even if I forget to remove nntp-reply.
> You should do reply-all anyway, because not everyone is subscribed,
> and not everyone uses nntp-ml.

There used to be a problem (many years ago), so let's see...

> 
>> I use git sendemail even for small throw-in patches because the git-ml
>> does not allow attachments but wants patches (files) as in-line text,
>> and Thunderbird possibly reformats text (because it's text, you know).
> 
> For some strange reason Thunderbird used as NNTP reader does not
> screw up with whitespace, while Thunderbird used as email client does.
> Al least it did last time I forgot to create new email in its NNTP reader.

You mean, "format fl[ao]wed" is not used when posting via NNTP? That
still wouldn't help with reply all.

> Note that git-format-patch has Thunderbird subsection in the
> "MUA specific hints" section.

I know, but that changes config (esp. wrap+flowed) for all e-mails. I
would be nice if using an external editor would turn off TB's mangling.

>> When I want to try out a proposed patch I have to "save message" and run
>> git-am because patches don't come as file attachments on the git-ml
>> (can't use "save/open attachment"+ git-apply) nor a PR (can't use git
>> fetch nor view in browser).
> 
> Inline are preferred over attachment because it is easier to review
> and comment on online patches. Anyway, it is the same amount of
> steps, and git-am preserves commit message.

I know why we do that, but attachments are there for a reason (stable
transport), and sending attached patches would be much easier for many
MUAs. It just shows that for nowadays usage of e-mail (not withstanding
Junio's historic remarks), using in-line text as a stable transport is
really "very special", to put it mildly.

>>                                        If it's a series, I have to do that for each
>> invididual patch, which usually means I simply don't (or rely on Junio
>> doing it and fetch his xy/topic branch).
> 
> I think you can save-all on the whole thread...

I'll definitely try, thanks.

Michael

