From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Sun, 19 Oct 2014 21:34:33 +0200
Message-ID: <54441249.9030206@web.de>
References: <1413090791-14428-1-git-send-email-max@max630.net> <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com> <543D58D9.5060606@web.de> <20141014203114.GB8157@wheezy.local> <CACsJy8AmBr2YTJkVw4BDD95RVE91EEBtEyakOpb77NDXaVBzJA@mail.gmail.com> <xmqq1tq9xnrs.fsf@gitster.dls.corp.google.com> <CACsJy8ABm93QTZm8wnJUYaJ6zC2bXBDyois+Wrq-vCB=DCJmVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 21:34:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfwFY-0006Ip-8u
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 21:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbaJSTek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 15:34:40 -0400
Received: from mout.web.de ([212.227.17.11]:52235 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbaJSTek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 15:34:40 -0400
Received: from [192.168.178.41] ([79.193.78.112]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Mcni1-1XOgTg449Z-00HxoL; Sun, 19 Oct 2014 21:34:34
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACsJy8ABm93QTZm8wnJUYaJ6zC2bXBDyois+Wrq-vCB=DCJmVQ@mail.gmail.com>
X-Provags-ID: V03:K0:45ypid5Ad08PX59aklXzDmTRFtIsFEcW93u4lU2QhBMFmqfqRWV
 Gt2he6P/aDFjNEzs/ScR11TQ3oDYbDwnvnoelTjTrO3VziCJoq3SXGm+FfQ1pBBNgwQ+gpP
 ust0MxB3EJLJ8d1sJwbMpl+1EaNcCYX5B8A45cyTDXTRh2nwm4/d5yqSQ0CMA1x6sBfMFRi
 6xlHmsh1oG1lRHIH/rfbw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2014 um 11:14 schrieb Duy Nguyen:
> On Thu, Oct 16, 2014 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Hmph.  I was hoping that the multiple-work-trees topic was ready for
>> 'next' by now, but we may want to wait to see how the interaction
>> with submodule plays out to have another chance of a clean reroll
>> before it happens.  This is a topic with large impact and is quite
>> intrusive code-wise, even though the intrusive parts are cleanly
>> done.  So we'd want to take more time to unleash it to the general
>> public than more usual small scale topics, anyway.
>
> Originally I wanted to get it merged without submodule support, but I
> failed to spot the local_repo_env problem and could have caused a
> regression for submodules. So yeah delaying the series does not sound
> bad. Not sure about the reroll (i.e. rewriting current patches). I
> think putting patches on top with explanation is better. But we can
> keep it in 'pu' and see if we really need to reroll.

I didn't look into your series in detail, but it looks to my like
excepting the .git/modules directory from sharing (by putting it
into local_repo_env array) and adding a test for that (just to be
sure that no modules directory shows up where it shouldn't) should
be sufficient to get your stuff merged without submodule support.
It might be better to handle submodule support in a follow up series.

Does that make sense?
