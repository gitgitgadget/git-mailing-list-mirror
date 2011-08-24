From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_indexed_object can return NULL if nothing is in that
 slot; check for it
Date: Wed, 24 Aug 2011 10:54:51 -0700
Message-ID: <7vmxeypudw.fsf@alter.siamese.dyndns.org>
References: <20110824054717.GA16512@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Harring <ferringb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 19:55:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwHfS-0005W1-5T
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 19:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab1HXRy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 13:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab1HXRyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 13:54:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA0814261;
	Wed, 24 Aug 2011 13:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=81rIQ1N6M+TgyB7ntrc3PeMembc=; b=QCkASo
	+6jejteeHjSeCzwalPjk1CjOqBzQ9gRuyga4Wt/b4PKjXm4EirJ2v5gf8K0Etwqz
	mN7RQvl7EDoIe55o2sH/SWHJC0+X+DRQ2w5+NPtHK0l6md+OMcrOPSE7kTBNzhrT
	o3Hf2pD92hCUDo4WKjNvlPipnxLSoNB9GdydQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mE2wEjcfTGRXKK9okqkUuEcHPjjFKfd0
	SoLO/M8TxO3qXkoYnM7G0GrXmH5fCKk67nkrhdMHj//fmxOGrjbKR7woNCL3fztW
	EYl7/TWadiVCYyPBMZr/MOLDO0eQ//tE9r0BT28IoRzSqkD7HqOvsU89cNrk8YaR
	DfiXWD1X1Bw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B01594260;
	Wed, 24 Aug 2011 13:54:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43DC4425D; Wed, 24 Aug 2011
 13:54:53 -0400 (EDT)
In-Reply-To: <20110824054717.GA16512@localhost> (Brian Harring's message of
 "Tue, 23 Aug 2011 22:47:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B89C1CC-CE7A-11E0-8ED6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180020>

Thanks for a fix.

It is both interesting and disturbing to see that these small mistakes are
discovered a week after the topics hit 'master', even though it has been
cooking in 'next' for a week before that happened (in the case of this
topic, it also hit 'maint' yesterday).
