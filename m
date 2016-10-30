Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87ABD20193
	for <e@80x24.org>; Sun, 30 Oct 2016 20:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754381AbcJ3UJY (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 16:09:24 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:39376 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbcJ3UJX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 16:09:23 -0400
Received: from PhilipOakley ([92.22.67.46])
        by smtp.talktalk.net with SMTP
        id 0wPwcC3dEgKst0wPwcsHl2; Sun, 30 Oct 2016 20:09:21 +0000
X-Originating-IP: [92.22.67.46]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=gkpEzfRoWBGLV12Co9DAOA==:117
 a=gkpEzfRoWBGLV12Co9DAOA==:17 a=IkcTkHD0fZMA:10 a=LSoLMkvJcCqgiXk9i2QA:9
 a=QEXdDO2ut3YA:10
Message-ID: <223121D101D844DEBF086AC40A5AF4CB@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Anders Kaseorg" <andersk@mit.edu>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, <842477@bugs.debian.org>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Vasco Almeida" <vascomalmeida@sapo.pt>
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu> <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com> <alpine.DEB.2.10.1610301503280.60842@buzzword-bingo.mit.edu>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside scripts
Date:   Sun, 30 Oct 2016 20:09:21 -0000
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
X-CMAE-Envelope: MS4wfElPwS7VwQKqrPGLE3LNzZHET1cfvxpg9IGGsNu92qPJaUr+h3eoa7EfbjrXksOHLh7mC9AX69RPszDe4W3k7nNA5xzTe/86MIsWDqAgQsVtcUxdBe1M
 Pdnt1R43JBF+WkaKEwtnB4VTfU+TSmPjjIQdPWgWys+cSww+ExDXoKukjjljQLwEiToQCxg8FOLQKbnI70zMmnpCz5TPq+jyb/7fLDSQxPD2kCdC0gv7OkLR
 RKUHxvGILcOHYK+yLxAE2UZiaHIO63+/2SA8zLk7cUuovG8mfWGFnr7yPauYFzr18vyDTki0E1ULkDQwKUVO3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Anders Kaseorg" <andersk@mit.edu>
> On Sun, 30 Oct 2016, Ævar Arnfjörð Bjarmason wrote:
>> This seems like a reasonable fix for this issue. However as far as I
>> can tell git-sh-setup was never meant to be used by outside scripts
>> that didn't ship as part of git itself.
>>
>> If that's the case any change in the API which AFAICT is now
>> considered internal might break them, so should some part of that be
>> made public & documented as such?
>
> It is documented (Documentation/git-sh-setup.txt), and this is not the
> internal Documentation/technical section of the documentation, so my
> default assumption would be that everything shown there is intended as
> public.  I only bring this up as a question because it was apparently
> allowed to break.  If I’m wrong and it isn’t public, other patches are
> needed (to the documentation and to its users in contrib).
>
But the Documenation does say ::

- This is not a command the end user would want to run. Ever.

- This documentation is meant for people who are studying the Porcelain-ish 
scripts and/or are writing new ones.
--

So there is a cautionary word or two there...

The question would then become: what (if anything) was missing in the 
documentation?...
maybe the inclusion of Ævar's "[Not] to be used by outside scripts that 
didn't ship as part of git itself."?
Or a comment that it may change in newer versions.
Though the code fix may still be reasonable..


Philip 

