From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git: make "git -C '' <cmd>" not to barf
Date: Fri, 06 Mar 2015 10:31:21 -0800
Message-ID: <xmqqpp8myo3q.fsf@gitster.dls.corp.google.com>
References: <1425625534-11869-1-git-send-email-karthik.188@gmail.com>
	<87d24mnmon.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 19:31:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTx21-0003gN-51
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 19:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbbCFSbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 13:31:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083AbbCFSbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 13:31:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70D523CC9C;
	Fri,  6 Mar 2015 13:31:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=deQfkgavj0tGjbgw7gVFYU5Zo6E=; b=kca4iD
	T+P8Gp8aThF7VLXyOMLSYbBVECGWUJqIEbaxy2XM5rHcyY6U4ARwXGW7hf6XtaOx
	MRNy36yBktPwVQYTIdYzPD2aPC24PLTQA6riOYvOesvuG4j7jMjSQHMCbe/Bw0UZ
	zN6fyNGAEKEFDMuF/pnK0Ogg+5hlqnrQuLu8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tEqzqeOGhRU5OpFlDYaUGTs/oK5/pqv9
	bxE/rvUm/u7KidiZ9xJZZoo8bpkMhtUHTw0wS8zzCK9pa1JdAHWdg7Avc3moE0WF
	ef7LDdLK+G1BonFW8SGdLmEBrkogU9ZnCJ36E6pPRTTFV0xE7Em9taolFDXZy5ot
	GwlDSiT8H6k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 684493CC9B;
	Fri,  6 Mar 2015 13:31:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1D6B3CC98;
	Fri,  6 Mar 2015 13:31:22 -0500 (EST)
In-Reply-To: <87d24mnmon.fsf@igel.home> (Andreas Schwab's message of "Fri, 06
	Mar 2015 16:57:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD84171A-C42E-11E4-A5F5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264949>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +			if (*((*argv)[1]) == 0)
>
> IMHO (*argv)[1][0] is easier to understand.

Thanks for saying that.  I had to scratch my head every time I had
to see this change from various people ;-)
