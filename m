From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add grep.fullName config variable
Date: Tue, 18 Mar 2014 11:39:23 -0700
Message-ID: <xmqqzjkn8i78.fsf@gitster.dls.corp.google.com>
References: <874n2w3abu.fsf@igel.home>
	<xmqq7g7sbh56.fsf@gitster.dls.corp.google.com>
	<mvmy507stf1.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 19:39:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPyvJ-0001t8-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 19:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbaCRSj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 14:39:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109AbaCRSjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 14:39:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C3B772958;
	Tue, 18 Mar 2014 14:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YiiOsMbHfiSGOydiZ+Xqsa0HvXU=; b=blvbqG
	VQII6zVY60+4eWZqj5ujbvwBk7pRroOUC0YKbUS5bcowGxmdBgOVXQXPWP1imf5d
	jGQuD1/sRQoH8J9NnaoJy3cZIylJkaKGbsG3suNRO03OJQf2wEdO/A/X+CNsQLJc
	BfjyHh3fcyNDod13YT1FpTri2V7esUPHlgu4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HROLldn8gtAFfLad/8IIMcYsEq5H2oNB
	XHMkf6gm06CyI2FUDAs+x/qlj8EV8vyjf+m4dTD+0x7TlxlPmB2tKLMkeOHuCs73
	JLmvpQFPMhdZdYmit6o4KUNbjbHYqFWEz2s0udi7hNcHBQapp0759f8nCO3gZdZe
	Knt7Y39i9lE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 475EE72957;
	Tue, 18 Mar 2014 14:39:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8F072954;
	Tue, 18 Mar 2014 14:39:24 -0400 (EDT)
In-Reply-To: <mvmy507stf1.fsf@hawking.suse.de> (Andreas Schwab's message of
	"Tue, 18 Mar 2014 11:16:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0C68828-AECC-11E3-85F1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244366>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Yes, that would be required.  On the other hand, currently it is
> impossible to cut-n-paste a file name without --full-name, since the
> pager is always started in top-level.  Perhaps it is better to fix the
> latter?

So far we never cared where the pager runs, but as a principle, I
think it would be nice if we run it in the original subdirectory,
not at the top of the working tree (unless we have to bend backwards
to make the codepath involved too ugly, that is).

Don't we have the exact same issue for the editor, by the way?
Shouldn't we be running it in the original subdirectory as well?
