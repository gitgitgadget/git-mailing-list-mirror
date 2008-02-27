From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: add regression tests
Date: Wed, 27 Feb 2008 09:51:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802270947110.22527@racer.site>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org>
 <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost> <7vprukfttt.fsf@gitster.siamese.dyndns.org> <20080227085442.GA22501@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Feb 27 10:53:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUIyH-0000jj-Je
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 10:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYB0JwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 04:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYB0JwI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 04:52:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:38889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750926AbYB0JwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 04:52:07 -0500
Received: (qmail invoked by alias); 27 Feb 2008 09:52:05 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 27 Feb 2008 10:52:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qyMtcKLnqgM09OlrAiO8bq8nGkGQ/QU6ZsMZpQc
	tz4Hr0rfFf4uMc
X-X-Sender: gene099@racer.site
In-Reply-To: <20080227085442.GA22501@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75219>

Hi,

On Wed, 27 Feb 2008, Clemens Buchacher wrote:

> Networking tests are disabled by default. Use GIT_TEST_OPTS=--network to
> enable.

One request in addition to Mike's: please make this an environment 
variable such as "GIT_TEST_HTTPD".  IOW, instead of this:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 83889c4..e33b13b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -79,8 +79,10 @@ do
>  		verbose=t; shift ;;
>  	-q|--q|--qu|--qui|--quie|--quiet)
>  		quiet=t; shift ;;
> +	-n|--n|--ne|--net|--netw|--netwo|--networ|--network)
> +		network=t; shift ;;
>  	--no-color)
> -	    color=; shift ;;
> +		color=; shift ;;
>  	--no-python)
>  		# noop now...
>  		shift ;;
> @@ -89,6 +91,11 @@ do
>  	esac
>  done
>  
> +if test -n "$network"
> +then
> +	GIT_TEST_NET=t
> +fi
> +
>  if test -n "$color"; then
>  	say_color () {
>  		case "$1" in

just rename the variable "GIT_TEST_NET" in lib-httpd.sh to 
"GIT_TEST_HTTPD".

Thanks,
Dscho
