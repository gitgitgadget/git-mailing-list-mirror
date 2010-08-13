From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] test-lib: Multi-prereq support only checked the last
 prereq
Date: Fri, 13 Aug 2010 22:28:40 +0200
Message-ID: <4C65AAF8.80009@kdbg.org>
References: <20100811014325.GA4169@burratino> <1281528278-15659-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 22:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok0rz-0001CL-GZ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab0HMU2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:28:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:48650 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329Ab0HMU2m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:28:42 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C9FE3CDF86;
	Fri, 13 Aug 2010 22:28:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1281528278-15659-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153491>

Am 11.08.2010 14:04, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> -		say_color skip "ok $test_count # skip $1 (prereqs: $prereq)"
> +		say_color skip "ok $test_count # skip $1 (missing $missing_prereq =
of $prereq)"

This needs fixing: When a test is skipped due to being listed in=20
GIT_SKIP_TESTS, then the output looks like this:

ok 47 # skip --ignore-submodules=3Duntracked suppresses submodules with=
=20
untracked content (missing SANITY,POSIXPERM of )

(In this case, there was a test before number 47 that was skipped due t=
o=20
missing prerequisite.)

Please also note that - when a prerequisite is not satisfied - the text=
 in=20
parentheses does not say "prerequisite" or similar anymore. IMO, this=20
should be added back.

-- Hannes
