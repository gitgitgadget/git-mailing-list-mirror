From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: commit -p breaks with -m
Date: Thu, 15 Aug 2013 10:28:16 -0700
Message-ID: <7v1u5usw27.fsf@alter.siamese.dyndns.org>
References: <6EC98F2F-98FC-439B-BD9C-B1D0DB1F5E10@gmail.com>
	<20130815121635.GB22102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matan Nassau <matan.nassau@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 15 19:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA1Lq-00043B-5Q
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 19:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997Ab3HOR2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 13:28:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467Ab3HOR2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 13:28:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2935F39CFA;
	Thu, 15 Aug 2013 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iK9PrKddAR2HbW6xW8XAcpbolU4=; b=WrlSSK
	ecn4FAg2/XqVqSGEpNFrBfN8x1O22iPmH0bIQT2wbNP1wYHotl+1GcOg2t19YLj7
	zd2mWGZTmmXwsn78VeAZvuBUgtv+gronWNBxjmPA/pzJBZA1STz9yuAOmLX2YAGz
	RCIx9q5k122DjCGyEQgMmO+1bFY6VRQaX1icw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cVVW2QGu67qST6Cv90jGt/WUjQniPAeU
	qYsctXk8yE7qrAuAbdPB9HagzbAv65VAFHiSnpncvZIUpIa/rHE5XymUXvEyA2jB
	dzsrLXLiguzbqmBN0qm9peRnRiMdTKuuGEyy5nZqut1hwUSLuB6OmmhnbdONEgsl
	i0qo8NlzL8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 009A739CF8;
	Thu, 15 Aug 2013 17:28:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84B1E39CF1;
	Thu, 15 Aug 2013 17:28:18 +0000 (UTC)
In-Reply-To: <20130815121635.GB22102@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 15 Aug 2013 08:16:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1352BA20-05D0-11E3-9F61-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232353>

Jeff King <peff@peff.net> writes:

> Unfortunately, I think that will require some refactoring of the
> run_hook interface, which does not allow arbitrary environment
> parameters to be set.

Heh, I said that long time ago, e.g. $gmane/212284 ;-)

This might turn out to be a good starting point, even though I
didn't read it again before sending this message.

    http://thread.gmane.org/gmane.comp.version-control.git/192669/focus=192806
