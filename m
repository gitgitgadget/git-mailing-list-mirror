From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads
 is available
Date: Thu, 11 Mar 2010 21:56:44 -0800
Message-ID: <7v8w9yt74z.fsf@alter.siamese.dyndns.org>
References: <cover.1267889072.git.j6t@kdbg.org>
 <201003092100.36616.j6t@kdbg.org> <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
 <201003112053.07260.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 06:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npxrn-0002JY-AU
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 06:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab0CLF4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 00:56:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0CLF4x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 00:56:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EA32A13EC;
	Fri, 12 Mar 2010 00:56:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nz7UoPa0J8rO
	zVMhZC3MnyrVlDo=; b=DFO+Fyqll4HZ3UJQsU7kb3N6jWgzmrAcKdJhiNESBwZb
	t53rHBbWSWi5SY5Fjot4/cJUSAkmzamzch8V4c8a+5bld/WnuQAFiJKBs4lNKUUG
	j9H7etmF94SiNTQHBHgsYuO/sYzVs9/g1T/aRaYDQqH+/G/hQCPAKOFlTZOMhtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mC8ds6
	N74jFQv0FSaG1fxkfpoQgKGiPTrtnZsuIW3hcFVbioTN0si8zTitDKwQ/z+Pz45G
	wicN/WFZGR7HHvEqk0gFHdbQZlRmexirB8A9xZWJruAcl4UZwGEfdYZkDx00LSt5
	JdCzFh3NORcJlGvImrWYFsU/v/oyLeRvqSMPE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DDC4A13EB;
	Fri, 12 Mar 2010 00:56:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 857AEA13E7; Fri, 12 Mar
 2010 00:56:45 -0500 (EST)
In-Reply-To: <201003112053.07260.j6t@kdbg.org> (Johannes Sixt's message of
 "Thu\, 11 Mar 2010 20\:53\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D22315E-2D9C-11DF-AADC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142020>

Johannes Sixt <j6t@kdbg.org> writes:

> On Mittwoch, 10. M=C3=A4rz 2010, Junio C Hamano wrote:
>> Will queue in 'pu', but as Shawn said, we should probably give anoth=
er
>> closer look at the callees that are started with this interface befo=
re
>> moving forward.
>
> I'll audit the call paths. But I'll need some time for this.

Thanks for volunteering.
