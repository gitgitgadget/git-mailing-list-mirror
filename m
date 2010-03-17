From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cc/cherry-pick-ff (Re: What's cooking in git.git (Mar 2010, #04;
 Tue, 16))
Date: Wed, 17 Mar 2010 10:01:53 -0700
Message-ID: <7vwrxaubjy.fsf@alter.siamese.dyndns.org>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org>
 <20100317095218.GA6961@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 18:02:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwdM-000138-Ac
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 18:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0CQRCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 13:02:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab0CQRCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 13:02:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB744A25F4;
	Wed, 17 Mar 2010 13:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=G6vpB05r7qexN3NlxE9tgOJvM
	s8=; b=mo6zUIgV0FePTUqP8yNPFBxGmIF8ONJIEqeCYWcmTruWY1LepvvfMqeQ6
	CxWk73X6lMbxnx8S/QQWKY3kAOgxrW5RFgVEFljFpQ/pe4pHgPbcxO749gztQCOh
	Eq9nkPY1EOhDnoGi3Ana85NUxNRbGZwjw/40j4igqUp3S9Ywt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=FOBIerZcob/WWe3bC/J
	9m03h4Pi1hUEg20YucXb4vDSx4UnFGzaiBIUQt3fKYshCadgyi1aJeuqyeXVtWGP
	1w0pPpfX+8vQIAzhrPPE37wGQIY8oZOW4oFAfnT0uEXgohZiMLLdNh8E/HvmIkK1
	2P0pH50bSA50f6n5CHgNmZQY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59384A25ED;
	Wed, 17 Mar 2010 13:02:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8298AA25E5; Wed, 17 Mar
 2010 13:01:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD70B93C-31E6-11DF-81D1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142417>

Jonathan Nieder <jrnieder@gmail.com> writes:

> For what it=E2=80=99s worth, I am not convinced about the --no-ff opt=
ion.  I do
> not think --ff ever will be the default: for an operation that amount=
s
> to applying a patch and making a new commit, it just feels wrong.

Same here ;-) and because of that, --no-ff as an undocumented feature
feels doubly wrong to me.  If some scripts use it, people would wonder
what that no-op option is doing there.  Perhaps we should discard the b=
its
about --no-ff to make it more clear that --ff is an oddball case that i=
s
meant only for supporting what "rebase-i" (and other tools that reinven=
t
and enhance it) does.

=46or the same reasoning, you may have liked the "do not fast-forward t=
he
early part of 'rebase -i' even if the commits are picked literally" pat=
ch,
by Marc.
