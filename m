From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Thu, 18 Aug 2011 13:22:49 -0700
Message-ID: <7v8vqqa2qu.fsf@alter.siamese.dyndns.org>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org>
 <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
 <20110818191812.GG30436@elie.gateway.2wire.net>
 <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:23:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu97E-0000lY-Oo
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 22:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab1HRUWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 16:22:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab1HRUWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 16:22:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 132DE4070;
	Thu, 18 Aug 2011 16:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDKXORB9fwef5fJF5i8ue7aOVOg=; b=bMp06e
	sarxiCLMedGgjbOztRnJewP/J5Sr6j1st9qFofLr46VzLLQGvpmArrgARaTySvx9
	t7Ew4flYzHnSL5bCNoDjcYcT7i1YpH1m906sH2kkEGIXveUIN2+TQLEuV2t6UhZ3
	y2JtwzQN6x5Gy4gkVy0dw9aWrL5JadCKD5kRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NvgpCSY7NE7yuOUHSdatqAZxBQTU49zK
	Axb//TwFeL92yLgl1qlzC0u8Vr2ea/OpHcu8tgyiIZ9Wt/1zsvshV/N3ZYjkTnrP
	F76vSQ05H+F/bLL0JL48KTEGA2XPPa0BM7puBlb3japbrwicwPX8NGHgbCnn0KGY
	U9hGKC7if8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05DC6406F;
	Thu, 18 Aug 2011 16:22:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B4E0406E; Thu, 18 Aug 2011
 16:22:50 -0400 (EDT)
In-Reply-To: <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 19 Aug 2011 01:20:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D842E3BE-C9D7-11E0-B447-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179625>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Why modify tests?  I think "git merge --continue" is a nice idea,
>> and I don't see how it's inconsistent in any way with continuing to
>> allow old practice.

I agree. Updating the test will hide a regression if Ram's update breaks
the existing workflow to conclude a conflicted merge with "git commit".
If we are to add "git merge --continue" sugarcoat to make it easier to
teach new people saying that "To any Git operation that stops and asks you
to help, you can tell it that you are done helping by re-running the same
command with --continue flag", then _new_ tests should be added to make
sure that "git merge --continue" does act just like "git commit" in such a
case.

> In the future, we might want a 'merge' instruction in the sequencer --

The end-user facing frontend may be "git rebase" in such a case, and we
would be teaching the users "When you are done helping the conflicted
'rebase', tell it that you are done by running 'rebase --continue'".  The
command verb 'merge' on the sequencer insn sheet does not have any direct
connection to 'git merge' command (e.g. 'pick' does not have to be and is
not implemented using 'git pick' command that does not exist). So I do not
think we would ever say "merge --continue" in this context to begin with.

>> As Junio hinted, it could make a lot of sense for "git cherry-pick
>> <single commit>" to not create sequencer state in the first place.
>> "git cherry-pick --continue" does not need it --- it is enough to
>> commit with the conflict resolved.  "git cherry-pick --abort" does not
>> need it, either --- it is enough to "git reset --merge HEAD".
>
> Okay, here's my problem with the idea: it'll essentially require the
> sequencer to differentiate between one-commit operations and
> many-commit operations.

I think you are looking at it in a wrong way. It is just about giving
backward compatibility to historical hacks. cherry-pick and revert may be
the only ones needed, and a new command Foo that implements its workflow
in terms of the sequencer can choose to (and should choose to unless there
is a compelling reason not to, because of the exact reason you stated
here) do a single-command insn sheet with "git Foo --continue" to conclude
if that one and only step needed help from the end user.
 
"git am" would fit in the picture the same way. The sequencer insn sheet
it would produce would consist of "patch <filename>" or something, and
after the last one of them fails, the user would fix things up in the
working tree, "git am --continue" will create a commit, and because there
is no more steps in the sequence, the sequencer state will be removed.
