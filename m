From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] memory leak reported by valgrind
Date: Mon, 09 Aug 2010 12:37:02 -0700
Message-ID: <7v1va760ip.fsf@alter.siamese.dyndns.org>
References: <wes62zknmki.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiY9t-0000v4-MP
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab0HIThO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 15:37:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab0HIThN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:37:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 338EACC8E9;
	Mon,  9 Aug 2010 15:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OLvNRnSoPgf/TAKv05YNaQjA0G0=; b=k2hTPw
	n65Ra7FkRbtwJCMLI8vPKQGgVM13GmcV98nmOuxuTcSPaO9GTvWzbTki7t6aL4tf
	Ug9tzDqfhK7Rc3PY4oyywe0gNGMaVkV1374wvkGHehuDMwIum922BtvlelNBPfZQ
	zVAfudIcvswnlorJ8pPzPadN5KdECVx0cHhI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JkaLriMf4YZO5Hkc3sVHAQEspigH1Z2c
	izyaHCV2QczqX1qPx6+l8OYHi25o5EnyQD1QNgTx3odvZyxm0gSxldO4IwnCqTTc
	ZvB6le4jESkbnlk9g47fhvzxmjlQJ+vZUzr1e/jhg44Vl7onoKyjIo9siOVx5jlL
	JHjaJxWN+E4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F4F8CC8E8;
	Mon,  9 Aug 2010 15:37:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56449CC8E7; Mon,  9 Aug
 2010 15:37:08 -0400 (EDT)
In-Reply-To: <wes62zknmki.fsf@kanis.fr> (Ivan Kanis's message of "Mon\, 09
 Aug 2010 11\:48\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80E9E7B8-A3ED-11DF-93E2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153007>

Thanks, but doesn't it essentially sit at the end of main(), only for _exit(2)
to clean after us?
