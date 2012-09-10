From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Mon, 10 Sep 2012 14:21:45 -0700
Message-ID: <7vy5khlgk6.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:21:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBQa-0002Ru-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab2IJVVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:21:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab2IJVVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:21:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 737669C4D;
	Mon, 10 Sep 2012 17:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z8NiHS4bI/nqUyntou4WwIwN4Y8=; b=M57Rtd
	efZOCXPZ+gRalXHYAWGXHd3s7uvKyMuC3pBFkYZXUlxeSt1NdZiQshZ/HGXmtVQw
	cTYHMPhDGmYKCTp9QY9/DcPD2E/eXusZPet0mudugCXFXJIngPy7rS8LfVF4erU8
	3hGvD/edQh/p1JjQJAyg4t39fx8sCYHjqDV20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C63sZLcYevW3bFSlfgBlPaShK8BdfM48
	jZADKn1xrqBLU5cthb8izrp2Y6kQ2ecUDU7mpfYco2DCeMWLL/AOU2/W/QzWwoL0
	If2qiFakESP/51U8ygKZnRRO8vJD2w0+Odpo3lxv1410em06Gu8iEQniYEvZeMu5
	/W9o0KKblM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6148E9C4C;
	Mon, 10 Sep 2012 17:21:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D509F9C4A; Mon, 10 Sep 2012
 17:21:46 -0400 (EDT)
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 9 Sep 2012 08:19:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86D3BC4A-FB8D-11E1-A61E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205192>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This patch series depends on the "Add some string_list-related
> functions" series that I just submitted.
>
> This series is a significant rewrite of v2 based on the realization
> that the <nr_heads,heads> pair that is passed around in these
> functions is better expressed as a string_list.  I hope you will find
> that this version is shorter and clearer than its predecessors, even
> though its basic logic is mostly the same.
>
> Sorry for the false starts in v1 and v2 and the extra reviewing work
> that this will cost.

Thanks for a pleasant read, nicely broken down into digestible
pieces.
