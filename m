From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Thu, 20 Aug 2009 15:25:16 -0700
Message-ID: <7vab1up1gz.fsf@alter.siamese.dyndns.org>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeG4d-0000NA-Kb
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 00:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZHTWZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 18:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbZHTWZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 18:25:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbZHTWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 18:25:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3A7C31001;
	Thu, 20 Aug 2009 18:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXttZC5+GtyNp/6i4iT5xwEgQrg=; b=W196AG
	ZBv8T6PGQfBiu2gmSd36TA08V6k+kw7GhGNflOQPgUyyT1QC2O6re6A33AEu7mpE
	s/nCT4s/8noVGPFd2m7CDl6VknIJSNr7GvoRaMTsrLY2QT5h2un4k3SR4khEm9qH
	KPkv/KD6Ih2RNxfXY8xGEO4Po43uU2MTE5q5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tx/347qBop6cCagYW3UJAOQ3dViORCRY
	5P1RB28gtlZp3bZUl4nNWyh/nIEzapT6trTy6wtnc7wbDhhCDbO95MbOqL126zEi
	tqOa7vfxfprgoM02YGlGpUPovXpceZXKa7Zx+5VAx//fix/njztOJhKMBUKWWSG2
	K1LGwXdGCME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6055B31FF6;
	Thu, 20 Aug 2009 18:25:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B9B3231FF4; Thu, 20 Aug 2009
 18:25:17 -0400 (EDT)
In-Reply-To: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 21 Aug 2009 00\:10\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A2E633C-8DD8-11DE-BE20-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126652>

Thomas Rast <trast@student.ethz.ch> writes:

> Ideally, we'd like 'git diff C^!' to show the same diff that 'git show C'
> does (with log.showroot enabled).  This gives easy access to a readable
> diff for the commit, irrespective of how many parents it has and without
> any trickery to remove the commit message from the git-show output.

Not interested yet, as the "git show" discussion is not convincing at all.

Is the message annoying enough to warrant this change?

If that is indeed the case and if it is a common thing to ask, isn't it
more productive to teach "show" a way to do so in a simpler way than
doing, say,

	$ git show --pretty=format: HEAD
