From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
Date: Wed, 09 Sep 2015 13:45:00 +0200
Organization: gmx
Message-ID: <1da3956b12c7d20fcd90ebffea9c8f68@dscho.org>
References: <0000014fb15e897e-4f1178b9-69d9-4015-808b-e073c134281c-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 13:45:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZdoK-0004Bz-RX
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbbIILpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 07:45:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:59379 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbbIILpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:45:04 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MPlsg-1ZVlvC35nu-0053cs; Wed, 09 Sep 2015 13:45:00
 +0200
In-Reply-To: <0000014fb15e897e-4f1178b9-69d9-4015-808b-e073c134281c-000000@eu-west-1.amazonses.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:cLt468K2uNaZR1Dv0xSlZPRYSll0FvSzYkKIk+L6fuhxxYknY+4
 FfajbowwSc006HN2N8PiqEGEiLukXnQtbGZBXGnte/hJoCIycClfdaczvK4qR8IXZUYnKlM
 SHCF/xktWzmqjM24KjkFHX7HJ6J4U1QQs9TW+2iP9yz1g+iPIfdROnQcxEdXNc98luT27QA
 JAVDLilpr77NHFRI0J25Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:53JcRqbyGlg=:HsHLmty+DV6NuyEN+Hw9qx
 f6XVIh86d09H4rx5cwl/9YxGnN6/7rc/0IkUPgJ3sOc53ZX//jPraG7m5DhOgWzyes5Lz/8hl
 3Pz9MjngMeT6cBBPUKWifsOOaSMe/1Gfmu3H9fEsHAFfy3Si/PVFSmy3edXSZGRJswamXlLay
 jwDkDVfzwL61AyUzBBeMTGQmWVampYRjBbUwTawgZQS+aAqwjGYHH2kM8a99cvWk/WkXB8+lJ
 bMPNGuZezwU9M90GzjaozcfBO4Ff7F0a/11be/drG3x6cfmfk+8DqLMVGbfMHR4dk1ZnNkMD4
 69QQ+/U36JMaeQE/hC/+aoNHD28aJTCmdw8H57ImSptOb/m/J25oY6n86nNTf1xK1W7ci6sCi
 ibIV9HExTyviSAp7eO8nD8x3fK0lOYQCObzKcXzxhB1M0WjkfNbfn7xg0i8fcuPm0xLtYevLG
 ugM9XObeRsHBB5mRHyTDWDbrNcqigYTptLa5KZ/QeNRHHIuKbTvOyMfmlCRC9t/0ktdJLuZiv
 Zn5JbwDDGQ637GLbOx3hC37FWPQ61N68FmQSfNpq4uSZMvNluAh9I2m3nALFfohYePVeGWUoj
 PSX+wmeH63sJPM115CHeVY6TNoVOXy2H3BfM9DR4C8fSOvuQWGlWswoHDaUOXacFTU/eyDC9y
 D61i8ebOj+Y7zH4gSDK8eBg7EBVRnGLKWDVZXGQtPU1ZcFAlKuaIWwf0ayt+r5YPjozWz4zsd
 XuOaSwWrYLh4fiP7Uh4gKjPV9hzdtgtdCQEUKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277546>

Hi Junio,

On 2015-09-09 11:10, Johannes Schindelin wrote:
> This is a backport of the corresponding patch to the builtin am in 2.6:
> 3ecc704 (am --skip/--abort: merge HEAD/ORIG_HEAD tree into index,
> 2015-08-19).
> 
> Reportedly, it can make a huge difference on Windows, in one case a `git
> rebase --skip` took 1m40s without, and 5s with, this patch.
> 
> Reported-and-suggested-by: Kim Gybels <kim.gybels@engilico.com>
> Original report: https://github.com/git-for-windows/git/issues/365
> Acked-by: Paul Tan <pyokagan@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/examples/git-am.sh | 2 +-

Of course this should be `git-am.sh` in the 2.5.x branch... Could you adjust that on your side?

Thanks,
Dscho
