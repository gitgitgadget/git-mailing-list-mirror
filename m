From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix a bug in compat/bswap.h endianness detection
Date: Fri, 30 May 2014 11:50:30 -0700
Message-ID: <xmqq61kn9k3t.fsf@gitster.dls.corp.google.com>
References: <1401463360-26972-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cbailey32@bloomberg.net, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:50:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRt7-0008IH-Bf
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbaE3Sum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:50:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51225 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbaE3Sul (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:50:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BED5D1A699;
	Fri, 30 May 2014 14:50:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dtrkur4Jw+MYjQLFy3LmEnltqyE=; b=BFj199
	NBIbsqI92/4dELRb9FsGVDptM+VCeiZEC52IF4OfTtEZ9R2V5Wv/MqKKAq4D6ULZ
	u756+5ZnOgOqaQDKjEflpNbUZYTU8rUMCrSfcqYDqiCkkIyacP2NAkD2PjCvj4rL
	pi34W7VHREEFmDeDVRjPWVFxUsK+3UgxichO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jM8XLLxOGMX4vZO7RUHjUYTLfkcJ/Hbv
	I/yoYg0tvZJCfxXY4qh8g6Bp/3bAWwVZzmrVqfHPgeihy2NgpPEm3/uQlLAymitW
	JmZTVVpEte+DdYeninoOzBbogXkxLqkK4sHN0e96lePtenr2FbkBqrPH5Qpmwfg/
	R5mdZzsmBtY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B54EF1A698;
	Fri, 30 May 2014 14:50:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39E601A696;
	Fri, 30 May 2014 14:50:32 -0400 (EDT)
In-Reply-To: <1401463360-26972-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Fri, 30 May 2014 16:22:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46EE009A-E82B-11E3-AF3B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250467>

Thanks; this should have been caught during the review.

+# if defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
+#  ...
+# elif defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
+#  ...
+# else
