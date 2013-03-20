From: Junio C Hamano <gitster@pobox.com>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 10:31:34 -0700
Message-ID: <7v620mf05l.fsf@alter.siamese.dyndns.org>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
 <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
 <20130320170957.GA21350@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Rodland <andrew@cleverdomain.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMrs-0005jN-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab3CTRbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:31:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab3CTRbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13CE4A962;
	Wed, 20 Mar 2013 13:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XbG+pHfdfBhPig4Fnq/pBObPdwk=; b=D+ZYwT
	8rVQTrckY3g4PIJ+8JhJyiuRSdTk1em4xFKENczgGhiV2f44T9cYned6we4tkX/E
	ASAu7X6MMxIRD5uZUdLH3P35OsNJxyMu42tY5x/khrIF0x/9KLO7dBO1hzupmWCZ
	ccB6RL+9Vw+hHoyun0A+BrZ34Kzl6FFNTqars=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X8rdBMVWgLF7tShpslSye58iyjM06zKE
	NXfpEJQ9sgr6YcaPbpIc90eCJhSXBaJoR4SVAolHtYdH8NS70tsI/mMoh0DhtxTC
	DuGxdddKg8WeUnra6SAFugTquHBJIiYIYORAaUcbkHrGIYzr+Arw/IJA+OD93vdF
	nl7bQ6+BwDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07089A961;
	Wed, 20 Mar 2013 13:31:36 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80679A960; Wed, 20 Mar 2013
 13:31:35 -0400 (EDT)
In-Reply-To: <20130320170957.GA21350@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Mar 2013 13:09:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0385A62C-9184-11E2-BDAC-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218626>

Jeff King <peff@peff.net> writes:

> And the cost is that we have another Makefile knob people need to tweak
> that would not otherwise need to be there. Which can be annoying, but is
> also not that huge a cost to deal with (we might want to improve the
> configure script or something, though).
>
> I admit I don't care too much either way.

I don't, either ;-)
