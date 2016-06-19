Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEB420189
	for <e@80x24.org>; Sun, 19 Jun 2016 15:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbcFSPXE (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 11:23:04 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35892 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbcFSPXB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 11:23:01 -0400
Received: from PhilipOakley ([92.22.79.20])
	by smtp.talktalk.net with SMTP
	id EeWCbi3B4t5H9EeWCbg3Ya; Sun, 19 Jun 2016 16:20:12 +0100
X-Originating-IP: [92.22.79.20]
X-Spam:	0
X-OAuthority: v=2.2 cv=EuiQlmUA c=1 sm=1 tr=0 a=ehTV0LARBE9/uVrq78YREg==:117
 a=ehTV0LARBE9/uVrq78YREg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=anyJmfQTAAAA:8 a=P1vQPCeb5RehdSyEHyMA:9 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=YJ_ntbLOlx1v6PCnmBeL:22
Message-ID: <F6172B8DA802476C863849DEA02684A7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Ovatta Bianca" <ovattabianca@gmail.com>, <git@vger.kernel.org>
References: <CAHWPVgNrTEw9FmW6K7QucgA74QWsTKfxZGt+mGd099k+O7O+rw@mail.gmail.com> <CAHWPVgMWeHoD5vTiFJ1gsm2hS74LK7j4npVVbOZeR43cX3qWXw@mail.gmail.com>
Subject: Re: what is a snapshot?
Date:	Sun, 19 Jun 2016 16:20:14 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfI1PwoZeLkzQy44EXnlImcJTd5ONeGxmxH5/KQFKJi+fXHXFQNEZxZ73Kn74rnrVHKg/+YvQs14xAgPOpLT8LXrTCf7r0Ye4GXfHm+2pKq7Lqlqiz8tW
 MVZFiQm3XCJx5k1S0jZmaavQveURZetpDqgG+wLP+XQiHWqjMYmjbI3XU1pT6R2OZJNrW81iq3nq6dR3kvcdwIRvFtjdcDm11x0=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Ovatta Bianca" <ovattabianca@gmail.com>
>I read in every comparison of git vs other version control systems,
> that git does not record differences but takes "snapshots"
> I was wondering what a "snapshot" is ? Does git store at every commit
> the entire files which have been modified even if only a few bytes
> were changed out of a large file?
>
A snaphot is like a tar or zip of all your tracked files. This means it is 
easier to determine (compared to lots of diffs) the current content.

Keeping all the snapshots as separate loose items, when the majority of 
their content is unchanged would be very inefficient, so git then uses, at 
the right time, an efficient (and obviously lossless) compression technique 
to 'zip' all the snapshots together so that the final repository is 
'packed'. The overall effect is a very efficient storage scheme.

There are some good explanations on the web, such as the
https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
though you may want to scan from the beginning ;-)

--
 Philip 

