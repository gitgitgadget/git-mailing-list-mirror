Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA7A1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcGSTPa (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:15:30 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:13400 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbcGSTP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:15:28 -0400
Received: from PhilipOakley ([92.22.38.182])
	by smtp.talktalk.net with SMTP
	id PaUGbV8OAHGLwPaUGbDzWm; Tue, 19 Jul 2016 20:15:26 +0100
X-Originating-IP: [92.22.38.182]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=LaaBIPhnSQCmsaQFFm7g3w==:117
 a=LaaBIPhnSQCmsaQFFm7g3w==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=V1XGMniltzrKZIOxx9EA:9 a=cKTwJymBmNURp5Cx:21
 a=2J1pbIElbZiCM1p4:21 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <1D7B90EDE07E4B1BA1175C18946D5D2D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	<git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	"Jeff King" <peff@peff.net>,
	"\"Junio C Hamano\"" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
References: <20160630202509.4472-1-philipoakley@iee.org> <20160711202518.532-1-philipoakley@iee.org> <20160711202518.532-5-philipoakley@iee.org> <5784F43E.3080400@xiplink.com> <xmqqwpkq6b4d.fsf@gitster.mtv.corp.google.com> <D94C739D5C334AFE9E5E8410147899EA@PhilipOakley> <578E4F4A.2020708@gmail.com>
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot notations
Date:	Tue, 19 Jul 2016 20:15:25 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGRSMlsfAn5D6JHGsP70WNQr/5ugPmYMUg/lrb5JB7Olbn+t8gzyhDZ/rssYSXyNXrHsTTLOmrUoKBx5RWndmBKWyQlYcfZRLWTmTSZhL/YWhE/veWyZ
 lDZ32+krIDMHR+Llo3w+sjCvoW3MbPsLSF26y8TX7rk5M0imQv4i8FMAJQqlIoDIbIyhhy2o70hKV8AdkjaRLCHHPdvVrrP62DKzqJxhkaZda2jczJQJ3ZlG
 +2iVN6Ov4lro4ZE5nF3WayXR0VKcl2Eem1CPuOXH6kw=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Jakub Narębski" <jnareb@gmail.com>
>W dniu 2016-07-13 o 00:11, Philip Oakley pisze:
>> From: "Junio C Hamano" <gitster@pobox.com>
> [...]
>>> I actually think this is a good place to have them described.
>>> <rev>^<number> is about specifying a single commit.  These two are
>>> not that (you can say HEAD^2^@ but you cannot say HEAD^@^2, for
>>> example).
>>
>> These two are special cases I'm not too familiar with, particularly
>> the r1^! which I didn't understand from the description...
>
> <rev>^@ is all parents of <rev>, that is
>
>  <rev>^@  ==  <rev>^1 <rev>^2 ... <rev>^<n>
>
> where <n> is number of parents commit <rev> has.
>
>
> <rev>^! is (if standalone) a single commit range, only <rev> revision.
> It is actually
>
>  <rev>^!  ==  ( <rev> --not <rev>^@ )
>
> that is, reachable from <rev> but not from any of its parents.
> Parentheses here denote that `--not` does not affect the rest of
> rev-like parameters.
>
>
> Hope that helps
> -- 

The tricky part is seeing that, rather than being a depth wise range, it's 
actually a width wise range that is designed to cover the scenarios around 
merges

e.g. $ git rev-parse 6c71a849^!
or $ git rev-parse 6c71a849^@

In the doc that I'm updating I'll add a comment that it's particulalry 
useful around merges.

Mind you I did see dscho quote it in $gmane/299738
" You can also inspect the diff of a commit, using the ^! suffix, e.g.

  git difftool -x diff origin/master~3^!

--
Philip 

