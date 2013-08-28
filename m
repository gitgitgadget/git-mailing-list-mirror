From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] mailmap: handle mailmap blobs without trailing newlines
Date: Wed, 28 Aug 2013 12:39:00 -0700
Message-ID: <xmqq61upa9m3.fsf@gitster.dls.corp.google.com>
References: <20130828014138.GA30623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 28 21:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElaD-0003QB-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab3H1TjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:39:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092Ab3H1TjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:39:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F3863CBB2;
	Wed, 28 Aug 2013 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCzKAFmpdWyYh7zNaZPMgDR8CUs=; b=k1eCwT
	QIkNIfEmQFsoz+AcHivA9I1UfFAJWVqPM1qsEyQI5pUEBdzWqxCD8TI8Utj41kWf
	uRpnGQbRfqgk3ReFh7Tc8DY5fHply5H51IOPvuK/WvvYo0988Ce+5Ubwac4ZWABt
	SbAt7/5UKMZFg4kL1Qx3+kK7+ky4wg+g4n0wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpxme1X2GOWkSfEm98k5QZsiiwmXSA93
	Gtyc61K1d3ozfjUBw3DIfVREq2f9EzWII+rGdLvpWQKsKQnRQQnwaBsfuJdASPPp
	VzYjAacMlmMgMuAAXF64lwqnyKEep8fiC4oOlyuyVecwMpZlUpBktpW8dOefD6y5
	VFpKUSV/SsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EEB43CBAE;
	Wed, 28 Aug 2013 19:39:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89C9C3CBA1;
	Wed, 28 Aug 2013 19:39:04 +0000 (UTC)
In-Reply-To: <20130828014138.GA30623@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 27 Aug 2013 21:41:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F5F17A6-1019-11E3-BB9C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233204>

Jeff King <peff@peff.net> writes:

> This makes the code simpler and shorter (because we don't
> have to correlate strchrnul with the length calculation),
> correct (because the code with the off-by-one just goes
> away), and more efficient (we can drop the extra allocation
> we needed to create NUL-terminated strings for each line,
> and just terminate in place).

Nice.  Will queue.  Thanks.
