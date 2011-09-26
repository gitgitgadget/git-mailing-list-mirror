From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rerere with modified/deleted conflicts
Date: Mon, 26 Sep 2011 16:10:44 -0700
Message-ID: <7v62ke293f.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1109261904340.2718@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KK3-00080q-F4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab1IZXKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:10:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab1IZXKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:10:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EDB04420;
	Mon, 26 Sep 2011 19:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=leSlxfWnUfF0ViL1ndq1LTAI7Po=; b=BfgO/W
	qpCvQ5s2YRVxRtE0DFHd2qgGEOcmTXrCEiyBWT/nxvXDQPNV6tMe9JdCNcCZ9jfl
	VJMFZUDly0wOMMMWKR6fmApYCBpD9i17vKAT0f8TPbhrtpiC99i1QTxjLTj0/OQY
	qpo/JnYgCbOoyNuAyiLkfDpYzQ60WI3Ahol6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeoX3K7sP8ZdY8a7WW4ItSnbXAXBioyH
	TSHIQd9M7koJqmYuLD4Klvg5BXb9hXxnTdlaZYaQK+36aoyHvbTfqekx5P6azdQW
	qO6wYlSmBiLoENOF0JiOBbVn258FyNn7cdXocs3/RtqOkLuaID3KiXd+DCwoHPUb
	U8x2fbnCe30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FA3441F;
	Mon, 26 Sep 2011 19:10:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E563A441E; Mon, 26 Sep 2011
 19:10:45 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1109261904340.2718@xanadu.home> (Nicolas
 Pitre's message of "Mon, 26 Sep 2011 19:06:06 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3D604D4-E894-11E0-BA7D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182182>

Nicolas Pitre <nico@fluxnic.net> writes:

> Is this supported already?

I do not think so, as rerere is about applying previous change using 3-way
merge. A modify/delete conflict would mean you have only two stages, and
while I can see somebody might want to say "I want to ignore further
modifications to this dead path ignored and resolve in favor of deletion",
it felt a bit too aggressive to my taste when I last worked on rerere.
