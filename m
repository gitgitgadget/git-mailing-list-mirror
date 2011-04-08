From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 08 Apr 2011 15:37:14 -0700
Message-ID: <7vei5c1iat.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KIy-0000yo-Bv
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654Ab1DHWhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 18:37:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335Ab1DHWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:37:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F4CB5E8B;
	Fri,  8 Apr 2011 18:39:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FtQHIBWIeKTF7cRDPu58lUcheck=; b=fQ/Hie
	Hbtpd8oNhPPQ+Y0K5gniAVnC5kttWOIUehGd5TVt0fxHEultrADYpj3aN1+nbojK
	VVGtVCLdmQ9SaAp8cL/rAsR5aoTMJeW5p/wWIL5wQnNk5Ww92JrQsuHOHXaYrFBH
	rSL34ypgjMPQzSV4TrKd7WfpGTEtVdpteOGEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LepTbn1p4cVMxYnXIFVOMc5EIzXKzAZQ
	uFg9x1TxZdvkZ2XwFivFKJM1b8YO0KZxlBcXILm5GA6fGF/i0uh+SGIAar9UnfS6
	uZ7GEf6VuAOtwGSz2YkVOPAUVdOX+mIylwws5xWMio39MJfTF2rJFtwmMmRSnmOb
	m1VUcHJNEVY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1BE45E8A;
	Fri,  8 Apr 2011 18:39:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1756E5E89; Fri,  8 Apr 2011
 18:39:10 -0400 (EDT)
In-Reply-To: <20110408223206.GA7343@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Apr 2011 18:32:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 076ADA0C-6231-11E0-BF2D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171170>

Jeff King <peff@peff.net> writes:

> I am not sure of that. I thought there was interest in full-tree grep
> (OK, _I_ had some interst in it).  But the same transition pain
> arguments apply there, and we should be able to do "git grep pattern :/"
> soon, right?

I never tested it myself, but the earlier "support :/ at a wrong level
get_pathspec()" patch should take care of "git grep" as well.  It is
equivalent to the "alternative approach" Michael posted as RFC as a
follow-up to his earlier "grep --full-tree" thread.
