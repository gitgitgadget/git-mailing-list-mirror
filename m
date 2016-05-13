From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] Add a perf test for rebase -i
Date: Fri, 13 May 2016 15:16:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605131515410.4092@virtualbox>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <cover.1462955446.git.johannes.schindelin@gmx.de> <96acc54c20962376d5438f8d9613dc9c8a6d5d1c.1462955446.git.johannes.schindelin@gmx.de> <xmqqr3d8jnvo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 15:17:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Cxh-00063K-4E
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbcEMNQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:16:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:58312 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbcEMNQz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:16:55 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0gcI-1btSTW3GZi-00uslf; Fri, 13 May 2016 15:16:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqr3d8jnvo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4fWLvp5WzYuo8F3c/dzvqQBFYp6o4MjDFDMVbM3YCUJuQd6SFS8
 a5C8v/rPA9gC2t3hftSsmkm6QkrWsSV6p3b2WpVAQrNafNj9wZ4IWPAEjNpjoP9KioIKdtD
 ynt+j8vIuebZ3sSoD7suGxADNeISZVKLW+yAjI+eYuFt9mgoxRIgQoydUtgRmbyn9VLqafb
 TvXwVFsOIYt1IIMLyxTKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/oSMwAAfry0=:inclK/JVKV5uLF57jzxwjt
 7EC6bglgHk1ltX6rrQcglkjOg/Wg0fda8VLxeR1dtVCBjRZtMxxLbGmDsIFPHUs9nph0m+7n3
 X5pIrEJXk1spMCxeMOaaRU8cLvF79Bkc6sFO8bOv3cL0WwUgrLSr5Atg/NRbysmdUUJ/ZTeL+
 fFkrAlDH9dy1XusQcrnJh3KSsuO9D1iNjB6zJr+XVU3u1Qt0b2+KTm+Nyk+MaAhcehadXcCT5
 gKE9mptLBXw+/m8BFl9An3/AlqAONLJ9S78ujnM0rf7E9WNtiitqebBg1Na2MVye2CxLQSf1n
 0Rm1v3Tj59kpJb8O3W+3V3Bf9dqaleT/wRu8Elsfl5IMdKrXu1wVcaumPZ/CGmkfzO4qr5bDt
 Tl6td0uuaIurPWJanmgbcG+YZdc3qugKy/an5ebKf2/+iPvm5zbNOa/8xuhGcLE+YamctIN2v
 zH5uj5BWATwofqsCfWjGMght08YUm/zaSmqMDZkednd+0cTaT1ezsI1SMg9eah4F60Ex1wx8n
 wbgdQc3RK1JLwObkI+Zofqz8+YWpVDcXouQzt5jYGcxFloF5babjMtXerAYqhngcJk31/Ib1s
 TWxjNAVmtBpSY5mu20cUM3jXUyMj5K7XIKW4am0u/5GHAZ2jT0SGZ8KVp0KFxc3T3vHl0F5Hb
 e+gvL0oj0BDt6JYc1zvPDIDTPCx5RRADGTh/PjNBkxYRrRwDEwBtPBYou3+tNJRpvd9e57eGu
 g5KvdBNt0Ew/+OOxGs01sTKafYiBQWg55dr+b4Xr/FKVekSoapYSJ9wqC4tJV7bMNKqtzSQx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294532>

Hi Junio,

On Wed, 11 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
> > new file mode 100755
> > index 0000000..382163c
> > --- /dev/null
> > +++ b/t/perf/p3404-rebase-interactive.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/sh
> > +
> > +test_description='Tests rebase -i performance'
> > +. ./perf-lib.sh
> > +
> > +test_perf_default_repo
> > +
> > +# This commit merges a sufficiently long topic branch for reasonable
> > +# performance testing
> > +branch_merge=ba5312d
> > +export branch_merge
> 
> t/perf/README mentions the possibility to use your own repository as
> a test data via GIT_PERF_REPO, but doing so would obviously break
> this test.

Right.

> I wonder if there is a way to say "running this perf script with
> custom GIT_PERF_REPO is not supported" and error out.  That may
> help other existing tests that (incorrectly) assume that their test
> data is this project (if there is any).

Good point. I will change it so that the test is skipped if that commit is
not found.

Ciao,
Dscho
