From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: git annotate -w like git blame -w
Date: Mon, 14 Nov 2011 12:49:13 -0800
Message-ID: <7vvcqmig52.fsf@alter.siamese.dyndns.org>
References: <4EBD1CF4.7040002@ipax.at> <m3sjlun4o9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Raoul Bhatia \[IPAX\]" <r.bhatia@ipax.at>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:49:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ3T1-0000tn-0U
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272Ab1KNUtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:49:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab1KNUtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:49:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F6467EF;
	Mon, 14 Nov 2011 15:49:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GKZaBup7yeaBTipte86mrsdhyTU=; b=rB7rEh
	nZK/U2MchQ/mWtTDskKm119kswf4k3yZ3m0gPSYa3raTSTLHarfUcGFDzPQDKXXF
	R1+VpwcO9ZMcJuhRwgvxsADuMAvmhykcDDv8eaRnqesWHioNB9ImuhVS4XcLlSuU
	Jx+HgR/jnk0GayXx93JPMEoN6efpgDFvVAMQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZErAVrayd+VBVKuhtlhW4wLujGaV//l
	NrKEPkMMLIs97TWZizABJYusN9g/3O1Yu8PZ2udgBErQjGWV/LCFHw2g+hfL1ik+
	sFBdtMP+TOVVjwpNhwLKP0COAuMQVe3RE5PQxrR7x2V+TKyR4obe+6xuGlTiK7NX
	Qt/BwcJ77pM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7AC67EE;
	Mon, 14 Nov 2011 15:49:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81A7067ED; Mon, 14 Nov 2011
 15:49:15 -0500 (EST)
In-Reply-To: <m3sjlun4o9.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 11 Nov 2011 05:57:03 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D667748-0F02-11E1-B58F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185402>

Jakub Narebski <jnareb@gmail.com> writes:

> "Raoul Bhatia [IPAX]" <r.bhatia@ipax.at> writes:
>
>> is it possible to add a "git annotate -w" option like git blame has?
>
> Why not use "git blame -c -w"?  `-c' turns on annotate-compatibile
> output.
>
> From git-annotate(1) manpage:
>
>    The only difference between this command and git-blame(1) is that they  use
>    slightly  different  output formats, and this command exists only for back-
>    ward compatibility to support existing scripts, and provide a more familiar
>    command name for people coming from other SCM systems.

Somebody may want to compare git-blame.txt and git-annotate.txt in
Documentation/, notice that they share blame-options.txt and that the
former has accumulated option descriptions for a few more options that
should have been placed in blame-options.txt, and then prepare a patch to
improve the documentation?  Hint, hint...

I *think* '-c', '-f', and '-n' are blame-only options but all others would
work with annotate (whoever is doing the patch needs to verify this,
though).
