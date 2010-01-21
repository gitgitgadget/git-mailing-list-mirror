From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #06; Wed, 20)
Date: Thu, 21 Jan 2010 09:52:48 -0800
Message-ID: <7vzl47s5u7.fsf@alter.siamese.dyndns.org>
References: <7vljfsxos5.fsf@alter.siamese.dyndns.org>
 <201001210240.10522.johan@herland.net>
 <7vvdeww187.fsf@alter.siamese.dyndns.org>
 <201001211018.10085.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:53:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY1DP-0006xT-5f
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0AURxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951Ab0AURw7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:52:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0AURw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:52:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 337BD93EBD;
	Thu, 21 Jan 2010 12:52:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZWHF89m5KrvNfVyw2CNa0UxW0Do=; b=CPYb1Y
	GJ45Z1XLsjjiFk9t6jzYrlSnrBwAaEp8/Ekz3Tp0Uvsonslm91IbGifOHxAFnGAp
	f2TGIV23WLGEZKf0FtGdBs0Sh4S6X2IojMjveOj2D8SORZmQOyfKd8rgcHmzaN9c
	HjC9QXGwzYIG3DshnWc5UoDSzoVOBc5g5u2dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OFQ6BOh2VFBLZ6Xgra2d7QJyFNgu05jH
	YbzYziR1AQ5M5u0MOpBBdMGVPknDhYtKMOkryw0DpCj+f2vjxGY9zSrJ+WBPuUjo
	jrKXcg+M7DkdlERuTIiqdnWzNQqPNS2Mc80Z8znT18HZs5j/iwcSEZjZVmTDmtkv
	FbpGqDkt9GE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECDF993EBC;
	Thu, 21 Jan 2010 12:52:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 355C493EB9; Thu, 21 Jan
 2010 12:52:50 -0500 (EST)
In-Reply-To: <201001211018.10085.johan@herland.net> (Johan Herland's message
 of "Thu\, 21 Jan 2010 10\:18\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCCF189A-06B5-11DF-AFBA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137678>

Johan Herland <johan@herland.net> writes:

> In any case, I totally understand if you'd rather want to hold the entire 
> notes series in 'pu', and instead focus on fixing the bugs in what's already 
> been released.

That is a different issue than what to do with the first three that people
have been using from 'next'.  As I want to close the -rc0 by the end of
this week, I've merged these early ones to 'master'.

Tentatively I had to drop the remainder of 'jh/notes' from 'pu', but that
is not because I didn't like what was in the series.  From the discussion
of last night, a patch to squelch "Notes: " output in "format-patch" was
queued and it is meant for 1.6.6.X series, but the precondition a new test
in that fix relies on in t3301 (i.e. fourth commit having a certain notes)
is changed in jh/notes series and merging it makes the tests break. I
haven't gotten around looking into its details, but the fix patch needs to
be in 'master' soon, and the first patches from 'jh/notes' are already in
'master', so probably we would want to rebase the remainder on top of
updated 'master' when 1.7.0-rc0 is tagged.
