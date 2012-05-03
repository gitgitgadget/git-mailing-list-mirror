From: David Soria Parra <dsp@php.net>
Subject: Re: [PATCH] checkout: squelch "'mode' may be used uninitialized in
 this function" warning
Date: Thu, 3 May 2012 10:59:24 +0000 (UTC)
Message-ID: <slrnjq4p8c.i00.dsp@experimentalworks.net>
References: <1335825567-7831-1-git-send-email-dsp@php.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 13:05:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPtqU-0004Ty-BV
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 13:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab2ECLFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 07:05:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:47646 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab2ECLFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 07:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SPtqJ-0004M0-4y
	for git@vger.kernel.org; Thu, 03 May 2012 13:05:03 +0200
Received: from 217.114.211.68 ([217.114.211.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2012 13:05:03 +0200
Received: from dsp by 217.114.211.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2012 13:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 217.114.211.68
User-Agent: slrn/0.9.9p1 (SunOS)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196895>

Any update on this patch? Is it going to maint?

On 2012-04-30, dsp@php.net <dsp@php.net> wrote:
> From: David Soria Parra <dsp@php.net>
>
> Use a 'fake' initialization for the 'mode' variable to work around a
> GCC warning as in 5a7a367. The necessary condition to initialize 'mode'
> will always be true but cannot be checked by the compiler.
>
> Signed-off-by: David Soria Parra <dsp@php.net>
> ---
>  builtin/checkout.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 84d3eb3..6b8bf31 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -157,7 +157,7 @@ static int checkout_merged(int pos, struct checkout *state)
>  	unsigned char sha1[20];
>  	mmbuffer_t result_buf;
>  	unsigned char threeway[3][20];
> -	unsigned mode;
> +	unsigned mode = mode;
>  
>  	memset(threeway, 0, sizeof(threeway));
>  	while (pos < active_nr) {
