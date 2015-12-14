From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] format-patch: check that header line has expected format
Date: Mon, 14 Dec 2015 13:45:17 -0800
Message-ID: <xmqqy4cwhfgy.fsf@gitster.mtv.corp.google.com>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
	<1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:45:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8avw-0007t8-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbbLNVpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:45:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932382AbbLNVpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:45:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A2BC33C85;
	Mon, 14 Dec 2015 16:45:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8oGWInuC0hK0H+lWWaFuGkDr1fM=; b=xtlmHK
	68E/iHMZz5PWKAeO1FPkbqv2F/k41NY1tTlac77uqbu7jbG6QLhyNre7rCO3Rxot
	cJ2+0l4YszfwPGOFlq/tnzrUF2Q4BuGC0tSn318yC3TvZ9Q9NEaBooN8gNqJ9gnr
	oeAVaYog2me8xsw/1A0WDjGHzmGFXr5g6cakw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R1makwZ2YnzwdgjEKMKe9D7QAPoJA1Kk
	myx8mxZ9fyVocOlwJOTwgqCaen2aPbIiCmapAAjvjZOYwRtMBykV5R/S3PwIMpFu
	hzoTM99DN9eQamD4SG60XGGXoNasb9Vsp4TVgiGCZ6sqgtBcEhoL7wVL0SqD2LQZ
	D4aqH9EFmvM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7099833C84;
	Mon, 14 Dec 2015 16:45:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A113333C7D;
	Mon, 14 Dec 2015 16:45:21 -0500 (EST)
In-Reply-To: <1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 13 Dec 2015 17:27:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9AE6BFC-A2AB-11E5-92E6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282426>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_expect_success 'From line has expected format' '
> +	git format-patch --stdout v2..v1 >patch2 &&
> +	cnt=$(egrep "^From [0-9a-f]{40} Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&

Also, with $_x40, you do not need egrep.

> +	test $cnt = 3
> +'
> +
>  test_done
