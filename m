From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 23:45:26 -0700
Message-ID: <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
 <7v7hur1a0h.fsf@alter.siamese.dyndns.org> <vpqy6n6shri.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08Ta-0005bX-6k
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZJTGpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbZJTGpe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:45:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbZJTGpe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:45:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 786ED5FA63;
	Tue, 20 Oct 2009 02:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sqO5QtA445glZ5Pl0Brm7figSYg=; b=qgeE6j
	u5zvuRY4rbYyFVg5NXKuB6MNo5hx+qUIo9Ety6NWYr4pE/sZEAzq34Ipb7ZPaAFK
	irwkDYw2N9smhIRjfsejtaWPxqB+LS6yvxWJX616p5OErVZBv/ThnssoEHONJmf9
	pdopmjuNRzGrlypgbkd5tFaTqz3SHBqtnKPPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ToS5QdtOqnflFAWUVfCWU1wX+SusnWuD
	FWvGumGNnSBvOQeUqfDOO3IC6xS1CZYlHjTOs+bMvvSiStKGBbO9hrh1gHW+6V8j
	RHSmqdtLhQf84ZYKOCgXPk93YQJ4k/3C6XbgeZ52RmnCyzYxPRotkabbHOlOQcH2
	zpSBvne7a6A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F60A5FA5D;
	Tue, 20 Oct 2009 02:45:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 480615FA5A; Tue, 20 Oct
 2009 02:45:27 -0400 (EDT)
In-Reply-To: <vpqy6n6shri.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue\, 20 Oct 2009 08\:26\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A3ADEF8-BD44-11DE-9970-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130766>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Linus and other git developers from the early days [...]
>
> Thanks for the historical background.
>
>> It probably makes sense to ship 1.7.0 with a version of "fsck" in which
>> "--full" is the default; it would still accept "--full" but it would be a
>> no-op.
>
> +1
>
>> It probably is also a good idea to add a "--loose" option that does what
>> "fsck" currently does without "--full".  It is a good name
>
> +1 too.

Actually, I changed my mind.  I do not think this so big that we need to
wait for a major version bump.  Why not shoot for 1.6.6?
