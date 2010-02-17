From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add 'git format-patch --to=' option and 'format.to'
 configuration variable.
Date: Tue, 16 Feb 2010 19:47:32 -0800
Message-ID: <7vhbpgfrqj.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171238310.2477@vqena.qenxr.bet.am>
 <7vhbpgpsto.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002171516520.3414@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 04:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhatA-00008Q-94
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 04:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933992Ab0BQDrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 22:47:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933973Ab0BQDrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 22:47:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 960FF9A190;
	Tue, 16 Feb 2010 22:47:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RulDk4uHyHRBBiPEq7zSRatG0Tg=; b=jW2U3Z
	/eiciwS8Mi95kfSTHYvIpqQTOcKTuYeiBlhwfNPPJAwZCrpVn9KZn5J/6+zuPZZw
	iYQq3SefW1ua9kBSSFn6mUSCpt3Fu+3Wo+uR7sTtjUr8/1wjtz8ptACTcwIXRph/
	IzeA19+8iL5CZsxgM59IVyEIUb0Hyu2oiFzzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cX5kCrfBXh8uYt3IMpp0p+WhyNkThJC+
	jIg4aYSu3mORCq2goROU79Rnum+/gGNUWfLHEd/dUPcNmoH7X9KdFi1asznr1x3r
	Sh7PhGDeC9aV1zobGcRK03dL2MGmt+RRT2x7Vb6bvlX2C9nwaofJlX+koRKx2Y4R
	4Brz8NO6kZY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74F099A188;
	Tue, 16 Feb 2010 22:47:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 430AB9A185; Tue, 16 Feb
 2010 22:47:34 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1002171516520.3414@vqena.qenxr.bet.am> (Steven
 Drake's message of "Wed\, 17 Feb 2010 16\:11\:30 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3094950A-1B77-11DF-90FA-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140203>

Steven Drake <sdrake@xnet.co.nz> writes:

> I think it's weired to have an option & config variable for Cc and not To.

This line in your message I agree with 100%, and I already said I do _not_
mind adding format.to or --to.  But a sad thing is, this one line is the
only one I agree with in your message.

All the other lines including what your quoted in your message do not
answer my question at all.  Neither description by Daniel nor by Miklos
explains how giving format.cc or --cc given to format-patch helps the user
in the bigger picture.  Is a user of this feature expected to always use
send-email?  If so, how is that different from giving these options to
send-email instead?

> Any MUA that does not cooperate with reading the To header is going to
> give trouble with any header (e.g. Subject, Date).

Yes, --cc/--to/format.cc/format.are not about helping users of these
uncooperating MUAs, and that is perfectly fine.  "It is bad that the
feature does not to help them" is not what I am saying.  I am only trying
to find what these features are designed to help.  If the set of MUAs that
are helped by this feature is larger than "git send-email" by an iota, I'd
be happy.

>> or (2) is a git-send-email which is customizable already per repository so
>> you do not have to do anything funky when running format-patch.
> Haven't got around to using git-send-email yet!

Then how would having To: and Cc: help in the format-patch output help you
at all?  I tried to ask you (apparently in a garbled grammar, sorry) what
your workflow of sending the format-patch output to the outside world is.

The reason why I am asking is _not_ because I want to reject this patch.
I want to be able to explain to other people why it is beneficial to be
able to specify to/cc setting to format-patch, and using it in what way
in a larger picture it would help the user.

I.e. saying "by setting format.to, your output will have these To: header"
is not good enough, if we do not make it clear why having the "To/Cc" in
the output helps users and in what way.

I want to hear "because the output from format-patch has these To: header,
your life gets easier *this way*, if the MUA you use to send out patches
is ________.  You can use command ______ of the MUA to read the whole
thing including the headers, and you do not have to type nor remember the
addresses; this is something you cannot do without using this feature if
your favorite MUA is _______."

If that MUA is "git send-email", then I would explain to my users "don't
worry about these format-patch 'features'; if you are a user of "git
send-email", then give them to that command instead."  Feature duplication
isn't a bad thing per-se, but I want to know about it.
