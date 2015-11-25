From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 5/5] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 23:30:05 +0100
Message-ID: <5656366D.4010508@web.de>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
 <1448415139-23675-6-git-send-email-sbeller@google.com>
 <5655F544.6050003@web.de>
 <CAGZ79kZrBRo9dfU=p8-bgvSpp=SSiXQHZGm7iCQ=9v0f_f_-aQ@mail.gmail.com>
 <565610FD.9070303@web.de>
 <CAGZ79kY8=HbKB-om+FynDPf0w4c=12PtJ_9CsUyBU21yyD4CXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:30:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1iaE-0001FK-LF
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 23:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbbKYWah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 17:30:37 -0500
Received: from mout.web.de ([212.227.17.11]:56574 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbbKYWag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 17:30:36 -0500
Received: from [192.168.178.41] ([79.211.124.82]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MOzoR-1Zvv9A2807-006OER; Wed, 25 Nov 2015 23:30:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CAGZ79kY8=HbKB-om+FynDPf0w4c=12PtJ_9CsUyBU21yyD4CXA@mail.gmail.com>
X-Provags-ID: V03:K0:uRG/C6NmHetzkct8mWKW1vTlUb0YTo2+I+oIE+bMf7DW9VJtMzI
 02CabyQd13L1MqdrP7kmMw7R+1dAS4MucfF6AdUy7BRbIo4/bYoboSeG946Xqh8CZCeOTHz
 rE3uG1rap1rxb1i52KpI/mb2QVqzJ9SD5a7Ahihm5/WNWxqRxDgZPEjhVD0w8jnHP4RCigs
 MAkx/DKGHCrUh4MuYXpgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ErJSf0JjbOg=:+CILgUX+wpp7aa8cKduDTF
 h7pVKbZ2CfojzopICRO37o2ar33YofZNV0+W9A2xB/5p1ThyTif8UoTcgjDqlK2/vd5nTXD4I
 DHaXgU5TCStBmJ2V/c1mMC67XegAnW7uWj2Uhbvsme7amngbI1ak0rHwL31eh/dwZiAqe73Yo
 8jRsQw80NyGx1GPSHs+73APu6xmpmsc4umUN54jW51zSyRuEcIM/ZaxzLMMXteevNoYm8mkgB
 slZnZ+rECDaf0NmgH31IjOQc+POJc4dtiX3GYl5aklAbQs8LxNlxFpNFgRPKNgEPiSkvmc1ca
 Fbxyo9cbh1lV3Og10FXL3UEzmiSZEuIH6bqwZ+sL8mRGXkZ7Flo0k/D3i9vNpWdOwsnwGbvNP
 iEKSU6PBqhhT9QPCfTmDeSr2wxnsXxraUttWuW9YzJLjEkZtj5I0sjIpLRHXFTGT0yeLIXcXO
 iRtR6ny7lW5oezQ9/fM4kH0oQ73qeA9qbKPTV6kWaJApCC+LqUIDhCOfwEET2hY7U2dpRq7T+
 6VWJp3y1AFqUuebm1dFl46q4K4XcBiqg+vEKF3+N8E6zKZYT4oafWyBpM6FfIxtAg2JF0F52r
 9x6SaSq2SqPCHP/RLxy4dVB7O0fBNGTB+A3gWmTjiYKgFasqVK06wnPWswEjLPadaFFd7Xuj1
 +gzK7LSyTO2IRhOoa8hlvwjqczCybJQLLzu6wHkb1EHMHDBPrVh0flYp9EpoIZSQo1k13uGuL
 ogHZAo1Tv94MUA45F56ANmeAS7Lfl9Vl83iMijHcKvWx9eEAj+lpasA7MBfd1gnz9VQ6HFJL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281748>

Am 25.11.2015 um 21:03 schrieb Stefan Beller:
> On Wed, Nov 25, 2015 at 11:50 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>>> My thinking is that groups are implying recursive, whereas recursive
>>> implies
>>> "all groups", so a git clone --group <half-the-submodules> --recursive
>>> makes not much sense to me as it begs the question, what does --recursive
>>> mean?
>>
>>
>> Groups are only about what submodules to update and have nothing to
>> do with recursion. It might make sense to imply recursion, but that's
>> just because that should have been the default for submodules from day
>> one. Recursion and groups are orthogonal, the first is about what to
>> do inside the submodules (carry on or not?) and the latter is about
>> what to do in the superproject (shall I update this submodule?).
>
> I see. So we would not want to mutually exclude recurse and groups,
> but rather have groups implies --recurse, but you are allowed to give
> --no-recurse if you explicitely do not want to recurse into the subsubmodules.

Exactly.

>>> And then get all the nested submodules. But in case
>>>
>>> you use the grouping feature, you could just mark the nested submodules
>>> with
>>> groups, too?
>>
>>
>> Not in the top superproject. In a submodule you can specify new groups
>> for its sub-submodules, but these will in most cases be different from
>> those of the superproject.
>>
>> Imagine I have this really cool Metaproject which contains the Android
>> superproject as a submodule. Those two will define different groups,
>> and when recursing into the android submodule I need to choose from the
>> Android specific groups. So my Metaproject's .gitmodules could look like
>> this:
>>
>> [submodule "android"]
>>          path = android
>>          url = git://...
>>          groups = default,mobile
>>          subgroups = devel
>>
>> "groups" tells git what superproject groups the android submodule
>> belongs to, and "subgroups" tells git what android submodules are
>> to be checked out when running recursively into it. If you do not
>> configure "subgroups", the whole android submodule is updated when
>> one of the groups "default" or "mobile" is chosen in the superproject.
>
> I like the concept of subgroups as it allows to have some control over
> subsubmodules you may want to aggregate from a third party via the
> middleman submodule.

That's the point (though maybe someone might come up with a better
name than "subgroups" ;-). And each repo configures its own submodule
groups.

> I'd prefer to delay that feature though by not giving a high priority.

No problem, we can start with "check out all subsubmodules" for now.
But I suspect we'll need subgroups rather sooner than later.

> Also would you go with subsubgroups, too? When does the recursion
> end?

Subsubgroups do not make sense in the superproject, that can only
configure its direct submodules. I think you are talking about the
groups of the subsubmodules, and these have to be chosen inside the
first level submodules via the subgroups of its submodules (which
are the second level submodules of the superproject). Still with
me? ;-) So the recursion can go on forever even as soon as we
implement the subgroup configuration.

 > In case we have more than the union of groups, but also prohibitive
> terms available, could subgroups clash with the submodules groups spec?

Not that I'm aware of. Groups decide which submodules to update and
only for those submodules subgroups tell git what group to use inside
that submodule. And so on.
