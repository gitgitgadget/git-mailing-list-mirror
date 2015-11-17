From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Tue, 17 Nov 2015 21:39:45 +0100
Message-ID: <564B9091.7070902@web.de>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
 <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de>
 <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
 <564A4DB1.4070507@web.de>
 <CAGZ79kZhn59GTs9LRnAoPrSwf43jjgi0_qWibrQ8gCvjas_MKA@mail.gmail.com>
 <564B8406.9070706@web.de>
 <CAGZ79kZGdOCzJ5V-RZcBbZE09HsSUQrypHaFT-N8wks7NA=21Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 21:40:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyn2y-0001up-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 21:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbbKQUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 15:40:06 -0500
Received: from mout.web.de ([212.227.15.3]:51489 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbbKQUkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 15:40:04 -0500
Received: from [192.168.178.41] ([79.211.115.166]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LuIAZ-1aPR6y45KR-011fzh; Tue, 17 Nov 2015 21:39:48
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZGdOCzJ5V-RZcBbZE09HsSUQrypHaFT-N8wks7NA=21Q@mail.gmail.com>
X-Provags-ID: V03:K0:aV0RXjUgveA0AWOgnUYIKETa5k7PLVX+I6Saf2Y3RsOP3D9CFzX
 HJ+KzDg5C1a2QqRBHkHp8bNgEj4nmnxZDoRn+oqPBBf1b/dni6HmfiRyR/uOfczWY6GYf/l
 p8p7vxbgsN0MtReQ33B9k5HUSpw2b0LrVr9lkCxIL2HrGAmON2+lZGEt419XQZehceeQ1XE
 2NdHYRQk0xldopP+kC/5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tgVXBmSS2sM=:JfycPbRtGJyH3gw4l8rMlC
 CxxHxvlSst4QEe1U/J7YIEtvy6BIm+eaN7IawVv8INhOrLTgvKH40QCGmCUfNFdnwnMbqwNIX
 S9c3w2EiUGqmt5cCCA2VXU/zuIvzSV7nATeM/0fbmpLSgw1eAeIv9bbUuSogcbH43miTLiJyB
 MPVCGGkq9QaPgbT9q0Bjo4KzE9Z7pjEat7wMVt32sitIjR3N4QDB4M4X2vI1trnp3iXVasEaf
 wwNwmTr1JuRaD/R/24cB/l/gURUbOWN7qACWtgQDBanIUstt2RQcqgUpodAryxMpxFeLLmv1E
 VFDfG3nMNkr5rKhMlDhUbR7/+nUG3IppDpeVYx68NsawimUdh1st5DQfxExsdKz4wJkJ1i86I
 rjPfXrahhEVnikbyhISYGf+Vt6QU0rV6YNxAQkkeXErEpiinS4WEHx7WG4l2TlCFHm9kSRAj2
 rjFGir8X7Z1mVf7GV9oFt0QNvDy+YjC1hhKb/QufFhGTTaYw64qKPP1wqHx++31QDgQpO4HnY
 SugCOKxqaAdREejUL9cj+pjkm12uBwYfb9Kj/PkgPQWu3UvI+lD+m4u/Efq5dUnIM9ijpoE5s
 YgjwhNnp8r82SU59ZCwwdQ9mPsiKQyrTG/63xBd/u3DCgwjOOF2fGDqB1um4DKNgYgOxz7xrD
 yks8YvGDUHmypGfq8w0VbnYGb6k1/MxBnFiacn2ioYTEjFTmpImLzONtMTyJbJ8M586k3ejKt
 tJ+gCCToS2GolQ6uL1pMLwzgjeQqeuam7dKyyXUOFDe0lIz34WL/SJVu4ACjcTKQs8aGxfa4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281417>

Am 17.11.2015 um 21:04 schrieb Stefan Beller:
> On Tue, Nov 17, 2015 at 11:46 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>> But for quite some time you'll have older servers out there that
>> don't support fetching a single sha1 or aren't configured to do so.
>
> Only when talking about the open source side. If you have all the
> submodules/superprojects on your companies mirror, you can control
> the git installations there.

Sure. But that doesn't mean we should make life harder for the open
source side, no? We'll have to support both for quite some time.

>> Wouldn't it be better to give the user an appropriate warning and
>> fall back to cloning everything for those submodules while using the
>> optimized new method for all others and the superproject? Otherwise
>> you won't be able to limit the depth if only a single submodule
>> server doesn't support fetching a single sha1.
>>
>
> I think warnings are fine, but no fallbacks. The warning could look like:
>
>      Server for submodule <foo> doesn't support fetching by sha1.
>      Fetch again without depth argument.
>
> and keep going with the other submodules. This would allow the user
> to make an informed decision if they want to have the fallback solution
> (which requires more band width, disk space)

No, this is a regression. This worked before but now some submodules
are missing from the clone. And if that happens inside a Jenkins
script I doubt that Jenkins can make an informed decision, that job
will simply fail.

> On the other hand, that's what people do today, so it's not that bad either,
> so I guess falling bad would work too.

Not that bad? I don't see any other sane way. Don't break formerly
working use cases without a very good reason. Fall back to what we
did before (even if it is suboptimal) and only then use the new
optimized (and admittedly better) feature when it is available.
