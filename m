From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: apply fallback encoding before highlight
Date: Tue, 03 May 2016 11:33:42 -0700
Message-ID: <xmqq7ffbng8p.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
	<1462280451-43388-1-git-send-email-shin@kojima.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>
To: Shin Kojima <shin@kojima.org>
X-From: git-owner@vger.kernel.org Tue May 03 20:33:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axf8p-0002C2-OV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbcECSds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:33:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755635AbcECSdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:33:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1AFF16B12;
	Tue,  3 May 2016 14:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9o9C/u5l2pJaKCCCATIEPQDRsIE=; b=puhaKy
	9J3ASpHf+pls9dNBDIobmM1qkDT8DjLdYQx3NYvvThhq/8u8MPwg1dEKrwWorame
	VS8REQUlLQfW/OZWX4t0CYJ7QrUNcHPqCT2Fjg2KABcHq6pOwwP0+6TOcbvDSHHc
	s5UHsA9R8yvEB1RihTCBK+5ljsTK+gT997rqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XLO42F6a58Z+AGN/UsftfuTRHRW4IUyE
	tkVo9BpzWV8YIbCznJ3ynHMgBvlTfyeX+lrJM0/2EavFXrnANMWDo7lqmeNjHW58
	DXHKea7pqpTzwYYNZIseedxLUp57eUheTChSDWrfwRgM+RetkRVJ2NDxNbPj8Nl6
	srOjR4lzO4I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99BD816B11;
	Tue,  3 May 2016 14:33:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11B6016B0F;
	Tue,  3 May 2016 14:33:44 -0400 (EDT)
In-Reply-To: <1462280451-43388-1-git-send-email-shin@kojima.org> (Shin
	Kojima's message of "Tue, 3 May 2016 22:00:51 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90D4F224-115D-11E6-9364-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293432>

Shin Kojima <shin@kojima.org> writes:

> Some multi-byte character encodings (such as Shift_JIS and GBK) have
> characters whose final bytes is an ASCII '\' (0x5c), and they
> will be displayed as funny-characters even if $fallback_encoding is
> correct.

Just out of curiosity, do people still use Shift_JIS aka MS-Kanji?
It feels so last-decade, if not last-century ;-)
