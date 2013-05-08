From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: fix for disappeared revisions
Date: Tue, 07 May 2013 22:16:00 -0700
Message-ID: <7v1u9ihx0v.fsf@alter.siamese.dyndns.org>
References: <1367969975-4163-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2j+f9vNu45vo0PSr6KEwhvaLUY+N1SU95PkQvKq6nB+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 07:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZwja-0002ud-RR
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 07:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3EHFQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 01:16:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab3EHFQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 01:16:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F1D314008;
	Wed,  8 May 2013 05:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HeCXitsfLBw2WmVYqvObvIUfWyU=; b=gsKuef
	ArlbP+c8mLRFyPP6X+tMG8JDsiOtnetn78xJFPYuYQEGTZr8V1o64DW6rlgPxgzh
	KMCJmRzrM/26tFvirqZqbwYTVcXOZK1D+1o+9zcrg3ZJLfO6rxNfDkC+rNztq3iS
	GLb3olvT/eY5GsCjbIBe6cmLjaG+QRSSS3wBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuVRKkM5vTOi3K2iunTaizV9Y6/gdpOq
	dKHAexJ7t4TM+lFZORs6rLKkLBb0kcDJ7vyAkWZgaVF67ncx9U5sMX8emTG+6pqC
	hpkM+tJqwa2fTEwj4OrsbdlArunU0dPWfZhujOYIPgi9ssPJctTCA2IUp90bM2XC
	APW62fsfRG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7584B14005;
	Wed,  8 May 2013 05:16:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E55FC14004;
	Wed,  8 May 2013 05:16:01 +0000 (UTC)
In-Reply-To: <CAMP44s2j+f9vNu45vo0PSr6KEwhvaLUY+N1SU95PkQvKq6nB+w@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 7 May 2013 18:42:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6018AC3C-B79E-11E2-B41E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223637>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 7, 2013 at 6:39 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> +  (cd gitrepo &&
>> +  git fetch &&
>> +  git log --format="%an %ad %s" --date=short origin/master > ../actual) &&
>> +
>> +  test_cmp actual expected
>
> Hmm:
>
> test_cmp expected actual

Yeah, right.
