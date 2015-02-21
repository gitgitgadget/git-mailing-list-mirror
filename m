From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Fri, 20 Feb 2015 21:58:07 -0800
Message-ID: <xmqq8ufryff4.fsf@gitster.dls.corp.google.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
	<CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
	<CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
	<CAPc5daVoHCxg8-xEVxJK-G0HKKHApbwCzTd0q6jab5jfyHcarQ@mail.gmail.com>
	<CAGZ79kZAtnhKYQgoA=d-UfQ8LfH4qTxaAFpJRJPSYApD7dwtzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP350-0004qm-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 06:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbbBUF6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 00:58:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750746AbbBUF6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 00:58:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A280B310C2;
	Sat, 21 Feb 2015 00:58:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5DgBTQWt8u3VNPTL+SI0wU8tAi4=; b=uOToNy
	9OqVyfIC/cfC6SCLLwSy/SAJNSWjHf2hILmtGM8cucPPNfBGg2a5pyBxWa2Huc//
	Hilh6XjHssFeZCk7EzboI9f1XNnPOHMnfdrSHgsICT25cPlIx2W1VoTzm6DFGJaf
	Hd/17yrQCak9GDEblKWQoJUAXopICittqWrXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p1Fy6BlGcn/SlgB0xoKZU88MMOmLfTVE
	+Ye3AHcFu4va+G0/aG28VeUc5OcSZDmHNRg8UrXF4MtvZO/gBJOY07NA7G2CL1QP
	1iYecCrpueqS6VHM5nMiY4brFpXoO9f0qajLyaywanpxr3/OrvuVYrStFDARTZOR
	l+YEI3PWteU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98172310C0;
	Sat, 21 Feb 2015 00:58:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A11C310BF;
	Sat, 21 Feb 2015 00:58:09 -0500 (EST)
In-Reply-To: <CAGZ79kZAtnhKYQgoA=d-UfQ8LfH4qTxaAFpJRJPSYApD7dwtzg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 18 Feb 2015 21:12:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C906152-B98E-11E4-BA6D-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264209>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 18, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Wed, Feb 18, 2015 at 4:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>>
>>> This fails from a JGit server because the ref advertisement for an
>>> empty repository differs and disagrees with the format used by
>>> git-core. The result is a confused client spewing an odd checkout
>>> message.
>>
>> That is exactly why the rephrasing was brought up, wasn't it?
>>
>> As the Subject: line says, this thread is for people who want to
>> help those users with un-odd message, so discuss away
>> and come up with a final applicable patch ;-).
>
> "warning: remote HEAD does not exist, not checking out any branch."
>
> would then be the correct answer.

Technically speaking, that is incorrect because HEAD already points
at 'master'.  We DO check out a 'master' branch.  What is unusual is
that the branch has not been born yet, and that is exactly the same
state after 'git init' created an empty directory.  I.e.

	$ git init new
        $ cd new
        $ git remote add origin $URL
	$ git symbolic-ref HEAD
        refs/heads/master

would be exactly the same place where you are when you see that
message.

What we are not doing is not "not checking out". What we are not
doing is to fast-forwarding the void to any of the branches the
remote has, because we do not know which branch the remote wants
us to start our history from by default.

So, "warning: not starting history of 'master' from any of the
remote's branches, as their HEAD does not point to a valid branch"
or something like that?
