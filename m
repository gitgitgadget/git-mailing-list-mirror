From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Wed, 25 Nov 2015 11:25:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511251121390.1686@s15462909.onlinehome-server.info>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1XLt-0000BQ-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbbKYKbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:31:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:58499 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbbKYKbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:31:01 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M6O1v-1aH9Vs1I6d-00yRC2;
 Wed, 25 Nov 2015 11:25:51 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nAJk0p3eK4fuGMe1o8KwFrRaqaOcDtec/uJgf2lZuwA9W1bFcwR
 NZggPnKXJ7msSOynqw/UxTVk2TPZ+JSYBS4ZEM0PjpaYg582Bsv28/Wu6SREChi0rsh08DU
 AhX+yD9xNAG8l3qIgP2r2QdWC4Rjh940yF8paYd3oek2FT9o6UeZ312T6iWSaJyoDwqpoLJ
 BZ8wQd8YODDvLX3wukgbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xEqSJCI5UpU=:mWmOGNPSd899JJrFsNUEjP
 Zv8hQzRBcfpuOH6YvWPO0gvIdyUKUw6GXvsduZYky5FH69ws33BhezsXC9U80r43Vi/eG0uyv
 VFRHLt/4oJRJqJGqKtbDA+tvc1jDy0EJvFbxSfG2koaw7TPNi2ltLgpxqFS8NDbnaMyRfd5aj
 47q/YABt9fVwEg4Y9hUu5fOWPKh6hvKDiQ2K5/Sh5MQx/uRWQ8SYM6eRu4Q311LnIefujp4lX
 nE10wdc8ieldn6fAkb0oXwRLafffIQiY/io08UoUcQQ8ck/bvyeh3y3l0sSsva4yU6k55FwiP
 5LeC+8/kzdtBq1j6qtj53Q/FhkbhgTiCbvKMfzvhedB/1+uUuTa2RYQGNCL1mMFtYWQ289O4f
 BZFKA4vQPy+gWNT5//UpyfTxGKz8aUBMwpIJ7FGSnws/spEDpd3/H6MQB6FWb0zztY/aAEX4S
 Clb3U0/bLIt+P+hgwlMMCMbl7rcX3OhRp+NRidV50NMAzLWAnWM3vPMrdknrT5FdzEv+E/YtV
 TpnmW6p45rgsUfDYMamecPqmT5TnZ6deRolZ0QhytprfbCko4BJY7J8Rl7xR8WpLH/MGz3Akt
 RL9o4F3FOwn8m/nCgDAgkuCY4nxNiKVDWvvk0VTnK9xE9c3VJyS8q8n+PPQZAFqlHkAX7L47a
 fHT8mYA3W1YaWN9uC4Ju9Q1o/8cgmxbUu1ibS2lk+nlx2upX/8PnQ7PM9xo7EFcEUhL4gFbig
 P9DMejnDBYqjg+oyfUSvvRFqhvp26KTGsnh/emw/nBUZwklNPer91OD8fuiJULlHhI0DI+SX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281699>

Hi Christian,

On Wed, 25 Nov 2015, Christian Couder wrote:

> diff --git a/config.c b/config.c
> index 248a21a..d720b1f 100644
> --- a/config.c
> +++ b/config.c
> @@ -691,6 +691,13 @@ static int git_default_core_config(const char *var, const char *value)
>  		trust_ctime = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "core.trustmtime")) {
> +		if (!strcasecmp(value, "default") || !strcasecmp(value, "check"))
> +			trust_mtime = -1;
> +		else
> +			trust_mtime = git_config_maybe_bool(var, value);

If `core.trustmtime` is set to `OMG, never!`, `git_config_maybe_bool()`
will set trust_mtime to -1, i.e. the exact same value as if you had set
the variable to `default` or `check`...

Maybe you want to be a bit stricter here and either test the return value
of `git_config_maybe_bool()` for -1 (and warn in that case), or just
delete the `maybe_`?

Ciao,
Dscho
