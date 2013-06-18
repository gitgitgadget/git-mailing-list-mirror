From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Tue, 18 Jun 2013 10:23:44 +0200
Message-ID: <87fvwfddyn.fsf@linux-k42r.v.cablecom.net>
References: <cover.1371460265.git.trast@inf.ethz.ch>
	<4795e6f40e7ce62fc4c414e8cbbd2aa777d3fbb0.1371460265.git.trast@inf.ethz.ch>
	<51C0064B.8060408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 10:24:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UorDA-0002oJ-II
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 10:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab3FRIYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 04:24:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:22351 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678Ab3FRIXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 04:23:54 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 10:23:47 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.211.168) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 18 Jun 2013 10:23:51 +0200
In-Reply-To: <51C0064B.8060408@viscovery.net> (Johannes Sixt's message of
	"Tue, 18 Jun 2013 09:03:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.168]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228172>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/17/2013 11:18, schrieb Thomas Rast:
>> +match_pattern_list () {
>> +	arg="$1"
>> +	shift
>> +	test -z "$*" && return 1
>> +	for pat
>> +	do
>> +		case "$arg" in
>> +		$pat)
>> +			return 0
>> +		esac
>> +	done
>> +	return 1
>> +}
>
> Watch this failing test case:
>
>    GIT_SKIP_TESTS="t950[012]" ./t3006-ls-files-long.sh
>
> 'pat' is too short and too sweet to be used as a shell variable name in a
> library function. ;)

Gah!  Serves me right for not testing test-lib.  Thanks for noticing.

/me goes stand in the corner for a while

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
