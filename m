From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t5601: add more test cases for IPV6
Date: Sun, 22 Feb 2015 18:50:00 -0800
Message-ID: <xmqq61atuysn.fsf@gitster.dls.corp.google.com>
References: <54E8A9DD.7090908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, lists@hcf.yourweb.de
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 23 03:50:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPj69-0002yy-2N
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 03:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbbBWCuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 21:50:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752121AbbBWCuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 21:50:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC3FB3B06E;
	Sun, 22 Feb 2015 21:50:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5CY71phiFA/q
	nyPe1QCj9Ign09s=; b=t6PG8MHvtdqpGNTEI4BhVBkf6tfOnW6ny54CD4YdnJRR
	Y/xk6a3JzPamFPU6jgf6IWula8TKW/eiPYU6bw4ANXKePtZ9LDEHpRWZ/PPOq/Nb
	ohI8MfjwwnW9tSy0txH+IgxLtbv6nHV6h6eZqbJab/NEq2fNf0C1x40M0ZyrD2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cu3ywD
	y2eO4sDbf+hFzn3GZ4um7vdhWq8t+FkezDQL9V97NkFAP+usNJh45ry1+kEV2/y0
	Ez1ZlCHkrE6czVg6/6oxRS4xro3xHP6c6F0AOQU+uRJchAYYfZ2FyjJv669nrrOG
	lua0Nin1+uFgDNNrmt4HRjFc1mBf6ySgsZL/k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1F1A3B06D;
	Sun, 22 Feb 2015 21:50:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F16683B06C;
	Sun, 22 Feb 2015 21:50:01 -0500 (EST)
In-Reply-To: <54E8A9DD.7090908@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 21 Feb 2015 16:53:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9D3667E-BB06-11E4-89B3-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264245>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> @@ -359,7 +366,7 @@ done
>  for repo in rep rep/home/project 123
>  do
>  	test_expect_success "clone [::1]:$repo" '
> -		test_clone_url [::1]:$repo ::1 $repo
> +		test_clone_url [::1]:$repo ::1 "$repo"
>  	'
>  done

This change is somewhat a curious one.  Why quote the last
occurrence of $repo but not the previous one?

> +for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
> +do
> +	euah=3D$(echo $tuah | tr -d "[]")

What are tuah and euah, by the way?  Are they FLA for some phrases?
