Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A6F1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 22:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbcHNWpl (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 18:45:41 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:26187 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbcHNWpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 18:45:40 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z49xb40UzcpskZ49xbC84r; Sun, 14 Aug 2016 23:45:37 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=8adiN4cOISVGyTmF7W8A:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <6ACCC850AC434350B15AADC19F02760B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>
References: <20160814214630.1312-1-philipoakley@iee.org><20160814214630.1312-2-philipoakley@iee.org> <xmqq60r3knoz.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v1 1/3] doc: commit: --fixup/--squash can take a commit revision
Date:	Sun, 14 Aug 2016 23:45:37 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHswcRV/Wwfeeqo9E0NDrvWvaDrQHjiEfaF6uU0kbSfRBGpjdaxMjwWYu34JziSVsHtd6HwQPpoeuaJa/qdoIseaXKbQqiXsuCHv/tpenj6lK7xuAGHu
 A6IAkocPjHf4P9Cwasj3kvogDNK15lL8ixW69xBeAx3t/4gGDQyUR51SZ5k8RpXMIwzfJzldLEr8Bg==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>> Be clearer that the --fixup/--squash options can take any of the
>> gitrevisions methods of specifying a commit, not just a 'hash'.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> ...
>> @@ -81,15 +81,15 @@ OPTIONS
>>  --fixup=<commit>::
>>  Construct a commit message for use with `rebase --autosquash`.
>>  The commit message will be the subject line from the specified
>> - commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
>> - for details.
>> + commit revision with a prefix of "fixup! ".  See linkgit:git-rebase[1]
>> + and linkgit:gitrevisions[7] for details.
>
> The same comment applies to the other hunk, but rephrasing "commit"
> with "commit revision" (the latter is not even in the glossary) does
> not make it clearer at all.  Especially when discussing rebases and
> anything that rewrites commits, it can easily be mistaken as if you
> are talking about v2 of the commit by fixing up the original, but
> that is not the impression you want to give.

Hmm, had to read that a few times before I saw what you meant regarding 'v2' 
as the revised commit.

>
> "The specified commit" is clear enough.  It may be debatable if we
> want to talk about "how" to specify the commit, though.

Exactly. The latter.

> I think the
> use of "commit" in an angle-bracket-pair in the label for the
> section, i.e. "--fixup=<commit>", has been considered to be clear
> enough to tell that you can use usual extended SHA-1 syntax to
> specify the commit you want to talk about,

I certainly hadn't picked up on that ability to use the extended sha1 syntax 
(specifying revisions...) here.

Part of the issue is that the whole fixup/squash capability is buried within 
just two documents as asides [1], and in the place it's spelt out (in 
rebase) it talks about the commit message being used, which is just part of 
the confusion.

>  but if so, that is not
> limited to this entry, and I do not think this description or the
> other one for the "--squash" option are particularly worse than
> those for the "-c" and "-C" options.  The description for "-c" does
> say "Take an existing commit object", but that's like "the specified
> commit" used here.
>
OK
--
Philip
[1] just looked at the new Progit version and fixup/squash is not even 
mentioned. 

