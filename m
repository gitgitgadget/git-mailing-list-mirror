From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Sun, 07 Feb 2010 10:48:58 -0800
Message-ID: <7vsk9cdgpx.fsf@alter.siamese.dyndns.org>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 19:51:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeCEV-0006uq-FY
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 19:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788Ab0BGStM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 13:49:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab0BGStL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 13:49:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB7F988CD;
	Sun,  7 Feb 2010 13:49:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=FqhObA5Vmep1C5yTeuAaany4zdo=; b=tBSTff
	e/rF7eL5Xk1+rMNHBsxLVN29IMw9dZoL7AZywPN/OwBU/Ia1phVbE7cKFL1qAwmV
	f9gMekeuVDdxjso5MUEKbMlcWUcSeM213nWSAoqpjs5w8cxdXScH70L9V2wKi1dF
	3d1o++rCRDr8qC54YSZNbVAF/bHTQSrzfceCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i2eUPJAtSNk8RycaXtjn1Keci8gwKVQY
	JiTRtohz15JdiqtdBhipT5PXRIAm+YSYeMmzY7PtsJ97OxGFigUwSy5rdiLa2gkS
	gGkAH4cAwG4PxzU0RLcleFDX6+NB/7AvZ7zqYJgjW057w8WVN99k9svOHcUcF4Hd
	L27Ch+vMHQs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1FB988CC;
	Sun,  7 Feb 2010 13:49:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59AF8988C8; Sun,  7 Feb
 2010 13:49:00 -0500 (EST)
In-Reply-To: <20100207050255.GA17049@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 7 Feb 2010 00\:02\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 775B466A-1419-11DF-8A52-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139246>

Jeff King <peff@peff.net> writes:

> ... I think you would do better
> to simply store a tree sha1 inside the note blob, and callers who were
> interested in the tree contents could then dereference it and examine as
> they saw fit.  The only caveat is that you need some way of telling git
> that the referenced trees are reachable and not to be pruned.

Thanks for a good summary.  To paraphrase the idea, for the "pre-built
binaries" use case, I could update the dodoc.sh script (in 'todo'---that
is what autobuilds the html and man documentation and updates the
corresponding branches at k.org when I push things out to the master
branch) to add a note to the commit from 'master' the docs are generated
from, and the note would say which commits on html and man branches
correspond to that commit.  That way, the referenced "trees" are of course
protected because they are reachable from html/man refs.

Right?
