From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] userdiff: fix typo in ruby and python word
 regexes
Date: Sat, 18 Dec 2010 13:02:50 -0800
Message-ID: <7vr5deg5fp.fsf@alter.siamese.dyndns.org>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <a358c476187b1220bf6e2368c0723cefe60a5763.1292688058.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 18 22:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU3wE-0002ol-Jr
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 22:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab0LRVDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 16:03:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0LRVDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 16:03:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CB8C2F4D;
	Sat, 18 Dec 2010 16:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5x57CDgs5ayrmfsurDrtQ4tOEwM=; b=AJgYi9
	0Y5M1q+uhhvJGlUMM37QEmFVsR6XqrQzdpTXDFhI8nngkfJg+/Pvi+Vmt0q3GrpX
	il4yk7YbuFv6VtWl7KsrRHt/c0jtdsvRnu25DTL6o4LgLBXCCcUDw1JBjhmctVrZ
	ZoOa9HOard43kMX5VTrb+HKUDPAEipY8qyL5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MGH2qamveDs5gcUgDm3XDBNbyBc9dsbj
	dzz51VyZO5omMUpoIA7VfUCoDmktbBRKIRKK16dHGtAMLhBvjUj5zebCs1E58MwM
	H4U5GQdtU0079RxKa3wEsZpZWPYiW3PAzo3v6NG1BORxW3chEV3yC4kEcAVbE/qs
	5z6luOQNPZ0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F3E02F3F;
	Sat, 18 Dec 2010 16:03:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 715602F3E; Sat, 18 Dec 2010
 16:03:19 -0500 (EST)
In-Reply-To: <a358c476187b1220bf6e2368c0723cefe60a5763.1292688058.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 18 Dec 2010 17\:17\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 424EB29A-0AEA-11E0-9198-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163935>

Thomas Rast <trast@student.ethz.ch> writes:

> Both had an unclosed ] that ruined the safeguard against not matching
> a non-space char.

Thanks.

Couldn't we have found this without your "sanity check" patch?  Are we
ignoring error returns from regcomp() in some codepath, or is it just that
we are catching them but our test suite lacks ruby and python test
vectors?
