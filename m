From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Mon, 16 Nov 2015 19:59:40 +0100
Message-ID: <564A279C.6000802@web.de>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
 <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 20:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyP0U-0004RI-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbKPS76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 13:59:58 -0500
Received: from mout.web.de ([212.227.15.3]:50623 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbbKPS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 13:59:57 -0500
Received: from [192.168.178.41] ([79.211.113.40]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MNt8d-1a0LkX0OFP-007TlQ; Mon, 16 Nov 2015 19:59:46
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
X-Provags-ID: V03:K0:VtDp+O/H2mb2b+TgR/yS4dYq2CEjjCaJket6HQCuebW1Gll0UIb
 Oa5OrBnLYqxEfyidhcIwA3907zkbn+Sl3FAVOQQDXrYlph9i0qXTacIYULC7hpds8PqqmSC
 hgr+8WSPo8r3Taolm3ZJWJLe5XQnMHSBhYFA+1ttp/cxzST0jj0BbYqxinpgDeDxaJXn+Qe
 S/+U+vNn7NqLvBvGYmfjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+NVLygIHx9g=:SrtxqWPjQUaWOpeezrRS0v
 daRX26+yUobdbLPzmc+vE31jGM8PRFRuJtpz2D7tKYRA9AwD56PvZZhsrD55y7sox1TGJEiMh
 DvCgNaH9KeIYh7ZfMazbmssCv+mnb9mD/IqgGw1TqbqLEoZmCl24C4p2PQdv5GRZSG3Uu3BwQ
 lBKWcPKSkEIUTGu4t/uEj4+j0yIkDJyd+/Yxtb8dacVDL+xIyokW2HaKBryZE19/IiV32K8vV
 uW/CMLK/1ui1YiZ2SBrT2JaBiipMOIA3SV0OskQL4xDGvjEp+cjgPhetOPkdObKhFgP18FAn2
 Pt1zyIp7mr+/dxUv0hi4lgyJHuIJfewctDmUkvgAnmFu25+fLWBIvzMY9C0cT+70/0+oItiqJ
 vayF0+qpZEo7SY693S6Lvycn2t7PzmpnD8CRgc9mo/6gVCOrPiCpjVW2tpMFHwzutfq2RypQz
 EClB0IcavSLucFCSlxwH2VJpGAymOAMazvndiYkjfhJlBej7PHJVmkEirODoY54aPqsZKQE/Q
 F3LrgRbuLsEKZFdKp3PcxtC+De4jtPAo+Wzf5ajNsfw3+BiRS/RbV0AtG3BgFIZr29GfI6q24
 Z60LDVp2pB36mE0A9WgLkiACY33vkuoEPKxd1Si7bhErOVaHwXIGqL5tr6ftyDb67KXBgDB0c
 X2KfBnMYUr52Flp27hn7R9Jag3DgWOg8j3h54w2ceOlYrI5QxcUHtOnCit/sEx7xJy961iQL5
 g33yVmL3wU8DiylT14+CjDAEbAO3OzO30llLOb1gA4Zn+GaXijxEJxvWb9pyBRs7+CzhaiDE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281352>

Am 14.11.2015 um 01:10 schrieb Stefan Beller:
> On Fri, Nov 13, 2015 at 3:41 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, Nov 13, 2015 at 06:38:07PM -0500, Jeff King wrote:
>>
>>> On Fri, Nov 13, 2015 at 03:16:01PM -0800, Stefan Beller wrote:
>>>
>>>> Junio wrote on Oct 09, 2014:
>>>>> This is so non-standard a thing to do that I doubt it is worth
>>>>> supporting with "git clone".  "git clone --branch", which is about
>>>> "> I want to follow that particular branch", would not mesh well with
>>>>> "I want to see the history that leads to this exact commit", either.
>>>>> You would not know which branch(es) is that exact commit is on in
>>>>> the first place.
>>>>
>>>> I disagree with this. This is the *exact* thing you actually want to do when
>>>> dealing with submodules. When fetching/cloning for a submodule, you want
>>>> to obtain the exact sha1, instead of a branch (which happens to be supported
>>>> too, but is not the original use case with submodules.)

Yes, being able to fetch certain sha1s makes lots of sense for submodules
(this has been discussed some time ago at a GitTogether). But - apart from
the extra network load - it's rather helpful to get all the submodule
branches too (though that could be limited to the branches the sha1 is on).

>>> I think this is already implemented in 68ee628 (upload-pack: optionally
>>> allow fetching reachable sha1, 2015-05-21), isn't it?
>>
>> Note that this just implements the server side. I think to use this with
>> submodules right now, you'd have to manually "git init && git fetch" in
>> the submodule. It might make sense to teach clone to handle this, to
>> avoid the submodule code duplicating what the clone code does.
>
> Yes I want to add it to clone, as that is a prerequisite for making
> git clone --recursive --depth 1 to work as you'd expect. (such that
> the submodule can be cloned&checkout instead of rewriting that to be
> init&fetch.

Cool, that should help recursive fetch too.

> Thanks for pointing out that we already have some kind of server support.
>
> I wonder if we should add an additional way to make fetching only some
> sha1s possible. ("I don't want users to fetch any sha1, but only those
> where superprojects point{ed} to", even if you force push a superproject,
> you want to want to only allow fetching all sha1s which exist in the current
> superprojects branch.)

Me thinks the restrictions for sha1-fetching could come from the branches
these sha1s are found in the upstream submodule: if the client is allowed
to fetch a branch, it should be able to fetch any sha1 on that branch.

> Maybe our emails crossed, but in the other mail I pointed out we could use
> some sort of hidden ref (refs/superprojects/*) for that, which are
> allowed to mark
> any sort of sha1, which are allowed in the superproject/submodule context
> to be fetched.
>
> So whenever you push to a superproject (a project that has a gitlink),
> we would need to check serverside if that submodule is at us and mark the
> correct sha1s in the submodule. Then you can disallow fetching most of the sha1s
> but still could have a correctly working submodule update mechanism.

And what happens if the submodule isn't at us? Involving the serverside of
a superproject in submodule fetching sounds wrong to me. Me thinks that
the upstream of the submodule should always control if a sha1 is allowed
to be fetched. Or did I understand you wrong?
