From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Fri, 12 Sep 2014 13:28:11 +0200
Message-ID: <5412D8CB.4000809@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <20140910081358.GB16413@peff.net> <CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com> <20140910103014.GA15461@peff.net> <xmqq7g1bifm0.fsf@gitster.dls.corp.google.com> <20140910191159.GA23655@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:35:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSP8M-0003Ae-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 13:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbaILLfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 07:35:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51164 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087AbaILLfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 07:35:16 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 07:35:16 EDT
X-AuditID: 12074412-f792e6d000005517-43-5412d8ce2df5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 15.A2.21783.EC8D2145; Fri, 12 Sep 2014 07:28:14 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CBSBOd029638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 07:28:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140910191159.GA23655@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqHvuhlCIwe6dChZdV7qZLBp6rzBb
	PJl7l9mie8pbRosfLT3MFp0dXxkd2Dx2zrrL7vHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujPtPJjAVzJWrWLH4KmMD40SJLkZODgkBE4nPyy6xQdhiEhfurQey
	uTiEBC4zSrQ/amCHcM4zSSzft4MZpIpXQFti36x2sA4WAVWJfe9fgsXZBHQlFvU0M4HYogIB
	Eh86HzBC1AtKnJz5hAXEFhFwlLiw5QgLyFBmgS2MEk1Pj7KDJIQFnCT+/LzODLFtHpPEqW/n
	wDo4BfQkfq65AFbELKAu8WfeJWYIW16ieets5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMT
	M3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUKCX2gH4/qTcocYBTgYlXh4K1gEQ4RYE8uKK3MP
	MUpyMCmJ8mpcFwoR4kvKT6nMSCzOiC8qzUktPsQowcGsJMLLDow5Id6UxMqq1KJ8mJQ0B4uS
	OO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCV4WkEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTU
	osTSkox4ULzGFwMjFiTFA7RXHGxvcUFiLlAUovUUoy7Hus5v/UxCLHn5ealS4rwWIIcLgBRl
	lObBrYCluleM4kAfC/O+AKniAaZJuEmvgJYwAS15NwdsSUkiQkqqgTFD4MiZXI2EK9tP9Bwo
	r7xvEFTybP6tVPbJ+49bPJ8uOv+YrsHKy05r699f++4pYtkgtvEUk+VHqUfRV2Vr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256917>

On 09/10/2014 09:11 PM, Jeff King wrote:
> On Wed, Sep 10, 2014 at 09:51:03AM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> Yes, we don't let normal fetchers see these repos. They're only for
>>> holding shared objects and the ref tips to keep them reachable.
>>
>> Are these individual refs have relations to the real world after
>> they are created?  To ask it another way, let's say that a branch in
>> a repository, which is using this as a shared object store, caused
>> one of these refs to be created; now the origin repository rewinds
>> or deletes that branch---do you do anything to the ref in the shared
>> object store at that point?
> 
> Yes, we fetch from them before doing any maintenance in the shared
> repository (like running repack). That's how objects migrate into the
> shared repository, as well.
> 
>> I am wondering if it makes sense to maintain a single ref that
>> reaches all the commits in this shared object store repository,
>> instead of keeping these millions of refs.  When you need to make
>> more objects kept and reachable, create an octopus with the current
>> tip and tips of all these refs that causes you to wish making these
>> "more objects kept and reachable".  Obviously that won't work well
>> if the reason why your current scheme uses refs is because you
>> adjust individual refs to prune some objects---hence the first
>> question in this message.
> 
> Exactly. You could do this if you threw away and re-made the octopus
> after each fetch (and then threw away the individual branches that went
> into it). For that matter, if all you really want are the tips for
> reachability, you can basically run "for-each-ref | sort -u"; most of
> these refs are tags that are duplicated between each fork.
> 
> However, having the individual tips does make some things easier. If I
> only keep unique tips and I drop a tip from fork A, I would then need to
> check every other fork to see if any other fork has the same tip. OTOH,
> that means visiting N packed-refs files, each with (let's say) 3000
> refs. As opposed to dealing with a packed-refs file with N*3000 refs. So
> it's really not that different.

I think it would make more sense to have one octopus per fork, rather
than one octopus for all of the forks. The octopus for a fork could be
discarded and re-created every time that fork changed, without having to
worry about which of the old tips is still reachable from another fork.
In fact, if you happen to know that a particular update to a fork is
pure fast-forward, you could update the fork octopus by merging the
changed tips into the old fork octopus without having to re-knit all of
the unchanged tips together again.

The shared repository would need one reference per fork--still much
better than a reference for every reference in every fork. If even that
is too many references, you could knit the fork octopuses into an
overall octopus for all forks. But then updating that octopus for a
change to a fork would become more difficult, because you would have to
read the octopuses for the N-1 unchanged forks from the old octopus and
knit those together with the new octopus for the modified fork.

But all this imagineering doesn't mitigate the other reasons you list
below for not wanting to guarantee reachability using this trick.

> We also use the individual ref tips for packing. They factor into the
> bitmap selection, and we have some patches (which I've been meaning to
> upstream for a while now) to make delta selections in the shared-object
> repository that will have a high chance of reuse in clones of individual
> forks. And it's useful to query them for various reasons (e.g., "who is
> referencing this object?").
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
