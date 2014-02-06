From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Fix the shallow deepen bug with no-done
Date: Thu, 06 Feb 2014 11:31:02 -0800
Message-ID: <xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:31:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUfP-0001zy-CA
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbaBFTbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:31:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbaBFTbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 14:31:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777576AE04;
	Thu,  6 Feb 2014 14:31:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xJpoGDooLtI/
	R7D+gu9ZRgmG5F0=; b=vDujKnQdipowdAKLO8+1uvws7K0lO1TNpBYz3Mj9SIXt
	9+dQsW7RR7ZRJVdTahqavHsIMrjWruI0SScIGuTS1OOtys4tu0ogouPUz9sWgSRQ
	1PFRioHamSkXL37PuftMhF7eLRYdnxX+8wiCT6nQ2rplje/A0D82p7T/I5j4/0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WnH6c4
	PC6exNxEy6SqdNcKGwzkKmrqnOfBrktj1qhRBrb5vB3gPcpIDaI7OBASWHY1AusY
	H66zDlfW47iYS9/Jz0I5XGiYtWiwKimJOZdYOctWyXPCDzM2QLYgaDJx6IR65xt7
	bl93lZo8XXyRDsmxamiMrQiLNAq5wVSwbi5qs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B2DA6AE02;
	Thu,  6 Feb 2014 14:31:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 179956ADFD;
	Thu,  6 Feb 2014 14:31:07 -0500 (EST)
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 6 Feb
 2014 22:10:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 398A1D54-8F65-11E3-9FA3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241713>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Reported by Jeff [1]. Junio spotted it right but nobody made any move
> since then.

Hrm.  Was I supposed to make any move at that point?  The discussion
ended by me asking a question "what happens if we did X?" and there
was no discussion.

> The main fix is 6/6. The rest is just updates while I was
> looking at it. 2/6 may need fast track though.
