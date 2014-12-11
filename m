From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Thu, 11 Dec 2014 16:32:27 +0100
Message-ID: <5489B90B.6070706@web.de>
References: <1418290234-21516-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Christian Hesse <mail@eworm.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 16:32:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz5jK-000088-5n
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 16:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbaLKPce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 10:32:34 -0500
Received: from mout.web.de ([212.227.17.12]:64490 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933278AbaLKPcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 10:32:33 -0500
Received: from birne.local ([78.72.72.190]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M5OUd-1Xkyky2wGd-00zXkx; Thu, 11 Dec 2014 16:32:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1418290234-21516-1-git-send-email-mail@eworm.de>
X-Provags-ID: V03:K0:G4YecnIQIFdvfThKSKhssF0/JCoALBe68A9Re0qhFPvq7AtNeK6
 KgjIEUNhmQ+kGfzys09XNWfk/uj+L04K90BMKLekByY+vxbxbaFmCgXmzdbxCvt7OqfIpqH
 H1unHpWsvtZLmhlFPzxHFUwAe4Qr8R67NlNRZ05ROpiS/klqMRbvMaTaVVRTHifBKv/cFmv
 Q1U9LgosvfkiqGyi6u1jw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261282>

On 11.12.14 10:30, Christian Hesse wrote:
> ---
>  t/lib-gpg.sh   |  6 ++++++
>  t/t7004-tag.sh | 14 +++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index cd2baef..05b07c6 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -22,6 +22,12 @@ else
>  		GNUPGHOME="$(pwd)/gpghome"
>  		export GNUPGHOME
>  		test_set_prereq GPG
> +		case "$gpg_version" in
> +		'gpg (GnuPG) 2.1.'*)
> +			say "Your version of gpg (2.1.x) is missing some legacy features"
> +			test_set_prereq GNUPG21
> +			;;
> +		esac
>  		;;
>  	esac
>  fi
We do not really need the GNUPG21 (and we don't need to touch the TC at all)
		case "$gpg_version" in
		'gpg (GnuPG) 2.1.'*)
			say "Your version of gpg (2.1.x) is missing some legacy features"
			;;
		*)
			test_set_prereq GPG
			;;

		esac
  		;;
