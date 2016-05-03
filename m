From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner
 cases
Date: Tue, 3 May 2016 18:07:04 +0200
Message-ID: <8cd2cf72-6e13-baa0-8bdf-d69293ba661f@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:07:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcrF-0006xm-Ru
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934065AbcECQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:07:24 -0400
Received: from mout.web.de ([212.227.15.14]:57584 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934056AbcECQHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:07:20 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MQvxm-1b5pWp159q-00UK5i; Tue, 03 May 2016 18:07:05
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1462265452-32360-2-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:2l25bqOy9TmdRaAMkPzUVAxNRIBhcOvEynLIEKY6GzWX0LWKqgA
 4N2nK6Q69TeKdIZqCEaNNT+tX3VoSI6XNq2MWTXAmpP1P1zHlv5xAO5zorVLaAxQyDiBBck
 dxsKy69Ai6dLi29Hde3jkEL8v/HIRM+WD033ABVRKUW3H5bdPktFnDhM4IVqhmsttk8jsOT
 kKnE4GoxdH/saz87RYBjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XZYsfgMLXy4=:sj+te8e4VQPYfdRIHA17NK
 uU0CqP7PamCw+uQOjqxBruc1kOKQovRiVfZdkQFBrUe7cQ9Cqa7ylMe+lBHrCzB12uMvPg2DS
 zFwQPZKuG7KERRBwp50gZ/79MFVbgDQ5C9LCdm8CpXqQgcYH2jpT/sFBbOvRyYgvQckTG0YEC
 zWRQIMVVHfeGrh6e8arVJ3Fvr8xhbEYAiIRsz0ddjJs1RXyec/P+d+I8wAuvyjdce97HxU+oj
 agV/X/qQDH/Y/4dw2Lhj9PSz/tc57Pmi4gyCDvuu5XDIgsZgHZH2TRIB5kDIWoLDG+QG5BgFZ
 LuLgkA2OWHFDjqmh0x6PEY5PnbTR+qSYlaPm/Mz+mGaU3faJ3kPvVEU82a0CsolqfrZogq67o
 HaMCcoOL+HzQaRo2e6tIgOT2dd1d4DW4Nr4ErMK3yl8/aA0CIPf7tbCE9NTzbn3V8MQybyOfg
 gUqdTW0pBOvIzosBZa1jjICntflzj9yJlB2ljhEySLahC425P9Ivov7I4tnkJkWcCTesE0iWs
 1wKyrNsBltz3I5HlQjEOzUFv+OonP/o/xC64g46vK1Woeci2L/l3p8tMdZ9jkbHQy9+7SDbyF
 uA2VE2xyIOx7EMMJ0cLPMJ+om5R1fzSzUEji/5fi2NGmEnilu4k/c5LTn2ozKr7ADDn7VYy+R
 vlhuVOtBYuV6gxR7JQ3B8a78G7e6wlZxzocbp8NYxP95u64fVmFUGSY/oU1CnWHShzh4hVBDS
 hkrAGOrA3k/pmncAXqF2GlBQiRPccAdgB1ytdc0+Vm1CooypyHAEqQ6p2+Il+x81auJgTHju 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293407>

On 2016-05-03 10.50, Mike Hommey wrote:
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index e5f83bf..1f0133f 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -569,12 +569,27 @@ check_prot_host_port_path () {
>  	test_cmp expected actual
>  }
>  
> -for r in repo re:po re/po
> +test_maybe_fail () {
test_may_fail sounds non-deterministic or so ;-)
how about test_git_and_colon() or similar ?
> +	host=$1; shift
> +	case $host in
> +		git=*)
> +		test_expect_success "$@"
> +		;;
> +		*:*@*)
> +		test_expect_failure "$@"
> +		;;
> +		*)
> +		test_expect_success "$@"
> +		;;
> +	esac
> +}
