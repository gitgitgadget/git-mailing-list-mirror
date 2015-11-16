From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Mon, 16 Nov 2015 22:42:09 +0100
Message-ID: <564A4DB1.4070507@web.de>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
 <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de>
 <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:42:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyRXe-0004NO-PL
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 22:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbbKPVmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 16:42:22 -0500
Received: from mout.web.de ([212.227.15.3]:62298 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbbKPVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 16:42:21 -0500
Received: from [192.168.178.41] ([79.211.113.40]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MDPUT-1aAr3m0OvF-00Gq79; Mon, 16 Nov 2015 22:42:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
X-Provags-ID: V03:K0:CXLki7K77bHJjmp1aoNUs0QDwxMplREu5gKP9+jHoqHoca+uyNK
 PsY0tQ4sZ6fJYmV3qXqPpnIASz/I2UtSkw6IrLxu0isseL1R1F2LmwZKt3sSBoM6a8MSa2w
 s4oFnxn0t+tEYQomvFjYbRAjkehPUkXtjdI5ukR85c7WvJsdAvkgclPh7YHuQddF24Zt9r/
 ALT1UDBLE7ZJQeCqZN4CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0WXeFkZbYYI=:fAlV8VmFaPi6SitUiaeRUL
 E6dz4+KJcRBMuhujfjYv341Wx2rJ3aIg9WhBincKyS1N8WS5+2JvYqFSlEADub5rjA3gJqFDH
 +Ty+9QwNwp+E2oyt+sJR/nQoJKfzmutWv6y0nCK/ntJSYJgyHTvUv7Fz8NI5jYuNTmNR4NXc5
 nx+/w3q36stqbOsYBY9H6aGoP2TBVSZExEe6bTduNZdWPTniQ6KFprxFzBQYsd8tCiDv0vlrG
 OtlY0Q4kBzee2Kq3H44x43hDEKVCN5MPAz1YRUsBnjM7jAu9G64B6LdwU6H2GNGa1IKq6GK5A
 1WPSc3z32tfHmoTLbJae2aYNNrNRbcz+ExbL6SJBnnF+sk9zWpEYm4AAQO6zi4ttldKDmlUbN
 vzWIq6MAKGB/KJJvOs541X01aL1mApVzSrhnvmTmis3Ln1C4AQDdaQXwuHyduCAJ2PuMuzeLW
 V7V4Qp2RTsERk04kCbRNfai8ynYonDDZCCJPED8KSIsK4yJ0b0gsjFyi+cFqg+p9RQXt2w8j6
 PzuV34la6R9hy9ylnXaUOvU4vqRjbiAyARlkNMqBMrY/FSyWP3+NMoxsF6VgtKUmpy5mAQJs4
 8z1Vk8YN7R0jmBUKOEt3sNdv86e6f4SkQ9KrQJuLzsyPAOktaxnps2YizDGgBoWPPO5WRowey
 JnTvoaGj2FerXOMfabXgBg2qo6HNLsHpkFFjwseMa1y5DmnwRGBOfgW5zwqMPln6EZdgIMVCl
 CtqeR0fU8B0kFkDngrYWAVd7WRzNTweawH1hJpiBAm1TdRrsGUg5vUHBVKXLdYGn8bPrxerk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281358>

Am 16.11.2015 um 20:25 schrieb Stefan Beller:
> On Mon, Nov 16, 2015 at 10:59 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 14.11.2015 um 01:10 schrieb Stefan Beller:
>>> Thanks for pointing out that we already have some kind of server support.
>>>
>>> I wonder if we should add an additional way to make fetching only some
>>> sha1s possible. ("I don't want users to fetch any sha1, but only those
>>> where superprojects point{ed} to", even if you force push a superproject,
>>> you want to want to only allow fetching all sha1s which exist in the
>>> current
>>> superprojects branch.)
>>
>>
>> Me thinks the restrictions for sha1-fetching could come from the branches
>> these sha1s are found in the upstream submodule: if the client is allowed
>> to fetch a branch, it should be able to fetch any sha1 on that branch.
>
> I'd agree on that. The server side even with uploadpack.allowTipSHA1InWant
> set, is not sufficient though.
>
> To fetch an arbitrary sha1, you would need to check if that sha1 is part
> of the history of any advertised branch and then allow fetching serverside,
> which sounds like some work for the server, which we may want to avoid
> by having smarter data structures there.
>
> Instead of having to search all branches for the requested sha1, we could have
> some sort of data structure to make it not an O(n) operation (n being
> all objects
> in the repo).
>
> Maybe I overestimate the work which needs to be done, because the server has
> bitmaps nowadays.
>
> Maybe a lazy reverse-pointer graph can be established on the serverside.
> So I guess when we add the feature to fetch arbitrary sha1s, reachable from
> any branch, people using submodules will make use of the feature. (such as with
> git fetch --recurse --depth 1 or via a new `git fetch --recursive
> --up-to-submodule-tip-only`)
>
> So once the server is asked for a certain sha1, it will do the
> reachability check,
> which takes some effort, but then stores the result in the form:
> "If ${current tip sha} of ${branch} is reachable, so is requested $sha1."
>
> So when the next fetch request for $sha1 arrives, the server only needs to
> check for ${current tip sha} to be part of $branch, which is expected to be
> a shorter revwalk from the tip. (Because it is nearer to the tip, a bitmap could
> just tell you or at least shorten the walk even more)
> If the ${branch} has changed, the next evaluation for $sha1 can update
> the cache,
> such that the reverse lookup is not expensive on expectation.

Makes sense, although I do not know enough about the server side to tell if
it would need such an optimization or will cope with the load just fine.

But even if we'd enable such a feature without having to set an extra config
option, a submodule fetch asking for certain sha1s would have to fall back
to a simple "fetch all" like we do now when the server doesn't support that
for backwards compatibility. But maybe that's just obvious.

> I assume this will mostly be used with submodules, so only a few sha1s need
> this caching.

I won't bet on that, some of the submodules at $DAYJOB are rather busy and
see almost the same traffic as their superprojects ;-)

>>> Maybe our emails crossed, but in the other mail I pointed out we could use
>>> some sort of hidden ref (refs/superprojects/*) for that, which are
>>> allowed to mark
>>> any sort of sha1, which are allowed in the superproject/submodule context
>>> to be fetched.
>>>
>>> So whenever you push to a superproject (a project that has a gitlink),
>>> we would need to check serverside if that submodule is at us and mark the
>>> correct sha1s in the submodule. Then you can disallow fetching most of the
>>> sha1s
>>> but still could have a correctly working submodule update mechanism.
>>
>>
>> And what happens if the submodule isn't at us? Involving the serverside of
>> a superproject in submodule fetching sounds wrong to me. Me thinks that
>> the upstream of the submodule should always control if a sha1 is allowed
>> to be fetched. Or did I understand you wrong?
>
> Yes and no.
> The serverside submodule repository should be responsible for the ultimate
> decision if you are allowed to fetch that sha1. But maybe on pushing the
> superproject, we can store a hint in the submodule, that this sha1 is legit.
> Although I may be missguided in my thinking here as the superproject
> should have no influence on the submodule.

Submodules should never be aware of their superproject. But a superproject
does know its submodules, so I don't think the influence you describe here
is a problem per se. It's just looking like a corner case to me, as in a
lot of scenarios submodules do not live on the same server. And even if
they do, a superproject has no canonical way of finding their submodule's
repos (except for submodules that use relative URLs). So I'd rather like
to see a generic solution first, before we think about adding an optimized
version for certain setups later ;-)

The only real itch I have with the "superproject declaring submodule sha1s
fetchable on the server" approach is that it smells like a security problem.
The access rights of superprojects are often different from those of the
submodules it contains and this feels like a privilege escalation waiting
to happen.
