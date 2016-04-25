From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 83/83] builtin/am: use apply api in run_apply()
Date: Mon, 25 Apr 2016 17:03:36 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604251701180.2896@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <1461505189-16234-4-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 17:04:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aui3Q-0006yL-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbcDYPD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:03:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:59257 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459AbcDYPD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:03:58 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lg0sd-1bVvYV2tOV-00pcJj; Mon, 25 Apr 2016 17:03:40
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1461505189-16234-4-git-send-email-chriscool@tuxfamily.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:tcL/xyJfWepxeLe1zU85Bu/E6eL2M2Se8GaUUg5av+vF7Z5N1FL
 hLS0aq3ThF2Z/aeqglnvloamkRz9eJo1DuMGPHYUUtYgZzf5qM8jbV+pxta4kkU/cm/+WmM
 K7AQFRk6nIBGqbssJISP9wVCSuw8K5PeX+m7A1qlijY9IOLdfzL1OO7uHVdyf4DN893eE5n
 HcZ2nIPOxczNlgTvARSJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p8bS2WBOJaw=:9PU0Buks8zvXxXAgiGo59x
 E3OUvKxi+8A+X8Fb1wxkUiwERI4VZS0oG4wHrCGuLMt6kaLPa+JwNx9yEnXx6GAOIvfp+yGv+
 Eq7sAzGRgNS04qVmamIp6j4yl9RZlkLBcz+6wSbP2B6KYo1xdHz1d+QNnVieY/mZgA22tfq4G
 B6W64x6VC0XIAfFwDzJEvIsOXy0WaQ4xbi+Cr5kZypnIxDMS/1NI1NSJFKzLym5SUWPiIGutM
 O00R/6J+TRkdY5l3z/9ZfGvgo6DTnaNh1JlaXnUsNU7UGUv8Ya/egiAc1a7CbH7zTZdv3CGFZ
 St1MdtzjDgc90N1E6D+nFErCEsdD4VZZOJhOqToe3XCc8+bnZvnYCMPmFZc1lSIZoKgM3KaoM
 3P+s/aXEuQoIAKYvR6H22O4w7BGrInZLHLVTV8WWE3KtBca0uf3imyYHDQMZ2/EoO5h6IrkcI
 j4pEqj/cYgxJ8lKshUA6qC2a1fZVAs2n00MhH8bSI8A92Nn4Bu5dVwZKXwmDo8cg8Q+kc/Tbz
 zD0styl4Ky7PXyF8qIF5e2ypOaHoDBgKpQW8f5axnqs/dU7To03akVjZI/7aGgwm1bPSwCkSX
 Si8g5Ga1laFN6Byh/1rDxOPxuOHDNMgQmHXovTfalrYl85Bvp2+hHn+2nw1/kY7CORRu4Fi/S
 72W7LWVwao29myRUmMy/lgkmOhx5rlUJ5stadk7h7Rp9NQit8QOjCKftiUJ5mbCr/kjYi3yl0
 uoP+IfRVgrnGg5wCcv/x/GfVr2DcDGxnXmA+SB8fYdmPz8xqlXPIEwCC7XSZnU/OtEqaErkm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292487>

Hi Chris,

On Sun, 24 Apr 2016, Christian Couder wrote:

> [...]
>  	/*
>  	 * If we are allowed to fall back on 3-way merge, don't give false
>  	 * errors during the initial attempt.
>  	 */
> +
>  	if (state->threeway && !index_file) {
> -		cp.no_stdout = 1;
> -		cp.no_stderr = 1;
> +		save_stdout_fd = dup(1);
> +		dup_devnull(1);
> +		save_stderr_fd = dup(2);
> +		dup_devnull(2);

I wonder. It should be possible to teach the apply function to be quiet by
default, yes? That would be more elegant than dup()ing back and forth.

Ciao,
Dscho
