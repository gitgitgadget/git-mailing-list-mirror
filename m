From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 1/2] clone: allow to clone from .git file
Date: Mon, 22 Aug 2011 20:53:01 -0700
Message-ID: <7v8vqku6le.fsf@alter.siamese.dyndns.org>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
 <7v7h66y4s5.fsf@alter.siamese.dyndns.org>
 <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com>
 <7vbovhw9pb.fsf@alter.siamese.dyndns.org>
 <7vty99upn9.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8ABBB69V3pFjGohJwAQbZ_MwGqv=p27tUHF8HAGRMLpQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 05:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvi37-0003AY-C6
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 05:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab1HWDxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 23:53:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab1HWDxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 23:53:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC06C55AE;
	Mon, 22 Aug 2011 23:53:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcawfHVMxIAhwf/NdVn/GhfMaO0=; b=Kg5DU2
	pV5840kDwSxpz811TcvXpCtkeuUYOnLg3T/JSvv81hbn36fMunr5ann6GsT/8WFi
	z4N1RvDYhb50DT2nfaqwrnxHUOtCZ8WhQz+rcJ2rh5EskwXHU8Nr6GGrVnGUEi98
	JIRdA171txeghxyxZT0mCfw2krD2hQy28n0Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VJPqesubJ6uAfg5De+T64wjypR9K5R6Q
	KIvuWVWHLSh10gtlMDPzoYnGyFP7mFloiFkxp1LChXfLmogjF9OdY+Ix1dTtVeoX
	eKA4rzbppdoeo+oQpox0JxG3OGQr9UKKnS1V10UNeXOKSv74megkcrD7LiyA6pYJ
	wjEvHVf0iF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4DD155AD;
	Mon, 22 Aug 2011 23:53:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AB6C55AB; Mon, 22 Aug 2011
 23:53:04 -0400 (EDT)
In-Reply-To: <CACsJy8ABBB69V3pFjGohJwAQbZ_MwGqv=p27tUHF8HAGRMLpQw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 23 Aug 2011 08:11:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67825E86-CD3B-11E0-9200-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179918>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Set *status here too? I assume we need valid *status whenever NULL is returned.

You are absolutely correct.

But I ended up deciding not to add "gently" variant for now, as nobody
needs it, and if we were to have "gently", we should also rethink the
earlier checks in the function if they should give diagnosis. Please check
what is queued near the tip of tonight's 'pu'.

Thanks.
