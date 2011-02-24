From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Wed, 23 Feb 2011 17:16:14 -0800
Message-ID: <7vd3mi44gx.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 02:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPol-0004Jc-5u
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 02:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab1BXBQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 20:16:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab1BXBQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 20:16:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 608714F22;
	Wed, 23 Feb 2011 20:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vJNp3YHNFdpT
	O9wRW6INkSC4dZs=; b=TsBBluI7efNLg0legw1OR1RNL5ieW0wccqT2syXRrrGJ
	56XAQ28lNq47AwKkLX6U/QNYDVQixXChhDQh7WcqGSfJxKGqCPD6h83RA6FxpZgE
	/vHNwBPgoGq7JNXKift+43QIfgvyS6mUsrDWx/snePGOdw3KH2drEMNBBNh/XcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lA3IBa
	t4YV07w7VoOgFPfx5ElueGJVq4jVEr6ueAjKPB6uUmzXEFmFVkY5ju9NOuWvQ1vw
	du73nGvyIsKK0aQgBec0nPT84y722tEUYng720LdsPxoWYXiWHtViaTEW75EXWJV
	yUm39yDNHyN/J/y2KJto2gZ90201uPBC+GXM8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DB8D4F1F;
	Wed, 23 Feb 2011 20:17:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 070EE4F1A; Wed, 23 Feb 2011
 20:17:30 -0500 (EST)
In-Reply-To: <20110223234828.GA7286@elie> (Jonathan Nieder's message of
 "Wed\, 23 Feb 2011 17\:48\:28 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC752842-3FB3-11E0-9D1A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167762>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The commit message for the second one seems to have been mangled:
>
> 	i18n: add GETTEXT_POISON to simulate translated messages unfriendly =
translator

Yeah, I think I was fooled by the header folding while fixing things up
inside the mailbox.

> I still don't like the #-sign business in this commit.  Couldn't it
> be split into a separate patch, not to be applied until just before
> the strings in commit/tag/wt-status are marked for translation?

That might be a sensible thing to do.   =C3=86var what do you think?

> There is also a patch out there to make this use rot13, which I am
> somewhat fond of.  Unfortunately, it leaks (because it is not clear
> how long translated strings are supposed to last).

Yeah I would imagine it would leak.  Also blindly running rot13 to turn=
 %d
into %q is probably not what you want.

> I'd be happy with renaming use_poison() to gettext_poison() or
> similar.  I suppose that is not urgent.

I would prefer to be able to merge the first handful to 'master' sooner
rather than later to minimize the damage to in-flight topics, though.

Thanks.
