From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 09 Nov 2014 22:42:55 +0100
Message-ID: <545FDFDF.7070102@web.de>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com> <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net> <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com> <545FC8D1.1040803@web.de> <CAO2U3QgpyxqmDWmN7v8W742hNpj-kzhuFEJjO6mZrSRHK9jvoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 22:43:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnaGO-0006DC-9s
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 22:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbaKIVnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 16:43:08 -0500
Received: from mout.web.de ([212.227.15.4]:54542 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbaKIVnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 16:43:07 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LjrU9-1YK9vO1wF7-00bpHD; Sun, 09 Nov 2014 22:42:59
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAO2U3QgpyxqmDWmN7v8W742hNpj-kzhuFEJjO6mZrSRHK9jvoA@mail.gmail.com>
X-Provags-ID: V03:K0:HbrX4hFFC5Ndrv1eNTtzoxfWxW02Qp+VRlo6PSyUDyV5/nTrIRa
 aMALr8k/EWA/41K8REKZCsOvY6rv0ZP2ToMxUuckqMngWazo9JZBai5fwNQ5VzlZN5h571a
 A6FTf/XRggNS3lFDZTy9reFbhS5TT87Mb+zcEMn/1oijx2eEHQgrIwiumYdHTLpGIr0HEWG
 pWmYBysQhu42b9wWfBRNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-09 22.36, Michael Blume wrote:
> Actually I have a build break in pu on my mac right now. Seems to
> build fine in ubuntu, but:
>
> progress.c:66:15: error: use of undeclared identifier 'CLOCK_MONOTONIC'
>         timer_create(CLOCK_MONOTONIC, &sev, &progress_timer);
That is not an unkown issue.
You need to revert one commit (this is my copy of pu from today)

 Revert "use timer_settime() for new platforms"
   
 This reverts commit 0950f08806208b4e3d0aff5f4f7d497637ba4cab.
