From: david@lang.hm
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:36:32 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810311835500.5851@asgard.lang.hm>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
 <20081101010620.GD29036@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:37:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5QW-0007HK-SN
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbYKABgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbYKABgB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:36:01 -0400
Received: from mail.lang.hm ([64.81.33.126]:60489 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbYKABgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:36:01 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mA11ZqV1029764;
	Fri, 31 Oct 2008 17:35:52 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20081101010620.GD29036@artemis.corp>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99702>

On Sat, 1 Nov 2008, Pierre Habouzit wrote:

> On Sat, Nov 01, 2008 at 12:41:22AM +0000, david@lang.hm wrote:
>> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>>
>>>> I.e. use the supplied custom function to do proprietary magic, such as
>>>> reading the object lazily from elsewhere over the network.  And we will
>>>> never get that magic bit back.
>>>
>>> As a maintainer I'd never accept such a patch.  I'd ask for the
>>> code under read_object_custom, or toss the patch on the floor.
>>> But that doesn't stop them from distributing the patched sources
>>> like above, keeping the fun bits in the closed source portion of
>>> the executable they distribute.
>>>
>>> Maybe I just think too highly of the other guy, but I'd hope that
>>> anyone patching libgit2 like above would try to avoid it, because
>>> they'd face merge issues in the future.
>>
>> the issue that I see is that libgit2 will be (on most systems) a shared
>> library.
>>
>> what's to stop someone from taking the libgit2 code, adding the magic
>> proprietary piece, and selling a new libgit2 library binary 'just replace
>> your existing shared library with this new one and all your git related
>> programs gain this feature'
>
> Its license. GPL even with GCC exception would not allow you to do that.
> Though they could propose a fork of the library patched, with the patch
> distributed. The downside would be that their code would not be binary
> compatible with the "true" libgit2, so they would probably have to
> change the name to avoid namespace clashes, or overwrite the "real"
> library.

the proposal had been for the library to be BSD, not GPL. and I don't see 
any reason why such a thing couldn't be done with a BSE library.

David Lang

> But yes, it's theoretically feasible. I'm not sure it would be worth the
> hassle, and if they respect the license (if they don't they can already
> do that with the current git anyway) then the fact that someone would
> want to do something like that would be known fact, probably not
> avoided, but known.
>
>
