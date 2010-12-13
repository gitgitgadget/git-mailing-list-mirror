From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 13 Dec 2010 14:15:40 -0800
Message-ID: <7vlj3txqsz.fsf@alter.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
 <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
 <loom.20101213T194818-377@post.gmane.org>
 <7vbp4pz9hf.fsf@alter.siamese.dyndns.org>
 <20101213214628.GA13447@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 23:16:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSGgU-0003yS-CJ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 23:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121Ab0LMWPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 17:15:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab0LMWPs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 17:15:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3DB23440;
	Mon, 13 Dec 2010 17:16:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y3jw+LWKRb4QLlp5mGMI/CHLdoY=; b=diz3cQ
	DsCHYJlGflqiG8d8xacWv6XMorfn4OXJXPCxwZeTnQVno5PZttf6NF4yA6vreJs7
	DRobSQHpC6CchXL6KYYoJVqSeoTd1uD9qYZgb/Vrj9LSKG/DxwKF4wbAflby2vVD
	uPsOqc2Vp0Wl8F5UR5ZwlN6CJ2osY4j0Cebj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y45LiuctyhciAcQ7k29s1UYn5sTgL1Gn
	9LIhi6h2EW+pbB8v+8S6mCEDi7JVA5iOc8Ts45ZhZ0okp6Ldg2WMMphX1TEyNB2k
	kN6TZ52ZkP/sz33djjTEuX1Q11vEu06fFgnHWFR9XwhzoWe3bWwa48PYEKcmDbkv
	l3yKVyoHaSc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2A3C343F;
	Mon, 13 Dec 2010 17:16:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B16D5343E; Mon, 13 Dec 2010
 17:16:07 -0500 (EST)
In-Reply-To: <20101213214628.GA13447@onerussian.com> (Yaroslav Halchenko's
 message of "Mon\, 13 Dec 2010 16\:46\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9708E2A2-0706-11E0-BF2F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163600>

Yaroslav Halchenko <debian@onerussian.com> writes:

> On Mon, 13 Dec 2010, Junio C Hamano wrote:
>> would make sense only if used with --no-commit.
>
>> But for such a use case, "git read-tree -m -u 0.2" would work just as
>> well, and discussion ended there ;-)
>
> hm -- read-tree sounded like yet another unknown to me feature of GIT I
> was trying desperately to discover ;)  unfortunately it doesn't produce a merge
> for me

Didn't I already say it makes sense only with --no-commit?  IOW to shape
the tree.

And in your use case I do not think you would even want to have a merge.
Even if you run "git rm" to remove non-free stuff from the merge result,
if you merged the history of 0.2 that contains non-free stuff you are not
allowed to distribute (forbidden either by upstream or self-imposed dfsg,
the reason does not matter), people who gets the merge commit can follow
its second parent to grab the non-free stuff, no?
