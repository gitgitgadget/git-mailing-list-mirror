From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 21/21] t3080: tests for git-list-files
Date: Wed, 28 Jan 2015 11:03:03 -0800
Message-ID: <xmqqa912iv88.fsf@gitster.dls.corp.google.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
	<1422189476-7518-22-git-send-email-pclouds@gmail.com>
	<CAPig+cQ8AuoA=ZNaOiZ_JQb-fKtXa-mFhoYQg+eWJxF3eFy9FA@mail.gmail.com>
	<CAO2U3QhA1bGAKmM4OL0VVuOfwaocqmFEsQdZNhSqf_7tkJ+=WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 23:05:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGakI-0002XS-7f
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 23:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759098AbbA1WFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 17:05:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755330AbbA1UW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:22:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B96E03237D;
	Wed, 28 Jan 2015 14:03:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FHC/5/Lt1EVbvVw7hUetRFwvjCM=; b=DYpHAY
	vDibbtIpeSLECTyEbnXO8+qcrt7IzxVy6olGKcKMrREOOFOrH84m3EhbTa+H0PFa
	zkOpMEXJH9eA2UgAYIHDgENb2xtlTspb4ycKIHy9gUPBkhjpWb6F07co0U3yghvs
	4u/lRrxA3A/GOj24Z629GaEAXx39RiSM8Vz7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jnw/2ac6rmv7iRxyYm9yQKhz6ulUvlPF
	jDoC5PjHnhOTZMiuDmyuTxKcWdGsdqCVeXKauKPImkWuZYWd7LY5GBp0nMN+wt7X
	LJIUkTzO2cpKargHEQ69cKBjIgMhTiZhgSJ2e1kyvE0/JrtMMGRFgYx01Yymc4ax
	Xd4fINUWRi8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A30353237C;
	Wed, 28 Jan 2015 14:03:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D85C32375;
	Wed, 28 Jan 2015 14:03:04 -0500 (EST)
In-Reply-To: <CAO2U3QhA1bGAKmM4OL0VVuOfwaocqmFEsQdZNhSqf_7tkJ+=WQ@mail.gmail.com>
	(Michael Blume's message of "Tue, 27 Jan 2015 20:44:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49C8B1E8-A720-11E4-B9E8-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263120>

Michael Blume <blume.mike@gmail.com> writes:

> Test 3 is failing on my mac:
>
> expecting success:
> test_config color.ls.file red &&
> test_config color.ls.directory green &&
> test_config color.ls.submodule yellow &&
> git list-files --color=always >actual &&
> test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
>
> --- /Users/michael.blume/workspace/git/t/t3080/color_ls 2015-01-28
> 04:40:23.000000000 +0000
> +++ actual 2015-01-28 04:42:59.000000000 +0000
> @@ -1,3 +1,3 @@
> -dir
> -file
> -gitlink
> +dir
> +file
> +gitlink
> not ok 3 - color.ls.*

Same here on Ubuntu.

Regardless of the breakage in the code that violates the expectation
of this test, I do not think you would want to have test_cmp compare
coloured output directly without using test_decode_color.
