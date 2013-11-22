From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 21:20:06 +0100
Message-ID: <528FBC76.5060309@web.de>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com> <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com> <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com> <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com> <20131122151120.GA32361@sigill.intra.peff.net> <CALkWK0myk5fWcHdwNtjct4Ji4y4=iVT36wZxqOqZS6S7kem+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Git List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 21:20:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjxD7-0005ML-T3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 21:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab3KVUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 15:20:13 -0500
Received: from mout.web.de ([212.227.17.12]:55271 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932Ab3KVUUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 15:20:12 -0500
Received: from [192.168.178.41] ([91.3.187.251]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LzKEH-1Vf9zP2Qdd-014PpR for <git@vger.kernel.org>;
 Fri, 22 Nov 2013 21:20:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CALkWK0myk5fWcHdwNtjct4Ji4y4=iVT36wZxqOqZS6S7kem+OQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:1T+xDK46DJrWmn6JsZYTYdATnIv9g4PjTMJ+MOp9i2dujVi7KG7
 Rdg5cLYaUTPt/OO3fK/gNmTRwp+kMEPXrbZd3/8mK9SfeyU5aBQ0hZ8093zeG3RjtsLfAWU
 iVyNq1uAB6awgCiyjxRFh+TCCwnBDDOFaI2aczwNBaw/YKgQmwd00JoNbx0+bmbB01jWSM/
 SsSLxevSUBzgUWDXCBMTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238213>

Am 22.11.2013 17:12, schrieb Ramkumar Ramachandra:
> Jeff King wrote:
>>> I just checked it out: it uses `git ls-files -m` to get the list of
>>> unstaged changes; `git diff --name-only HEAD --` will list staged
>>> changes as well.
>>
>> That diff command compares the working tree and HEAD; if you are trying
>> to match `ls-files -m`, you probably wanted just `git diff --name-only`
>> to compare the working tree and the index. Although in a script you'd
>> probably want to use the plumbing `git diff-files` instead.
> 
> Thanks for that. It's probably not worth fixing ls-files; I'll patch
> Arcanist to use diff-files instead.

Good to have an short term solution for Sergey, but Heiko and I
discussed this issue and agreed that we should fix ls-files. After
all the user explicitly asked not to be bothered with submodule
differences by configuring the ignore setting.
