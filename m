From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 13/27] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sat, 01 Mar 2014 16:50:44 +0100
Message-ID: <531201D4.6090900@web.de>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com> <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 16:51:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJmBr-0008QU-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 16:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbaCAPuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 10:50:52 -0500
Received: from mout.web.de ([212.227.15.3]:51239 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbaCAPur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 10:50:47 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MBCYn-1WTzKi2Fzp-00AIDW for <git@vger.kernel.org>;
 Sat, 01 Mar 2014 16:50:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393675983-3232-14-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:EX9jiszwgyLARlYvv12cYnJN5M/dSMKiNS3w0EX9K1JVzjtk8to
 QHgsY0uUZs6wu0GukkvZh75e8L816iwYDRyCy7GDlalTR6JNDSgj++WtuCmPot8EJTeUm0h
 nm1mKI39D7wiJlfuyrVALTl2+RNzqq4ymTZZn2Hge++MIOMGniZYMHj99GLsNEGc8icFQ3U
 62BVUKvYZyrrRsfme/k9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243102>

On 2014-03-01 13.12, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  git-stash.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/git-stash.sh b/git-stash.sh
> index ae7d16e..12d9b37 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -183,7 +183,7 @@ store_stash () {
>  	fi
> =20
>  	# Make sure the reflog for stash is kept.
> -	: >>"$GIT_DIR/logs/$ref_stash"
> +	: >>"`git rev-parse --git-path logs/$ref_stash`"
            "$(git rev-parse --git-path logs/$ref_stash)"
Shouldn't we prefer $() over `` ?
