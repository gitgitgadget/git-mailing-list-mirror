From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 09/19] Add watchman support to reduce index refresh cost
Date: Thu, 05 May 2016 15:45:13 -0700
Message-ID: <xmqq1t5g9lae.fsf@gitster.mtv.corp.google.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
	<1462484831-13643-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:45:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayS1M-0007LL-EM
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781AbcEEWpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 18:45:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757026AbcEEWpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2016 18:45:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF8FE18F7E;
	Thu,  5 May 2016 18:45:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WQCN3GnY4D8t
	eZhAztR+FEa0lwM=; b=fuCFeBhgrXObvHMhcPb2eHrPEqyIWOUPeonebg7KjyYl
	9VoMYGKaI2IPl4HRIw7oW1nFrMbfARgHvZwi9nv0/hZGshnSwLxWPPwV51pc91vi
	kZE49KDNa2SCj9YRlPl2GIhIhg7tMoSIv4/oTRvfCmTC8jzXTZ2vpvYVrbLSN5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wiU/fm
	vA2+YeXO2zEWgsadYOVcF7+WzFm0v5ZSVCkwciehXjWTEYd/YqzXSMQDTWIn+OwG
	P3LxF+ne9+XE6XZjLDrFW+kBJHNW/+wJ1RJg4M/CNGB4jopBUaHBXAl00ckfPQGF
	DRyy+NDPc1YSGUilFUeY/Bhl0pAiJKENdtMfM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2E4018F7D;
	Thu,  5 May 2016 18:45:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33D3A18F7C;
	Thu,  5 May 2016 18:45:15 -0400 (EDT)
In-Reply-To: <1462484831-13643-10-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 5 May 2016 17:47:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08B6B5AA-1313-11E6-BD18-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293715>

David Turner <dturner@twopensource.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Subject: Re: [PATCH v8 09/19] Add watchman support to reduce index re=
fresh cost

Subject: watchman: support watchman to reduce index refresh cost

> +static struct watchman_query_result* query_watchman(
> +	struct index_state *istate, struct watchman_connection *connection,
> +	const char *fs_path, const char *last_update)
> +{

static struct watchman_query_result *query_watchman(

Asterisk sticks to the variable, not to the type.
