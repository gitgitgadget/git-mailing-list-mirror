From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: respect --no-thin
Date: Tue, 13 Aug 2013 09:43:31 -0700
Message-ID: <7vob91y218.fsf@alter.siamese.dyndns.org>
References: <1376184258-6784-1-git-send-email-pclouds@gmail.com>
	<1376211178-17444-1-git-send-email-pclouds@gmail.com>
	<7vhaev1mao.fsf@alter.siamese.dyndns.org>
	<CACsJy8C-c1TXRiYBO7Mm0jGZvttqzRTONTkskuoU3_kZxHhuCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 18:43:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Hh7-0007TR-3n
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 18:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757556Ab3HMQnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 12:43:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774Ab3HMQng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 12:43:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A38F838FDC;
	Tue, 13 Aug 2013 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4yYM1VtBqpogMfeu1cwG4c1IOFo=; b=R1WT7E
	e7WAtmHoA+/LzoeyN9JpGj/IVVAYkoFAWym/4nemhU+LvzAuU7IywinUpy4cDjwL
	qxTlmP16ItXvbwXU8i/xevDbLjFLiyHhH9/CuSfX4PUc1Ce1bh+bp+wQAJ77lL9K
	JKIOh+z63xUIWpOeMzCfZmfcKpxhF1hNi3A9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AdV3Kb0mHADthdpQOLW5auqLkuxBX5wj
	2slIM3I8gcNlSrW7AdZlPjPwNKGcVPdq9NzHvqMO5NGAkA9DIKVrDIb974AbBvmV
	J+wpJolEnJ68Y+VKK+X1679hleLHZ3LvoMyGIbXY0l3MV3DcKy85NDC9KcAzcIP2
	a1yUSgovtaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D41C38FDB;
	Tue, 13 Aug 2013 16:43:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66A7438FD7;
	Tue, 13 Aug 2013 16:43:33 +0000 (UTC)
In-Reply-To: <CACsJy8C-c1TXRiYBO7Mm0jGZvttqzRTONTkskuoU3_kZxHhuCQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 12 Aug 2013 18:30:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DF75132-0437-11E3-9EBF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232233>

Duy Nguyen <pclouds@gmail.com> writes:

> transport_get() actually sets thin option to 1 by default.

Yeah, I missed your message in the nearby thread.  It indeed does.
