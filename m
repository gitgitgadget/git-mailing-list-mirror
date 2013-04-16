From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 12:19:00 -0700
Message-ID: <7va9oyl1wb.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org>
 <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
 <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBPJ-0003TK-N7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935318Ab3DPTTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:19:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab3DPTTC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:19:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0E914A30;
	Tue, 16 Apr 2013 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sg6YBU429flMjJ9Wghc21eKjViM=; b=A6Fk67
	tRmGn/eNGpF5P96c6mNnphm5JuJF6aVYBoaKAHglndMoPjA9OokRuuiWFmAr5pdy
	/nX0v6Dk1xvs9t76zJviMTe3eS4Rmtg7bYIbBaKYXfFfFKJsULln/I6jjbaHJuWY
	4pJaItv5PLsztz4hosiLtaD9NfNP1DEJjwGCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o6QtdshzC0pw0Tsr6l1xtVqm9cuA/cn4
	X5ihOvh9r3ZBptuwDT0EcxNCfjGG3ss4IfD4ykGH31ACQwcm5/8asXXD92QLnv1R
	ZpiPyYVqUSC9Y7yVp7nYtT7+NMJgea1Sfp6m1B3qcD8vFYDGpW8IEQg5R/Moh/D/
	Vm8k/J3hd7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2610B14A2F;
	Tue, 16 Apr 2013 19:19:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A205614A2E; Tue, 16 Apr
 2013 19:19:01 +0000 (UTC)
In-Reply-To: <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 16 Apr 2013 14:04:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EDF6F1E-A6CA-11E2-A36C-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221455>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sure, and where is the thinking not clear? The remote helper ref is
> not updated, so we do update it. How is that not clear?

Sure, between "leaving it untouched, keeping the stale value" and
"updating it to match what was pushed", everybody would know you
mean the latter when you say "correctly update".  There is no third
option "updating it to match a random commit that is related to but
is not exactly the same as what was pushed" to be correct.

What I felt unclear was _why_ both of these two (remote and testgit)
have to get updated.  In other words, "correctly update it" because
"without doing so, these bad things X, Y and Z will happen".
