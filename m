From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Mon, 01 Apr 2013 11:50:18 +0200
Message-ID: <5159585A.3060907@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com> <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 11:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMbOH-0007vU-7b
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 11:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab3DAJu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 05:50:28 -0400
Received: from mout.web.de ([212.227.17.11]:57253 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755804Ab3DAJuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 05:50:24 -0400
Received: from [192.168.178.41] ([91.3.147.157]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M2uj4-1UfvTv1mKs-00s3Sn; Mon, 01 Apr 2013 11:50:22
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:NG6t/43HnJK41WCuVdCiPvOi3LoYz7KMmga3mCbxYKe
 7fo5MrF1Qaru1R7hsyGwUzk8ikxqY1YKa3m/6Q340rxykdNrJc
 k7rXbYm7O9EQKLMU+MnEgKlQ+cSpNB9aOdNIv9ATdNh5WOCrpR
 w8ZAvu0W6DbDiS0oER+cRNLyjwTxt6ylN46uBoxTqLAVh0GGm7
 XPPUXTNU6B03s14z/nqGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219681>

Am 31.03.2013 22:34, schrieb Ramkumar Ramachandra:
>> Are you aware that current Git code already stats all files across
>> all submodules recursive by default? So (again) no problem here, we
>> do that already (unless configured otherwise).
> 
> I didn't know that.  Why does it do this?

To show the user work tree changes inside the submodules too. It
was really easy to forget to commit accompanying submodule changes
when preparing a superproject commit before that (and that broke
quite some builds at my $dayjob until we fixed that).

>> Guess what: submodules are the solution for a certain set of use
>> cases, and tools like subtree are a solution for another set of
>> use cases. There is no silver bullet.
> 
> That's the core of your argument: submodules already solve what it
> was meant to, and we can't get it to solve a larger class of problems.
>  In other words, you're implying that it's impossible to build a tool
> that will be able to compose git repositories in a way that solves a
> very large class of problems.  I don't see conclusive proof for this,
> so I have to disagree.
> 
> To summarize, everyone seems to be elated with the current state of
> submodules and is vehemently defending it.  I'm a little unhappy, but
> am unable to express my discontent in better prose.

I just think it is too early for the "let's do things differently
and redesign stuff" phase. Before doing that we have to clear up
the things that currently don't work for you or are confusing you
about submodules and see if they are already solved (which could
lead to a documentation update) or what it would take to fix them
using current submodule infrastructure. I have the strong feeling
that after we did that, no design changes are necessary anymore.
