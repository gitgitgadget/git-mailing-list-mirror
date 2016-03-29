From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] t/t5520: modify tests to reduce common code
Date: Tue, 29 Mar 2016 13:13:37 -0700
Message-ID: <xmqqshz9vy8e.fsf@gitster.mtv.corp.google.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-5-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Matthieu.Moy@grenoble-inp.fr
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:21:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al01K-0007AF-0N
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbcC2UNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:13:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753918AbcC2UNl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:13:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1476850FD3;
	Tue, 29 Mar 2016 16:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7puQ1QjJkUfl7xxO3AEk7wRcJi8=; b=c0Tst9
	y5bCh0AGkoN4MxO9+l8UoG9LkGfAKhQ1S8ebRjWujbK7SS2cjTQP9bHmGFGxhZkI
	jXXRAQMdpCLqsU6Kx9WAO8MLF19UW9X4wsV+3IuRT05Pf3mrj1P2+HCVgehFl8Dh
	NSjRgS4iD5soX1Fb8KMSsYmEHoP8XIz+JAKho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e5xbTuE41wrF6pSp6OIcd175iG50VAUZ
	s04FvbN9MkLWqSwzS1PvbNBMyQPU5RApqDY8vSF+Bn7a5CPbMi6ieQoFEzQnfk/0
	+BY35mtqUrW+zOqtmw9vP63evH/65Td3k+OLCVqhcA6/XhvMCFQ7i37eeBRDX36u
	APrvxkAgvfs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09FFA50FD2;
	Tue, 29 Mar 2016 16:13:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F9D650FD1;
	Tue, 29 Mar 2016 16:13:39 -0400 (EDT)
In-Reply-To: <1459258200-32444-5-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Tue, 29 Mar 2016 18:59:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9F03BD4-F5EA-11E5-A9ED-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290186>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> There exist three groups of tests which have repetitive lines of code.
>
> Introduce two functions test_rebase_autostash() and
> test_rebase_no_autostash() to reduce the number of lines. Also introduce
> loops to futher reduce the current implementation.

Sound like sensible idea.

> +for i in true false
> +	do
> +		test_expect_success "pull --rebase --autostash & rebase.autostash=$i" '
> +			test_config rebase.autostash $i &&
> +			test_rebase_autostash
> +		'
> +	done

The lines between do..done is over-indented (will locally fix--no
need to resend).
