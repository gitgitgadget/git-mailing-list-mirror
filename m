From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Auto update submodules after merge and reset
Date: Tue, 13 Dec 2011 08:52:07 +0100
Message-ID: <4EE70427.3010605@web.de>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE51D7B.7020806@ursus.ath.cx> <4EE682A3.8070704@web.de> <CABURp0r37+VHBVVKepHPC4jwa-wJ0b+qwLrhhFR8KXnMQYTT3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 08:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaN9u-0002mE-LR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 08:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab1LMHwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 02:52:13 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:56099 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab1LMHwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 02:52:13 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id AE0711BB3DE6F
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 08:52:11 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lud4y-1Qb1A21WE4-00zmTr; Tue, 13 Dec 2011 08:52:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABURp0r37+VHBVVKepHPC4jwa-wJ0b+qwLrhhFR8KXnMQYTT3w@mail.gmail.com>
X-Provags-ID: V02:K0:r5H0MqC3wJZjw+Ww8YdPX5Hni0+eMs9+dHqtgFPva99
 g5r2A7TYiiQTj26mfkixVdVU+jBIdYZJlaQeUbegsSfKbzfeGZ
 cqsDjYH2zjzh7EHIniyjAnus14B6YgL+LAo1DV6gDo/E2i8yDQ
 91wT3BpsiUCU+kFuqLI2/D95+s6AdX+yQzB1R/AwfdVWDVw3pW
 DRJ9lQ/WwvZhrimiDpggw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187008>

Am 13.12.2011 00:43, schrieb Phil Hord:
> On Mon, Dec 12, 2011 at 5:39 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 11.12.2011 22:15, schrieb Andreas T.Auer:
>>> In http://thread.gmane.org/gmane.comp.version-control.git/183837 was discussed whether the gitlink in the superproject should be set to all-zero if updates follow the tip or maybe use the SHA1 of the commit when the submodule was added. I think the gitlink should be updated everytime when a new commit in the superproject is created.
>>
>> Nope, only when "git submodule update" is run. Otherwise you'll spray the
>> history with submodule updates totally unrelated to the commits in the
>> superproject, which is rather confusing.
> 
> And this is why my superproject is a makefile, a .gitmodules file and
> a bunch of gitlinks.  We only use it to track the advancement of
> submodule activity.

Which is fine. Did you think about having a branch where only the
submodules are updated (and built and tested) and committed to by a
buildbot when everything is fine? You could then merge that branch
whenever you want up-to-date submodules and have the reproducibility
of the exact model while being able to "float" along the updates of
that branch?

I think it always boils down to this: Either commit new gitlinks, so
the submodules get updated in a reproducible manner, or don't use
gitlinks at all so the submodules can float wherever they want.

> So yes, I want my superproject's gitlinks to update automatically.  I
> just don't know a smart way to make that happen.

Yup, that has been the endpoint of all discussions about that topic
so far. And until someone comes up with a smart way to make that
happen, I would rather not put something half-baked into git.

(But please tell us when you found a smart way to do that! ;-)
