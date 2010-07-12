From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/13] parse-options: add two helper functions
Date: Mon, 12 Jul 2010 09:45:51 -0700
Message-ID: <7vy6dgbqdc.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-2-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:46:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYM8t-0005eI-3h
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab0GLQqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 12:46:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab0GLQp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 12:45:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C75C4384;
	Mon, 12 Jul 2010 12:45:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jhgRU9UnBIjSYux2X1EoQ5fGozg=; b=N7yFM+NRFTNNFpgj/9ViLYc
	hCtrbzi/N/K9YRxs5hBeb+ay+rTmORdQZat91N7lYmGmVxOUvOq4fGVrnk1nnWbx
	KrNLUOQXt+5oOfZ8q8arefPDQJiyxSAlPaSiGGCgquWbSDaV0WuYZ0EHm4vZ4OQf
	0Nj0r+E7Kg89/9PujyaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SFrABE+7yIy0l0mrLuhmDSB5f0aRrPh9EfciAk1+7TbLSaudF
	/d9y/CYgHAmc7rdiHoc3a24NolF1HYENRcM5yEdGuFiqJQej9ecmhzw/nR5UIzeU
	mpHB+5lF+M5ILDdjc6L0+ewKOAwPPTRGJWDBCu+smduaeP0D8Sbzk1qxhk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF31FC4383;
	Mon, 12 Jul 2010 12:45:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF12BC4381; Mon, 12 Jul
 2010 12:45:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F164CFFA-8DD4-11DF-86EE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150828>

Bo Yang <struggleyb.nku@gmail.com> writes:

> +int parse_options_next(struct parse_opt_ctx_t *ctx, int retain)

I think the latter is usually called "keep".

> +{
> +	if (ctx->argc <= 0)
> +		return -1;
> +
> +	if (retain == 1)

Should this really check for "1", or would

	if (keep)

be more conventional?
