From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Fri, 03 Jun 2011 09:28:23 -0700
Message-ID: <7v39jqc21k.fsf@alter.siamese.dyndns.org>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603054303.GA5341@sigill.intra.peff.net>
 <20110603145154.GB11273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:28:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSXEp-0003rq-84
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 18:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1FCQ2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 12:28:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab1FCQ2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 12:28:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23448586F;
	Fri,  3 Jun 2011 12:30:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y7MrRof6c1CX2BbYkFY0OjonmBQ=; b=bUHvT3
	0acFKN4pU6zI0DIocJkFvO9JoPbzbSsRa9Pv04wVEyf03oR5bjto3Gb9JwXqp3SR
	iu1JGZMJMJMgQ08Ks+E4tDV40+/zGyJeV+2e9PBMSOJibtgWXS9m+aOUDh0gvF87
	g5rZGwjQg7ELAzfzSkVYTWxCH7Dp8zOkMegBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X38zqjo6tIgF+Yijpm4J1P+yO5LaLg5H
	oRPGlFV/ZhhLQVmgwvST9zUrAyor9vJmpoAnx/qC2VNhsooX/CXrbf7Kk68hfLwO
	pMoXY8a5ESs2NhOscEON9S6bdiS2hM+RtzSUGdfsfsU8ti/ErB+sbYYDKfO7rSiB
	AUoPCYdgLp4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEFA8586E;
	Fri,  3 Jun 2011 12:30:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3ECDD586B; Fri,  3 Jun 2011
 12:30:33 -0400 (EDT)
In-Reply-To: <20110603145154.GB11273@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Jun 2011 10:51:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D17E1AC2-8DFE-11E0-8849-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175015>

Jeff King <peff@peff.net> writes:

> Actually, I forgot that I did consider this when writing the original
> patch. The clone code will only ask for HEAD if the remote side
> advertises it. So there is no capability required; either the helper
> advertises a HEAD ref or it doesn't. If it does, it should be prepared
> for us to ask for its sha1.

Sounds very sensible ;-).
