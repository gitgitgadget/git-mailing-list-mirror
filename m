From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Thu, 12 May 2016 12:56:48 -0700
Message-ID: <xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:57:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wjP-0001hI-0R
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcELT47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:56:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750806AbcELT45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:56:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 350061AC07;
	Thu, 12 May 2016 15:56:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4F/37QfO5UqsS2xb7ZNsqR82is8=; b=Nw8pyS
	dRPA89jRH4EUCzqAwtgb1VIp6ivJEMOjJAI2pGtOD4DjsL0hqcaAmnsr1qJ4EvCg
	yTQpL9b/OUi1ZdPAJqPo4LuO/ZpfWnEusfpmbxDf9K0UER2HSGNB/sbo5BwzVvXH
	IIFFOtQlnDzzEa1x0dZICV5qiAzDY195FMueM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4RQm1IocAh4FShT9OSEfmX4QsNXZ3fo
	0oVMmvGRlWyoJxre71R2itMcsybdfgBps2bDsow9vxsAOkb+B8MW2HCcjiT4BDmH
	InDgDFlBETrdRZALXHwaCf0r6M8+Pg4UZ1j8iMF/qtVBHHjQQGDWzAisUi7BwPmt
	xF5yKw51FhA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CA2D1AC06;
	Thu, 12 May 2016 15:56:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EE081AC05;
	Thu, 12 May 2016 15:56:50 -0400 (EDT)
In-Reply-To: <20160511131745.2914-49-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAD22AA0-187B-11E6-97BB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294439>

Christian Couder <christian.couder@gmail.com> writes:

> This is just a small cleanup.

... which may have been better happened at 09/94.

Up to this point, the conversion looks quite sensible, even though I
think the organization of fields in apply_state do not look logical.
