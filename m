From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 16:50:46 -0700
Message-ID: <7vehyjcckp.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 01:50:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDm61-00076d-IU
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab1JKXut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 19:50:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab1JKXus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 19:50:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B72574A;
	Tue, 11 Oct 2011 19:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k0wrN2iG+p3y8D3iMzr7hvnzM1g=; b=UC9spu
	1i78kzKJoMC3zoUBodZgvwkj51+LpvJZUUMMCHAmp+SHiiLGkLStwmNt4/7S2K2C
	49wuqsFS07meA77CXNllUUO/6Xi20lbJhD4YYDjtBZQxQQSBdii0jxbpgfPn9vtl
	oHs90CiE6E88IKjr4tH3dUjWyOjgq2Tj9oKGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WfBwiP3ZojsuExZTo5k3JvC+je1l+o9e
	b01Og5Drpgp0imXZV3ap1WIetbd2WNpq8xIP7Dyn8UzZXdmcio1+8lcqayN4tSJO
	ipzHDSQCZ5QJq87yDpm+mnlDEa/kNMHZIrAAzZUvIcN37QkgckalaJq1D5ApzQtP
	pboaPjQdH+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605855748;
	Tue, 11 Oct 2011 19:50:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EACA15747; Tue, 11 Oct 2011
 19:50:47 -0400 (EDT)
In-Reply-To: <20111011230749.GA29785@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 11 Oct 2011 19:07:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7C00212-F463-11E0-8C3B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183349>

Jeff King <peff@peff.net> writes:

> It looks like we also use it in remote.c:count_refspec_match, but I
> haven't figured out if that can trigger a warning or not.

It starts sounding like that the ill-thought-out warning should be ripped
out regardless of what other things we do.
