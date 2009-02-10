From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] receive-pack: receive.denyDeleteCurrent
Date: Tue, 10 Feb 2009 07:15:19 -0800
Message-ID: <7vfximpblk.fsf@gitster.siamese.dyndns.org>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <1234170565-6740-4-git-send-email-gitster@pobox.com>
 <20090209185310.GB27037@coredump.intra.peff.net>
 <20090209192210.GD27037@coredump.intra.peff.net>
 <7veiy7thnv.fsf@gitster.siamese.dyndns.org>
 <20090210120753.GB15491@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuM2-0003S6-5P
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbZBJPP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbZBJPP1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:15:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbZBJPP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:15:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 99AFD2AD66;
	Tue, 10 Feb 2009 10:15:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DF2132AD5E; Tue,
 10 Feb 2009 10:15:21 -0500 (EST)
In-Reply-To: <20090210120753.GB15491@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 10 Feb 2009 07:07:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A40EE52E-F785-11DD-97D2-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109254>

Jeff King <peff@peff.net> writes:

>> I think denyCurrentBranch means do not touch the currently checked out
>> branch, so 'refuse' there should trump whatever denyDeleteCurrent says as
>> long as the repository has a work tree.
>
> I'm not sure "trump" is the right behavior. How would I specify "it is
> OK to update this branch, but not to delete it, because I have installed
> a hook that deals with the former but not the latter".
>
> It seems like "delete" is a subset of "touch", so I think you probably
> want to refuse if _either_ is refuse. Which I think maybe is what you
> are saying here:

I meant "'refuse' in denyCurrentBranch trumps" and not "whatever is set to
denyCurrentBranch trumps".  IOW, I think we are in agreement.
