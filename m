From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Tue, 17 Nov 2015 20:46:14 +0100
Message-ID: <564B8406.9070706@web.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 20:46:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZymDH-0008R4-4q
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 20:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbbKQTqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 14:46:42 -0500
Received: from mout.web.de ([212.227.17.12]:63623 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbbKQTql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 14:46:41 -0500
Received: from [192.168.178.41] ([79.211.115.166]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MMVpy-1a1YA62y10-008JAf; Tue, 17 Nov 2015 20:46:21
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZhn59GTs9LRnAoPrSwf43jjgi0_qWibrQ8gCvjas_MKA@mail.gmail.com>
X-Provags-ID: V03:K0:kHtpgu0tm0l+ht3uNGu6Ivce3+VqVFCdaNmJW/OK/xoB5gjGKhO
 /pzK+mHRE4GhEAkU0i5SpVAvyLrQ9jA3eE0mrMKM6VCxXr37OQR2ZbNXKDvE5wzCpGcKnk3
 wl9ENFJH0lh3j5cok/OWSW7b7hS6250RWcuYb3DoRJP47Es5lnTM1j+lmWm9Eh3fZx14iiK
 bWEzB/F7IpkN8SK4jW55g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nZ0RAvILKbU=:3oRG4fNbGOqvUzyGf4+YIE
 k5xAa21VI5C2JxaK160LNhKUIRhrAVR1MhIWSUV/T+AfWaiI8AkwplGlWRd35IAZIKWI+A1dp
 v9S9lP7fAjwh9FWrnclx8jrweGIHB+TIY5KwtdCqHeEm69bcAHzRM4pc2S53AW9D/PHXx32JQ
 bfZxz2f1zLA+YOV6JE0KBF8VlEn5j4AorHhKpG3cciL9AoiGMGhiCkv56mUQyBRv+7v2y0BOs
 8nMWpEZAH3pu6KuYL7wrVzTe+RipTS8+1vtFXkk9XSYkPNy1+lBkc4EvOdD2HD3UIOQg0ZAWY
 6Q1CuXLN8DZiJTFNteGjp7X4mc1ypLHOL3s84l+ZlqZOltSH7h7x1e8CDkW66ZZrCYM+zCoJW
 uyMTAm4dUIrKTyGF40IdPQbMNsUJfNlRnQZeP1km0b3tEKFB7M5STAo8lZXPC6ZMNiapNnsuL
 5o/2hAcumugm/SOLKeRETEdbf8Or9MgM3GXxQnWdYlUuxSviR3ZvJ+HJPtujfQSjJD8N3DjpC
 Y67k0UeTyY68llGQwZZsdpHlkgxpIFJHEjyu24tdO5AUXLleQxwXYL5pL5pkrsQX2tVhNFRhi
 qG62BFyoV9f9Ccku62Cc5qIX8oaUlKpMO4KOOSpvflav+P3EnsZuVOgnO1d2XxhO0mzDAwXa3
 JaCdIoVTN5Lf5Pu/DKkTaSJwc7OGGC7hSjhr8/GbfAzkmZuK4xYLQUJJhCAs81oU3T3SvgCFI
 p60m6H8AvyjEMkgh44TzhtBK7ln37Y7DmxevbqlVPgoE9ZYjQNhPDc4lCYtodfNBI89qGN11 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281414>

Am 16.11.2015 um 23:56 schrieb Stefan Beller:
> On Mon, Nov 16, 2015 at 1:42 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 16.11.2015 um 20:25 schrieb Stefan Beller:
>>>
>>> On Mon, Nov 16, 2015 at 10:59 AM, Jens Lehmann <Jens.Lehmann@web.de>
>>> wrote:
>>>>
>>>> Am 14.11.2015 um 01:10 schrieb Stefan Beller:
>>>>>
>>>>> Thanks for pointing out that we already have some kind of server
>>>>> support.
>>>>>
>>>>> I wonder if we should add an additional way to make fetching only some
>>>>> sha1s possible. ("I don't want users to fetch any sha1, but only those
>>>>> where superprojects point{ed} to", even if you force push a
>>>>> superproject,
>>>>> you want to want to only allow fetching all sha1s which exist in the
>>>>> current
>>>>> superprojects branch.)
>>>>
>>>>
>>>>
>>>> Me thinks the restrictions for sha1-fetching could come from the branches
>>>> these sha1s are found in the upstream submodule: if the client is allowed
>>>> to fetch a branch, it should be able to fetch any sha1 on that branch.
>>>
>>>
>>> I'd agree on that. The server side even with uploadpack.allowTipSHA1InWant
>>> set, is not sufficient though.
>>>
>>> To fetch an arbitrary sha1, you would need to check if that sha1 is part
>>> of the history of any advertised branch and then allow fetching
>>> serverside,
>>> which sounds like some work for the server, which we may want to avoid
>>> by having smarter data structures there.
>>>
>>> Instead of having to search all branches for the requested sha1, we could
>>> have
>>> some sort of data structure to make it not an O(n) operation (n being
>>> all objects
>>> in the repo).
>>>
>>> Maybe I overestimate the work which needs to be done, because the server
>>> has
>>> bitmaps nowadays.
>>>
>>> Maybe a lazy reverse-pointer graph can be established on the serverside.
>>> So I guess when we add the feature to fetch arbitrary sha1s, reachable
>>> from
>>> any branch, people using submodules will make use of the feature. (such as
>>> with
>>> git fetch --recurse --depth 1 or via a new `git fetch --recursive
>>> --up-to-submodule-tip-only`)
>>>
>>> So once the server is asked for a certain sha1, it will do the
>>> reachability check,
>>> which takes some effort, but then stores the result in the form:
>>> "If ${current tip sha} of ${branch} is reachable, so is requested $sha1."
>>>
>>> So when the next fetch request for $sha1 arrives, the server only needs to
>>> check for ${current tip sha} to be part of $branch, which is expected to
>>> be
>>> a shorter revwalk from the tip. (Because it is nearer to the tip, a bitmap
>>> could
>>> just tell you or at least shorten the walk even more)
>>> If the ${branch} has changed, the next evaluation for $sha1 can update
>>> the cache,
>>> such that the reverse lookup is not expensive on expectation.
>>
>>
>> Makes sense, although I do not know enough about the server side to tell if
>> it would need such an optimization or will cope with the load just fine.
>>
>> But even if we'd enable such a feature without having to set an extra config
>> option, a submodule fetch asking for certain sha1s would have to fall back
>> to a simple "fetch all" like we do now when the server doesn't support that
>> for backwards compatibility. But maybe that's just obvious.
>
> It's not obvious to me.  Say you run the command:
>
>      git clone --recursive --depth=1 ...
>
> Currently the depth argument for the submodules is ignored, because it
> doesn't work out conceptually. This is because recursive fetches fetch the
> branch tips and not the submodule-specified sha1.
>
> If we want to make it work, we would need to think about, what we want
> to achieve here.
> depth is usually used to reduce the transmit time/bandwidth required.
>
> So if the server tells us it's not allowing fetching of arbitrary
> sha1s by its cryptic message:
>
>      $ git fetch origin 6f963a895a97d720c909fcf4eb0544a272ef7c49:refs/heads/copy
>      error: no such remote ref 6f963a895a97d720c909fcf4eb0544a272ef7c49
>
> we have two choices, either error out with
>
>      die(_("Server doesn't support cloning of arbitrary sha1s"))
>
> or we could pretend as if we know how to fix it by cloning regularly
> with the whole history
> attached and then present a tightened history by shallowing after
> cloning. But that would
> defeat the whole point of the depth argument in the first place, the
> time and bandwidth would
> have been wasted. So instead I'd rather have the user make the choice.

But for quite some time you'll have older servers out there that
don't support fetching a single sha1 or aren't configured to do so.
Wouldn't it be better to give the user an appropriate warning and
fall back to cloning everything for those submodules while using the
optimized new method for all others and the superproject? Otherwise
you won't be able to limit the depth if only a single submodule
server doesn't support fetching a single sha1.
