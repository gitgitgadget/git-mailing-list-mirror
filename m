From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Tue, 06 Oct 2009 04:36:43 -0700
Message-ID: <7vocok21pw.fsf@alter.siamese.dyndns.org>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de>
 <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de> <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de> <4ACB22E9.3010001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 13:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv8OX-0000SQ-JC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 13:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028AbZJFLhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 07:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbZJFLhf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 07:37:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbZJFLhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 07:37:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 602BB4EE43;
	Tue,  6 Oct 2009 07:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=T6V5VEfsF28mJOGAWyyDlllZ1GI=; b=ZYRsEDy3gFyUDVw17bF7c3I
	br0Gt2b0nWQrzG5XfTDEi8eEFr/M97XjeTObWt/QsNZinPYLgPh1bhh61YZeK2Eb
	CVo6eI3yZQHwklVxbNfeHcH8Qe8O7RlsLiD94WELZkG8f9tXq/olx5hWNE0s+of3
	P8B7UEw1BxhoztqtqpLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DjV4pqYdava7mo9q0SFr68agHbxSRlNVQrZDCsPcGpDYCYx6E
	YqnXnLxuPJH1xS0PDiwYINRfyVHh6/DhyxCAu0uVR/UB9pc6OApaey4F30kt4ZiZ
	KZv3s0XCCQMT7MM2+L16hEb6c2N4WmCeACol1f7C0l4nHb473hBY1rtOL0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34DB74EE42;
	Tue,  6 Oct 2009 07:36:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92D1C4EE41; Tue,  6 Oct
 2009 07:36:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 885FFCEE-B26C-11DE-AF9F-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129622>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> But I really, really, really want to avoid a fork() in the common case.  I 
>> do have some users on Windows, and I do have a few submodules in that 
>> project.  Having too many fork() calls there would just give Git a bad 
>> reputation.  And it has enough of that, it does not need more.
>
> Me too thinks performance matters here. We do have a repo at my dayjob
> with more than a handful of submodules and its main target platform is
> windows ... so having that perform nicely is a win for us.

Numbers?

I'd prefer to avoid kludges that favors unsubstantiated performance
argument over correctness.

Thanks.
