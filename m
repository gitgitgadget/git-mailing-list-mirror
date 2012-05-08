From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] dir: convert to strbuf
Date: Tue, 08 May 2012 08:54:37 -0700
Message-ID: <7vobpyy8g2.fsf@alter.siamese.dyndns.org>
References: <4FA8CA98.9050708@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 08 17:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmkP-0007Ju-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 17:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab2EHPyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 11:54:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893Ab2EHPyk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 11:54:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1057C4C;
	Tue,  8 May 2012 11:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Q5xASqz8+YFT
	acLoqfVBpnjjD9s=; b=MpXkS4+l1AM+WWPHSyqyz2iQS1QCHKokLUgYRvA3Rjhq
	Zt1UOTur+LLrysY5gkd9f2HgfQVLLy/Z/HnW+uEhsUfdLlhKi4KllevtPSH4+8uq
	8XKk6G57TS+1CwERICuI0SMzcT1F6g5R2YjW8r2IWyVpcZJED6qMA8SLH90Lgy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AGBP6l
	IsRmbsoH968l2LIfGc8jTlEyIdGv4Y1eiXK98K9AOP5YrIjfw+77a1X8OzFu5cgb
	KyTU2SrSvuR7WObzii4bFghJAGFUVhRpkoMr8NSfBQh230VGxurqgGhmMZRjuKBo
	7HK2QVlHADZQB3zAEdITt0PgOnzSzlT8aL/oc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C48457C4B;
	Tue,  8 May 2012 11:54:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 598097C4A; Tue,  8 May 2012
 11:54:39 -0400 (EDT)
In-Reply-To: <4FA8CA98.9050708@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 08 May 2012 09:26:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E498264-9926-11E1-BED0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197377>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> diff --git a/dir.c b/dir.c
> index e98760c..c6a98cc 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -873,14 +873,14 @@ enum path_treatment {
>  };
>   static enum path_treatment treat_one_path(struct dir_struct *dir,

How was this patch preprared?  It seems to have an extra SP after all S=
P
at the beginning of the line, which is a typical breakage pattern for
patches sent in text/flawed, but is marked as text/plain.

Thanks for a reminder; I located the original one in my mailbox and
applied.
