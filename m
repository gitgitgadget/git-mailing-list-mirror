From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Fri, 21 Aug 2009 13:10:10 -0700
Message-ID: <7vfxbldj31.fsf@alter.siamese.dyndns.org>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org>
 <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
 <200908212006.16333.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeaRf-00050L-7e
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbZHUUKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbZHUUKT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:10:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbZHUUKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:10:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD3713376;
	Fri, 21 Aug 2009 16:10:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0/9q0APKs4FMoYbhA4OKI5iRjz0=; b=Pg81DQ
	5M8vmej+3YGSjZxppl268f3EA7e2WYvUw76sBDs3qHF4mwhcBGtXiuJ+ScG/Nfn9
	fzNb0gI05DJXKK6DgKXzktNaJUcM1zo/+PMmTJ2nY+3AlY3/ZIF0vsTVofuBD/XI
	k8zI+vuxzUnVtzp81SX76GHMcRF09s4I5C5iA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cv+g/Q+WNP8R2OUkVGHU/yPDIk3IXRuT
	3hKfJ1fhZThPBwVHBWKIr5tdQVNmqX1JZ2kP8zXtuxakyCAItFIvsNpi937RWIUt
	C1wW3j3ITxNBViRMHWHDTSLz8xZ4r10F2U3sxXjDPW/UuBqAyqG/UAqfcRUAIXhW
	XeK/Sqxtxd4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 354DB13375;
	Fri, 21 Aug 2009 16:10:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78C0F13370; Fri, 21 Aug
 2009 16:10:12 -0400 (EDT)
In-Reply-To: <200908212006.16333.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 21 Aug 2009 20\:06\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A45DB866-8E8E-11DE-85DB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126746>

Jakub Narebski <jnareb@gmail.com> writes:

>> +cat >>gitweb_config.perl <<EOF
>> +
>> +\$feature{'snapshot'}{'override'} = 0;
>> +EOF
>
> A trick: use '\EOF' and you don't need to escape $ against variable
> expansion by shell.
>
>   +cat >>gitweb_config.perl <<\EOF
>   +
>   +$feature{'snapshot'}{'override'} = 0;
>   +EOF

It is not a "trick" but is a basic courtesy for reviewers.  Even if you do
not have any $ to worry about, _unless_ you actively know you would want
variable substitution to happen, it is easier for readers if you signal
the fact that the here-doc is verbatim by quoting the \EOF marker upfront.

Same thing for use of single quotes vs double quotes when writing strings,
even though they tend to be small and much less of an issue.
