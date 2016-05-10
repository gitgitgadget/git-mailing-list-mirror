From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Tue, 10 May 2016 07:59:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605100757410.4092@virtualbox>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 07:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b00hv-00044A-RF
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbcEJF7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:59:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:52442 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbcEJF7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:59:43 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MCxfb-1arSGS2pcp-009g6M; Tue, 10 May 2016 07:59:35
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:8pqackrXRN4IKQRvZGEnHYgBXSsKpE3IWkaBCz08gDp6vsnWqa5
 1/phcBS2at5O4/NqQiIsEANuxhf23arTbj+oSZ4iQtNRMzP2nJ6yUY/zP0B2DuNUjhs8g6Q
 3h7aNB28mSdEwzdqvdedM6QN4eoJFeOJyefGZrBctJ4StNPhQW599qj8ivvvXSHtncDa2hr
 fdNuv8sZcTQZz3kgSfdBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eTVQOKtngmY=:JD9huevpTLGxkvecNiFWYQ
 qHDor13X53XUutNgiou7IrGXXZ6pH7gBinz+DShYIITvKFDwioBOUIzGFu3FxafkMVV8dxehm
 swAEWAmTE04MiXyc4M/y2F+Yw0gHGANygPDOm/oq72vL+XxQxhZrHgGKTlUdzkdMp6hLbvmJr
 P2gfHFHZCeY/xM+SNHjmUzvYWV1v+QSeoFeA/CDdIrYVO7JcimUn41OixtKuXWGxnuXy7F1/H
 vdKBnbSqthC8y26X5a+0bH4kobSSACC7DybMu1B/RhAH1BlhD4iAWXKfDwpsRBb/N54cbLTaY
 O2+QwVVQIOiownciRplBSWhcJBGufuIDrmbS0yZLA0QGnnpi+OLVhcEaDqI19MRD/0CNxiJZ8
 Zxuxibatn3aHlRj6NON/rNOIojMBv1QAa4tvXK5yPeCg6xZ8x2PnLMOa3al4sLf02vgEyoboF
 YowK2CvgRwfFjbNczW5MHFx64Hi3SFlODxm+k4z9I4s/kKYMRcORrWwvvFH3UHqOnq5z/rtfJ
 FJHK8A64XCZmjKhlmqt37N1d8s/Zji04pd+objhQYhbYQ5Z8V5Y6b9gdA2e+0Tc/WoGw+kzmR
 BEAZgCqkfpPzL4B0HtAtCIivw7Q2uafnSmoUeiLwaqhYnrPWpj2ChTkTS0W5D0Yzvxc9hp7BZ
 RaURiy9nBab9OryySK+V3ckks8lgu2Ub0CWTSbmSGnJ0oKvinjR95bX8CyTWHTI/A+zwqx1IL
 fT0sM9WonWbx9TC1U8d9HYipJpaDQnRC2LXberjIPPYV6wxM7J0Yo9OQAqCXZDPOjZFOPDC8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294096>

Hi Junio,

On Fri, 6 May 2016, Junio C Hamano wrote:

> * jc/fsck-nul-in-commit (2016-04-14) 2 commits
>  - fsck: detect and warn a commit with embedded NUL
>  - fsck_commit_buffer(): do not special case the last validation
> 
>  "git fsck" learned to catch NUL byte in a commit object as
>  potential error and warn.
> 
>  What was the status of this one?  Ready to proceed?

I think this code looks fine. Maybe two comments on the test:

>               test_must_fail git -c fsck.nulInCommit=error fsck 2>warn.1 &&
>               git fsck 2>warn.2 &&
>               grep nulInCommit warn.2

1) warn.1 is not used. Maybe skip that redirection?

2) I was under the impression that we preferred test_i18ngrep over grep...

Thanks,
Dscho
