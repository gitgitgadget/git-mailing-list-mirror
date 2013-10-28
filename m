From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 18/19] t: add basic bitmap functionality tests
Date: Mon, 28 Oct 2013 23:13:47 +0100
Message-ID: <20131028221347.GA32479@goldbirke>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060438.GP23098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 28 23:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vav4U-0005tQ-FO
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 23:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559Ab3J1WN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 18:13:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:63272 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757527Ab3J1WN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 18:13:58 -0400
Received: from localhost6.localdomain6 (f052035231.adsl.alicedsl.de [78.52.35.231])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MZDuG-1VFxu32Jrw-00Kzmm; Mon, 28 Oct 2013 23:13:47 +0100
Content-Disposition: inline
In-Reply-To: <20131025060438.GP23098@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:TU4RrsffPz2qs328gRA+OE6hFde7re9Q9V02wPaGPBB
 nR4C3wZQo1USeowMCK+asRqa8f1WNsXWnaKVezTmc5bwY7KfU8
 DmyQmjG3YKDs9fMSJht27kjAcEym/eWIXRkvAk4WqC7DDUBRqd
 Q5h2Ei/R/07hT0KZG2mGntM0fk5/429HNZHvRr8XcSHDCHKdCW
 AluPJNt0xfVKavMFTm9KX5FJDnwYR/vqs89RoTSvPXzHh3fIM+
 hzwynBsHZkigOcRshNtvf7ZYU+fG/KuFrTa+Dhoe22/W1YxzRr
 g5YQz4H1l4KLsF11Z4Tm+MsoMbQ2uW/lGc3+EkFYRMc/24zsYi
 DXeYyIQcBHz31ge7TYYoKxzgneEdNfUFNgejGbZxF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236872>

On Fri, Oct 25, 2013 at 02:04:38AM -0400, Jeff King wrote:
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> new file mode 100755
> index 0000000..0868725
> --- /dev/null
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -0,0 +1,114 @@
> +#!/bin/sh
> +
> +test_description=3D'exercise basic bitmap functionality'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup repo with moderate-sized history' '
> +	for i in $(test_seq 1 10); do
> +		test_commit $i
> +	done &&
> +	git checkout -b other HEAD~5 &&
> +	for i in `test_seq 1 10`; do
> +		test_commit side-$i
> +	done &&

Sorry, style nitpick: could you rewrite this command substitution
using $() like a few lines above?

> +test_expect_success 'setup further non-bitmapped commits' '
> +	for i in `test_seq 1 10`; do
> +		test_commit further-$i
> +	done
> +'

Likewise.


Best,
G=E1bor
