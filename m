From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] decimal_width: avoid integer overflow
Date: Thu, 05 Feb 2015 12:42:56 -0800
Message-ID: <xmqq1tm4ks33.fsf@gitster.dls.corp.google.com>
References: <20150205081419.GA7666@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:43:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTGV-0001FG-UR
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbbBEUnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:43:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753935AbbBEUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:42:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D693608E;
	Thu,  5 Feb 2015 15:42:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7viY513eZGwbr5Aake8FNpt8uvI=; b=avmFnk
	MAVDnlF2+SNTuhW3WiVVtgYyeXbwfkBP0moyLD6oPPpL+uGewspsDF9NAmTWVSEQ
	s9jqN00QqHPwsomJHXXrx4pjc/oKPdBYYmzPzsdJUCvtKPILWDICtCjqRko2zhNp
	ewgqqigFWeEytqec3eToyZVeflNlrKfuE8oBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=On4K/siR8ib49airVhd9JVBgzHkvqnao
	afGstZDZg8DAfG2H6YQ2RHzTPVb84mRZ28hapqPgXYIVfSbD6Mp4rVEzP6DRRI+q
	FHyHMY9h3lFtbqVqrl8S6vznTvcOrrrW+aDPHXi4Ri8EzEeFVsyGlFK61K7h69gO
	OMsOcS8krX0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B25C3608D;
	Thu,  5 Feb 2015 15:42:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD16B3608B;
	Thu,  5 Feb 2015 15:42:57 -0500 (EST)
In-Reply-To: <20150205081419.GA7666@peff.net> (Jeff King's message of "Thu, 5
	Feb 2015 03:14:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 913A1DC0-AD77-11E4-BE2A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263401>

Thanks (and thanks for ungetc one, too).
