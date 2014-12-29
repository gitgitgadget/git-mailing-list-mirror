From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] checkout-index: fix --temp relative path mangling
Date: Mon, 29 Dec 2014 10:58:42 -0800
Message-ID: <xmqqlhlqz3j1.fsf@gitster.dls.corp.google.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
	<1419414196-58587-6-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Russ Cox <rsc@golang.org>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 19:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5fWj-0007go-B9
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 19:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbaL2S6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 13:58:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751061AbaL2S6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 13:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 435CB294B4;
	Mon, 29 Dec 2014 13:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=479Y1epl3WNsGGPlo/Rd9zE1d18=; b=bKrBMM
	0r7/CnVneyNj6lM7T3AizJ7+npXn+OTco5r5CpDxMmPDHQojvVfAptcVbrWjq57C
	HmlM4noRap1GRRNAFIicrnPnNeLDCcT3bpUHcA10yeE1uDBVQErzFGdtnMEfk7YN
	XKS7xHBLM/4/YQwT4ESftobqJv2D89fkLJZfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FrM4Cy4nw1kscRtYy8E16gPk4vFWTjLk
	lNwSecRoHCneo11CnNAh7j33S3mqVDdbJN57vPIj2Q9UNfoVi33W1SpmpN44MK30
	Nsa/wpF1a4EUjbc5G4sbwKY56DxcAwJ98Ocj2Xp+cSeyU5FYiM8a2Qb0iziMEKrp
	zI2RoBY+SYc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38B9E294B3;
	Mon, 29 Dec 2014 13:58:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0A70294B2;
	Mon, 29 Dec 2014 13:58:43 -0500 (EST)
In-Reply-To: <1419414196-58587-6-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 24 Dec 2014 04:43:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5DD67DA-8F8C-11E4-9F2E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261873>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Fix this by taking advantage of write_name_quoted_relative() to recover
> the original name properly, rather than assuming that it can be
> recovered by skipping strlen(prefix) bytes.

Nice; I was wondering if we already had that helper when I saw the
initial report of the problem.

Thanks for a nicely constructed series.  Will queue.
