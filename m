From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 08:31:41 +0200
Message-ID: <46E0F04D.7040101@op5.se>
References: <46DDC500.5000606@etek.chalmers.se>	 <1189004090.20311.12.camel@hinata.boston.redhat.com>	 <vpq642pkoln.fsf@bauges.imag.fr>	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>	 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>	 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org> <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXNd-0002am-KL
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbXIGGbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbXIGGbo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:31:44 -0400
Received: from mail.op5.se ([193.201.96.20]:60851 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbXIGGbo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:31:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DE7F31943E7;
	Fri,  7 Sep 2007 08:31:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jN99Cz7AMns8; Fri,  7 Sep 2007 08:31:42 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 4542619439E;
	Fri,  7 Sep 2007 08:31:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57986>

Dmitry Kakurin wrote:
> On 9/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
>>> As it is right now, it's too hard to see the high-level logic thru
>>> this endless-busy-work of micro-managing strings and memory.
>> Total BS. The string/memory management is not at all relevant. Look at the
>> code (I bet you didn't). This isn't the important, or complex part.
> 
> Not only have I looked at the code, I've also debugged it quite a bit.
> Granted most of my problems had to do with handling paths on Windows
> (i.e. string manipulations).
> 
> Let me snip "C is better than C++" part ...
>> [ snip ]
> ... and explain where I'm coming from:
> My goal is to *use* Git. When something does not work *for me* I want
> to be able to fix it (and contribute the fix) in *shortest time
> possible* and with *minimal efforts*. As for me it's a diversion from
> my main activities.
> The fact that Git is written in C does not really contribute to that goal.


Coupled with what you said in an earlier mail, namely
---%<---%<---
> Obviously C++ developers can contribute C code. But assuming that they
> prefer it that way is wrong.
> 
> I was coding in Assembly when there was no C.
> Then in C before C++ was created.
> Now days it's C++ and C#, and I have never looked back.
---%<---%<---

Considering C appeared in 1972, and C++ appeared in 1985, you have been
writing C code for 13 years. And you're telling me that git being written
in C prevents you from contributing?

If you want to do something useful in C++ for git, make it easy for C++
programmers to write apps for it.

> 
> Now, I realize that I'm a very infrequent contributor to Git, but I
> want my opinion to be heard.
> People who carry the main weight of developing and maintaining Git
> should make the call.

They already have, but every now and then someone comes along and suggest
a complete rewrite in some other language. So far we've had Java (there's
always one...), Python and now C++.

It happens to all projects, sooner or later. The funny thing is that all those
people that want their favourite software to be rewritten in their favourite
programming language always wants someone else to rewrite it for them.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
