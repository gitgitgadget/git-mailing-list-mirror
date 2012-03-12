From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Mon, 12 Mar 2012 13:06:48 -0700
Message-ID: <7vk42pr3c7.fsf@alter.siamese.dyndns.org>
References: <4F5E3298.5030502@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:07:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BWE-0005pi-OG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057Ab2CLUGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:06:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757049Ab2CLUGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:06:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3204E6606;
	Mon, 12 Mar 2012 16:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTxa/ix1kT2uJwJl8us5kqvJ7h4=; b=nXXaky
	bMZkhLL6JRePKaFXkXfa0MyE9XM4E7bCxm9EmHOT6wSa90hdPnNvTmqqcCVKvE0f
	ivQCGIGFZamh+uKHQ9Gce4dXsFBoGBMzrksP58HCuK187eZNnXbajRGFvBrjErJO
	bDK9XqloGpuBu8ZfWyXhIQ0g5pcxHzgK3DLfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SAO38g89rbLRqc0MIFAJmG+u470o9FTa
	rXu9dP3U0hmAjpNHxOd6P4X7Krk4pkNJFXeSFxs6PBld6VNR/M87sfQOP2Bv1Qxz
	7291QlmhFBAo6fvn/tIGFj/zEDXzyXJcet1RurnUdNYaUY/bVhtncctU0DayOfoK
	NVY9Vna2d3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BFC6605;
	Mon, 12 Mar 2012 16:06:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A09896604; Mon, 12 Mar 2012
 16:06:49 -0400 (EDT)
In-Reply-To: <4F5E3298.5030502@seap.minhap.es> (Nelson Benitez Leon's message
 of "Mon, 12 Mar 2012 18:30:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E71931DC-6C7E-11E1-B6CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192936>

Whatever new token you use, please keep AUTH as a substring of it.

We may want to retry a request to deal with intermittent failures on
the server side or the network between us and the server; HTTP_RETRY
would be a good name to signal such condition after we see a failure
response from the library.
