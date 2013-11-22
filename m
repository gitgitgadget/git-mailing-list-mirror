From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v6 05/10] git fetch-pack: Add --diag-url
Date: Fri, 22 Nov 2013 13:56:29 +0100
Message-ID: <20131122125629.GB9273@goldbirke>
References: <201311212140.49698.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 13:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjqHj-0005lE-KD
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 13:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab3KVM4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Nov 2013 07:56:32 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:62996 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3KVM4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 07:56:31 -0500
Received: from localhost6.localdomain6 (g230129235.adsl.alicedsl.de [92.230.129.235])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MUAFy-1W9erH2kiI-00RQ5a; Fri, 22 Nov 2013 13:56:29 +0100
Content-Disposition: inline
In-Reply-To: <201311212140.49698.tboegi@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:zABcBpVa+PKP6kMvKxobkvRvzcPW96E8g3uDOooYHKF
 HQcl0edBkOGUWlqxX3WJ3PhcCeEJIkHXOs63OscjrmHt+p5paN
 9V4MLw7aWpV+JIvZXKvb48Bct2Vl2Hi5d05nVNWYzSso9aWFmE
 ECeh8umkuiABGdwFpGXgTsDBoOKXiyTNoeQcZ7rk4iyLx3x++P
 kcwfI9YBDY3cPC4GoFdtNkBEIl369t+O4F42z0NU+JEACG9SRT
 b01HWcePq3pm+yWj9NpilJ+BeXeqe+OTo59PMYfDvo+tFzmG/p
 Xv5IRaNIq5rjK+xDP+1Tk0kOMVbrjQtqL4SW8jnd+YR2t0TK6x
 MQQ2U3TNORMK89ANkFm4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238182>

Hi,

On Thu, Nov 21, 2013 at 09:40:48PM +0100, Torsten B=F6gershausen wrote:
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d87ddf7..9136f2a 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -531,5 +531,62 @@ test_expect_success 'shallow fetch with tags doe=
s not break the repository' '
>  		git fsck
>  	)
>  '
> +check_prot_path() {
> +	> actual &&

There is no need to truncate actual here, ...

> +	(git fetch-pack --diag-url "$1" 2>&1 1>stdout) | grep -v host=3D >a=
ctual &&

=2E.. because it will be overwritten in this line anyway.

> +	echo "Diag: url=3D$1" >expected &&
> +	echo "Diag: protocol=3D$2" >>expected &&
> +	echo "Diag: path=3D$3" >>expected &&
> +	test_cmp expected actual
> +}
> +
> +check_prot_host_path() {
> +	> actual &&
> +	git fetch-pack --diag-url "$1" 2>actual &&

Likewise.


Best,
G=E1bor
