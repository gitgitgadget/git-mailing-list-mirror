From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: don't always prompt for password
Date: Fri, 04 Nov 2011 23:45:24 -0700
Message-ID: <7vwrbf83uj.fsf@alter.siamese.dyndns.org>
References: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
 <1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
 <7vlirvdeb2.fsf@alter.siamese.dyndns.org>
 <CAJzBP5TdwZ4AhY6cosLOhcmxLfBA8hX7G9nBhiaLKYmMgPcyfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 07:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMa0Z-0000Um-Ut
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882Ab1KEGp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:45:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1KEGp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:45:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 684AD460D;
	Sat,  5 Nov 2011 02:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ORX8JiP+nNoWs8IA/xONXVGWQkw=; b=syysFQ
	RsrLX+C6QDXXOVtNVpNe6/9dSQeEB3zc2b8I8Gy42xohoTsoJeEQ9wECVVtlrOuZ
	zMWq9HVa+zPwC06PFDeQ2KHUp9cCpHxa1kW33z3IV9ylguyZl0gP9Z3Y0Q/KTsMA
	lVLrsFtfdMrIkayFZlC7JY3HFB495ExNsltdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pup834LZ6LT52n2hpnZHqiMxoEe4foIq
	bo7kJdAJzBcZ0H1AkcVQcCQvXKBu1N07H6s6R1t46EDSNNoEKOPU6bYk9NV11WfZ
	+MPa79UlpGrLHEezVxCIYYU7eZK0ti43WajCSMaQ1Bc32UdWJi3dlGJ8g7UXml5t
	I76LQccXlmQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EFF9460C;
	Sat,  5 Nov 2011 02:45:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE92D4609; Sat,  5 Nov 2011
 02:45:25 -0400 (EDT)
In-Reply-To: <CAJzBP5TdwZ4AhY6cosLOhcmxLfBA8hX7G9nBhiaLKYmMgPcyfQ@mail.gmail.com> (Stefan
 Naewe's message of "Fri, 4 Nov 2011 19:34:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDFFC3FC-0779-11E1-ABBE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184832>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> I just wanted to have that issue fixed, to get my scripted 'multi
> repository pull' working
> again.

For the latter, dropping username@ would also be a valid solution; saying
"want to have that issue fixed" is not helping the discussion very much.

Because the change is fairly straightforward, I am tempted to merge this
soon and see if anybody screams (in which case we would revert it by 1.7.8
final). The only people who may possibly scream are people who care about
latencies additional HTTP roundtrip incurs, which might not be a big deal.
We'll find it out and hopefully soon enough ;-)
