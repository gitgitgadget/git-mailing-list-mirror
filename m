From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 4/6] add a test for semantic errors in config files
Date: Mon, 28 Jul 2014 13:22:26 +0200
Message-ID: <vpqmwbtu3rh.fsf@anie.imag.fr>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
	<1406543635-19281-5-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBj0r-0001z9-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbaG1LWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:22:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60868 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbaG1LWe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:22:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBMPdF011734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2014 13:22:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBMQPD015617;
	Mon, 28 Jul 2014 13:22:26 +0200
In-Reply-To: <1406543635-19281-5-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 28 Jul 2014 03:33:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jul 2014 13:22:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6SBMPdF011734
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407151346.45543@yHGz0m+4K8nrKpd97KutWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254309>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'check line errors for malformed values' '
> +	mv .git/config .git/config.old &&
> +	test_when_finished "mv .git/config.old .git/config" &&
> +	cat >.git/config <<-\EOF &&
> +	[alias]
> +		br
> +	EOF
> +	test_expect_code 128 git br 2>result &&
> +	grep "fatal: bad config file line 2 in .git/config" result
> +'

This is PATCH 4, and it tests a bug fixed in PATCH 1. It would have
eased review to group both patches, either

PATCH 1: introduce test_expect_failure test to demonstrate the failure
PATCH 2: fix the bug and change test_expect_failure to test_expect_success

Or putting both in the same patch.

I think the series is OK like this, my comment is just to be read as
"next time, here's how to do better".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
