From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Tue, 18 Jun 2013 09:03:39 +0200
Message-ID: <51C0064B.8060408@viscovery.net>
References: <cover.1371460265.git.trast@inf.ethz.ch> <4795e6f40e7ce62fc4c414e8cbbd2aa777d3fbb0.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:04:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UopxH-0004Ws-RA
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab3FRHDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:03:47 -0400
Received: from so.liwest.at ([212.33.55.13]:48642 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab3FRHDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:03:47 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uopx6-0007tb-6f; Tue, 18 Jun 2013 09:03:40 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CD47B1660F;
	Tue, 18 Jun 2013 09:03:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <4795e6f40e7ce62fc4c414e8cbbd2aa777d3fbb0.1371460265.git.trast@inf.ethz.ch>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228161>

Am 6/17/2013 11:18, schrieb Thomas Rast:
> +match_pattern_list () {
> +	arg="$1"
> +	shift
> +	test -z "$*" && return 1
> +	for pat
> +	do
> +		case "$arg" in
> +		$pat)
> +			return 0
> +		esac
> +	done
> +	return 1
> +}

Watch this failing test case:

   GIT_SKIP_TESTS="t950[012]" ./t3006-ls-files-long.sh

'pat' is too short and too sweet to be used as a shell variable name in a
library function. ;)

-- Hannes
