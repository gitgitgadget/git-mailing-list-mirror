From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Forbid DEL characters in reference names
Date: Sat, 27 Aug 2011 11:40:04 -0700
Message-ID: <7vobzaaduy.fsf@alter.siamese.dyndns.org>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 27 20:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxNxE-0002Sl-Nf
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 20:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab1H0SuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 14:50:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab1H0St7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 14:49:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BFCB39D5;
	Sat, 27 Aug 2011 14:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=G7kSGtKQrPRFuyzhrhZZlbo/YGY=; b=nLs3gUV+JWK7JA3XSLzT
	9wCXKmlJ6yhxtRyRZtHczqZHOpwTjT1HmzaJhxeG5TO+64ZRcDaO1dF0MkUw92YW
	/2M4FJUR7xppznADU6RO72FPN517fecQbVcSHf2GxPE9bOxoaV3mZKbL2SuQCD7Q
	LgCIPVrobjiAdPrDkkNnHX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lg6A6hu3YSn6qd6A1yN+U8N6p7Ef5tEuf/UY08bWVDTN/S
	FHZjwvl2adEK6aq561B1vSii7rpmqLf5+0ujZythKyMD+usrq5TW7djw1JXXbzDe
	USzZR7AESh9JjJjjTuHl5nrR48DFrISmiq0Icfq6Vovv5hvtWcT+kKupgUkdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6358A39D3;
	Sat, 27 Aug 2011 14:49:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D91DC39D2; Sat, 27 Aug 2011
 14:49:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D1313E6-D0DD-11E0-B81C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180238>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Please check that the uses of "printf" in the test script are portable
> and quoted correctly.
> ...
> +invalid_ref "$(printf 'heads/foo\t')"
> +invalid_ref "$(printf 'heads/foo\177')"
> +valid_ref "$(printf 'heads/fu\303\237')"

I think these should be fine.
