From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Problems switching branches
Date: Fri, 05 Nov 2010 07:36:09 +0100
Message-ID: <4CD3A5D9.6070802@seznam.cz>
References: <loom.20101103T032930-451@post.gmane.org> <loom.20101104T012032-963@post.gmane.org> <AANLkTikK93Jt+dAkpp6K-hQEo6D67q5OKJSLs+g0YL4y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 05 07:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEFuN-0002PZ-R4
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 07:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab0KEGgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 02:36:14 -0400
Received: from smtp.seznam.cz ([77.75.72.43]:55534 "EHLO smtp.seznam.cz"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750728Ab0KEGgN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 02:36:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=Y2Ns1me5D/QXQBw4msCqxBrpnEoxE6GUYbMncffWJi0o+xdFCU3EQmm0JHjDXz5Mp
	pofnOJ+Dd21Rxxz5rs5+Tpoq8FlHtXxk/HMNI84LgsVoRwU+4sZUvRC/2Dng6lyqu/0
	Cs+cM60MVJAnsGLy67drdg4RTyWluUDNCKGzCM0=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: is OK
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay2.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Fri, 05 Nov 2010 07:36:07 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTikK93Jt+dAkpp6K-hQEo6D67q5OKJSLs+g0YL4y@mail.gmail.com>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 2590
X-Country: CZ
X-QM-Mark: email-qm5<560910070>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160800>

On 10-11-04 15:39, Nguyen Thai Ngoc Duy wrote:
> On Thu, Nov 4, 2010 at 7:23 AM, Maaartin <grajcar1@seznam.cz> wrote:
>> Maaartin <grajcar1 <at> seznam.cz> writes:
>>
>>>
>>> I sometimes run in a problem similar to
>>> http://kerneltrap.org/mailarchive/git/2008/10/15/3667644/thread
>>> There are some ignored files which I want neither track nor throw away; I'm
>> just
>>> happy to have them and keep them out of version control.
>>>
>>> Unfortunately, there weren't ignored in the old branch. I'd be quite happy
>> with
>>> non-destructive switching like "checkout everything what doesn't overwrite an
>>> untracked file", so I would end in the old branch with a dirty working tree.
>> Is
>>> it possible?
>>
>> No answer?
> 
> Which means nobody is interested in. Well, not really.
> 
> I also get irritated by a similar situation, where the untracked files
> have the same content as the to-be-checked-out files. I have been
> tempted (but never got around) to make git compare the in-index
> content and the untracked file, if it's the same, no need to abort the
> checkout process.

I was asked to provide a working example of the happening, but I haven't
managed to reproduce it yet. However, it's not very rare (it just never
happen when I need it).

> But your approach may be better. Yes, I think it's possible. Any
> suggestion for checkout's new argument? --no-overwrite-untracked seems
> too long.

I would go even further: a switch called "ignorant" or "lenient"
allowing to always switch branches in a non-destructible way. All files
normally causing abort would be left unmodified, so you could do
git checkout --ignorant forth; git checkout back
and would (assuming you started in branch "back") land in the original
state without loosing anything. Of course, this means, that the ignorant
checkout doesn't lead you into a clean state, but that's why I'd like to
use a switch instead of making it the default. :)

I may be talking non-sense as I'm quite inexperienced user, however I'd
love an easier way for switching branches. Quite often, I'd like to put
a modified file onto a different branch. This sounds probably strange,
but my work is really quite chaotic in this respect at the moment and
I'd like to organize it better by using a couple of (quite similar)
branches (with a lifespan of a few days at most).
