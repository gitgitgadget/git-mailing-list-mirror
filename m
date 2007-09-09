From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sun, 09 Sep 2007 02:29:40 +0200
Message-ID: <46E33E74.20105@op5.se>
References: <46DDC500.5000606@etek.chalmers.se>	 <vpq642pkoln.fsf@bauges.imag.fr>	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>	 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>	 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>	 <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>	 <46E0F04D.7040101@op5.se> <a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:50:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOI-0003uy-Ss
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:38 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAme-0007iQ-Ho
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:36:16 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAmY-0007RN-Ul
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbXIIA3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXIIA3o
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:29:44 -0400
Received: from mail.op5.se ([193.201.96.20]:43732 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbXIIA3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:29:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8566F194428;
	Sun,  9 Sep 2007 02:29:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HpeCEWyExvW; Sun,  9 Sep 2007 02:29:42 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 6B8F8194390;
	Sun,  9 Sep 2007 02:29:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.8, required=12.0, autolearn=disabled, AWL=0.250,UIO_VGER=-3)
X-UiO-Scanned: EE4BAEFB31EB13B3967C477E2E8C1644F15CCBFB
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -27 maxlevel 200 minaction 2 bait 0 mail/h: 24 total 517810 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58147>

Dmitry Kakurin wrote:
> On 9/6/07, Andreas Ericsson <ae@op5.se> wrote:
>> They already have, but every now and then someone comes along and suggest
>> a complete rewrite in some other language. So far we've had Java (there's
>> always one...), Python and now C++.
> 
> Since this "complete rewrite" was mentioned in multiple emails I'd
> like to rectify that:
> What I'm offering (for Git) is to use C++ as a "better C".
> Don't change any existing *working* code, but start introducing simple
> C++ constructs in the new code.
> Git is simple enough to not require any high-level abstractions. But
> some utility classes could make code much simpler.
> 

There are far too many highly valuable contributors that have spoken
against C++ for me to believe that C++ and C will ever co-exist in the
official git repo. Good thing utility classes can be developed on top
of the existing C-code, but in a separate repo, and packed into a
library. That way, you get some hacking ground for your beloved C++
coderswhile the current git contributors can keep contributing in the
language they like best.


> And BTW, I don't even like C++ that much :-), I just like it much
> better than C.  I've been saying that C++ is a legacy language for
> quite some time now. But we will use it for many years to come because
> the size of this legacy code is huge, so there will be plenty of C++
> developers available (to contribute to Git :-).

The C code base is a lot larger and C++ will drop dead pretty fast if it's
ever removed or left unmaintained. So much for dinosaurs...

> And C++ is the only way to move with existing C codebase.

Complete and utter BS. It can also stay in C, or get language bindings for
Python/Perl/PHP/LUA(?)/whatever, or both.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
