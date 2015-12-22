From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 11:34:31 -0800
Message-ID: <xmqqsi2ucm60.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
	<56796F37.1000600@alum.mit.edu>
	<CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
	<567985A8.2020301@alum.mit.edu>
	<CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
	<xmqq1taee1w9.fsf@gitster.mtv.corp.google.com>
	<CAJo=hJswuPdLT0KtGdf_=UGxD7-5NjGk2mwFjRU=uYb-Su-y+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 20:34:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBShv-0007TA-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 20:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602AbbLVTer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 14:34:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbbLVTeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 14:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 246D03614A;
	Tue, 22 Dec 2015 14:34:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ERXLXr/AOh8bQaKNvDL05We+s4U=; b=lHt9EZ
	GjqXrqW5HKpD2eLPaYpXdHcJZLxNPv66b2gkK3DC13ANcIVGrWzaw4sKiVHQvQuY
	Y1TA8ADLutzzIW+OjnZJt5gCO8pPHzeT4QrttFIxCltOon4CB2x3ofrCRYmXAtQ1
	MvZ6ipjinrtQ3HWuJIBaEBNZ+/IGyqfgZHgLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pcBlaZ1WUPp6hBFZA/iQaiKiH+HAzTOY
	hpV1L+uhL9KaFFUlMLz0XfDYQWrgdfcHYguyM/2lcG9sdBYZisZNePRNbYgQZ/Yv
	UjMARLqUtTTe3b8QFGgHKxP5APeonEnloe4ZFZwNvacxbstI8NaCzh7SgK18l9RH
	4peo7Gx3/xw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A61436149;
	Tue, 22 Dec 2015 14:34:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DEED36148;
	Tue, 22 Dec 2015 14:34:45 -0500 (EST)
In-Reply-To: <CAJo=hJswuPdLT0KtGdf_=UGxD7-5NjGk2mwFjRU=uYb-Su-y+A@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 22 Dec 2015 11:11:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E523434-A8E3-11E5-8592-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282903>

Shawn Pearce <spearce@spearce.org> writes:

> On Tue, Dec 22, 2015 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>>
>>>> But really, aside from slightly helping
>>>> disambiguate references from paths in the command line, what is it good
>>>> for?
>>>
>>> Nothing really; today refs/ prefix is used to encourage to the tools
>>> that you really meant refs/heads/master and not
>>> refs/heads/heads/master or some other crazy construct. You can thank
>>> the DWIMery inside the ref rev parse logic for needing this.
>>
>> Aren't you two forgetting one minor thing, though?
>>
>> A layout without refs/, i.e. $GIT_DIR/{heads,tags,...}, will force
>> us to keep track of where the tips of histories are anchored for
>> reachability purposes, every time you would add a new hierarchy
>> (e.g. $GIT_DIR/changes)--and those unfortunate souls who run a
>> slightly older version of Git that is unaware of 'changes' hierarchy
>> would weep after running "git gc", no?
>
> You still store them under refs/

Well I know; the comment was merely a reaction to the exchange
between you two, "What is refs/ good for?", "Nothing really".

You'd benefit by having "refs/" that is known to contain all the
anchoring points for reachability without knowing what subhierarchy
it may contain in the future, that is what it is good for.
