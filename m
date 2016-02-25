Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 28068 invoked by uid 107); 25 Feb 2016 23:18:03 -0000
Received: from Unknown (HELO cloud.peff.net) (10.0.1.1)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 18:18:03 -0500
Received: (qmail 31793 invoked by uid 102); 25 Feb 2016 23:17:53 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by cloud.peff.net (qpsmtpd/0.84) with ESMTP; Thu, 25 Feb 2016 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbcBYXRt (ORCPT <rfc822;peff@peff.net>);
	Thu, 25 Feb 2016 18:17:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752288AbcBYXRs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:17:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 151A84754A;
	Thu, 25 Feb 2016 18:17:47 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uoq1oCgLlTqpdDX/iUbLy7J1Wic=; b=iPkSh5
	zD0L5f68Vzev9ZIJdNXaBKFos2GI/QnX0UWPozfdqWutSDDSEOkAZUJSUlZPl7GQ
	zqCOKEDN4dsRz022V31vqQJvxLDxCDEPwGeVLIVfqDaGO8o0Atu5XUVQW5sK0zqz
	BJ7t/l+Lt0rruqpMDx+GUx9IT64CeRAmAkYFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbx/NPK3382tCd88rfB5Y/fx71mf70lc
	2Yzvp6Y/WgDi/RA6b1sq8zA9OviqF4uGX6PkNh+XXwvrkPJqDPfAeG0YbDrMbfqf
	cxt5CBJpNhAY4Xz/qMxtVvnc45gHxWofF54PPvv5NM1Aws9OdoI+kxZkqQBUuvwv
	9z8bg861dt4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C61F47549;
	Thu, 25 Feb 2016 18:17:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C2FB47547;
	Thu, 25 Feb 2016 18:17:46 -0500 (EST)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in apache 2.4
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
	<20160225220045.GA10267@sigill.intra.peff.net>
	<xmqqbn74mlco.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 25 Feb 2016 15:17:45 -0800
In-Reply-To: <xmqqbn74mlco.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Feb 2016 15:16:55 -0800")
Message-ID: <xmqq7fhsmlba.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: FACAE9FE-DC15-11E5-A6A3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

