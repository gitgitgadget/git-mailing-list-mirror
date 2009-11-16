From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Manipulating existing revisions by push or pull?
Date: Mon, 16 Nov 2009 13:53:19 -0800
Message-ID: <7vd43innlc.fsf@alter.siamese.dyndns.org>
References: <hdshcm$c06$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA9Vq-0005Z2-EN
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 22:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbZKPVxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 16:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZKPVxV
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 16:53:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbZKPVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 16:53:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D659780776;
	Mon, 16 Nov 2009 16:53:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AUvMaDITID1zgBPkQ4/GESmASCY=; b=fMDzV2
	RhY9i+q4wVTMsaeVetJaMD7zN12mSpVUbpKnBSMyh677THJmfoFLvwuobIroebkO
	RNBvFkHQU/1aeAiOpgPwfWc6ao7IhrUL8cS8dzfB+XsqIEkGblz7cBU+Uu/Lbrqx
	zQ5fuieG6JheMqSrlGdGe2qi30k0rLYQSWDWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qbX0FiULvfx9iM7tCEnghGKgBzxWpdia
	2klYZQMtPsmYLkqvrNpproUH38jxk2zTtcvs2XYbmgXYWW/ykBMrtCnKumAF8ys/
	AMvH8lfmOiUJ6cFTJEegT/Mp0Zw0uYRb3Sis2humtXcKkT52p4VpfMHWytbhXbax
	H0c3aV1QIPk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B569580774;
	Mon, 16 Nov 2009 16:53:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BE3580773; Mon, 16 Nov
 2009 16:53:20 -0500 (EST)
In-Reply-To: <hdshcm$c06$1@ger.gmane.org> (Lasse Kliemann's message of "Mon\,
 16 Nov 2009 21\:49\:10 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 765BC51A-D2FA-11DE-8705-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133028>

"Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net> writes:

> Put a different way: consider there is a hostile entity from 
> which I pull or which I allow to push to me. Can this entity 
> fiddle with my history? Can it change the data in existing 
> revisions in my repository? Or can it only make new revisions 
> grow on my side?

If you allow your ref to get updated to an arbitrary value, you are lost,
unless you have signed tags that anchor things in place, in which case you
can trust the part of history that is reachable from them.
