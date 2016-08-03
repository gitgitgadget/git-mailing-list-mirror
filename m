Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E201F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbcHCWsm (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:48:42 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49905 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932362AbcHCWsm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:48:42 -0400
X-AuditID: 12074413-aa3ff70000000955-2c-57a273278d30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 3E.E1.02389.72372A75; Wed,  3 Aug 2016 18:41:43 -0400 (EDT)
Received: from [192.168.69.130] (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73MffFj025749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:41:42 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Stefan Beller <sbeller@google.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <bffbbd7b-3e1b-fa6d-ed53-b75a54fd6f69@alum.mit.edu>
Date:	Thu, 4 Aug 2016 00:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1FUvXhRucH2JhUXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MrYv287W8Fjtoot5/kbGFexdjFyckgImEi8/fWbrYuRi0NIYCujROvqJhYI5xyT
	RO+U7WBVwgJBErs37WcEsUUE1CRmrpoN1XGeUWLmymfsIA6zwBNGiXv9N9lAqtgEdCUW9TQz
	gdi8AvYSU/7sBIpzcLAIqEj0T8sHCYsKhEhsu9nABlEiKHFy5hMWEJtTIFBi/rQfYDazgLrE
	n3mXmCFseYntb+cwT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXX
	y80s0UtNKd3ECAlp4R2Mu07KHWIU4GBU4uHdILkoXIg1say4MvcQoyQHk5Iob04qUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIL1M+UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1
	CCYrw8GhJMF7sxCoUbAoNT21Ii0zpwQhzcTBCTKcB2h4HEgNb3FBYm5xZjpE/hSjLseCH7fX
	Mgmx5OXnpUqJ82qAFAmAFGWU5sHNgaWiV4ziQG8J85YXAVXxANMY3KRXQEuYgJacMFgAsqQk
	ESEl1cBYGHRB2VrnxHr5yRuOTqnOXpOiOvd+ZWTGtYTvr3PeP7fSu5YnJn+hWPh4Us2u+iSe
	hbELfOVCHB6+lOeatNR0guiRuPdNjy7vfrB2zkyDu4YaDoUbHf9yX02xiJOY2q8hVu7Enr/n
	fL3n6QA/2zxeL68dmz5q1nRFLFE9681kZ7aj/Z94yx8lluKMREMt5qLiRADrhEleIAMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 12:30 AM, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
>> +        return 10 * score - bonus;
> 
> Would it make sense to define-ify the 10 as well
> as this is the only hardcoded number in the
> scoring function?

I started answering this question by explaining why it is not important
to *optimize* the number 10 (namely because scores are only ever
compared against other scores, so an overall scaling factor makes no
difference). The factor 10 only has to be large enough to provide enough
dynamic range for the other (adjustable) parameters.

But I think you are asking a simpler question: should we give this
constant a name rather than hardcoding it? I don't see a strong reason
for or against, so I'll give it a name in the next version, as you suggest.

Michael

