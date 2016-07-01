Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13CAB2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcGAU16 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:27:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752082AbcGAU15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:27:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6640E27E34;
	Fri,  1 Jul 2016 16:27:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XnogbEQujfJG0NGUZIFvSOOoCDg=; b=SAlDFE
	zpJiAHQFfcJCyETZdvG+19/dakL8iZKX0oReSUMSw2KUPWbo7ZBUV1sXHSUMocV+
	0lcIQrSXT7hQo9Mm9bjXTMk5PuQG5cJOHwGv30qNrIcgWFzBwI/oh26RsOWLoDNg
	l5Kgpp8mlfxmhgqtaTs6TR07NHkne6RxYGMPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKbnc5kMDsexUDrlIXt/qxZ3AcNse1bp
	wuT6RMRr6AIwCmPwSuLeFw9mHjdY1zgnjLJc7OtuoPkeBlmx6FoYcYs76ZiB+Sml
	EKllxJjWpaxy6UcLOcsT82SU2JVs2W70ozBGce5SQjxBxUrEjJKe1DnlBfPhtl/u
	QB1BcY1J9+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B89F27E33;
	Fri,  1 Jul 2016 16:27:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFB2827E31;
	Fri,  1 Jul 2016 16:27:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] t7810-grep.sh: fix duplicated test name
References: <20160630101348.15665-1-charles@hashpling.org>
	<20160630101348.15665-2-charles@hashpling.org>
Date:	Fri, 01 Jul 2016 13:27:30 -0700
In-Reply-To: <20160630101348.15665-2-charles@hashpling.org> (Charles Bailey's
	message of "Thu, 30 Jun 2016 11:13:46 +0100")
Message-ID: <xmqqtwg9w1cd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D64652A-3FCA-11E6-ACE2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> @@ -353,7 +353,7 @@ test_expect_success 'grep -l -C' '
>  cat >expected <<EOF
>  file:5
>  EOF
> -test_expect_success 'grep -l -C' '
> +test_expect_success 'grep -c -C' '
>  	git grep -c -C1 foo >actual &&
>  	test_cmp expected actual
>  '

Makes sense.  The previous one (outside the pre-context) is about
running "grep -l -C", but this one is about "grep -c -C".



