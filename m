From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v5 3/3] push: teach --recurse-submodules the on-demand
 option
Date: Mon, 26 Mar 2012 23:22:49 +0200
Message-ID: <4F70DE29.6050808@in.waw.pl>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213093008.GD15585@t1405.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:23:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHNW-0006WL-Da
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab2CZVW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 17:22:57 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56321 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327Ab2CZVW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 17:22:57 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SCHNP-0001tT-Ns; Mon, 26 Mar 2012 23:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120213093008.GD15585@t1405.greatnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193979>

On 02/13/2012 10:30 AM, Heiko Voigt wrote:
> When using this option git will search for all submodules that
> have changed in the revisions to be send. It will then try to
> push the currently checked out branch of each submodule.
>
> This helps when a user has finished working on a change which
> involves submodules and just wants to push everything in one go.

> ---recurse-submodules=check::
> -	Check whether all submodule commits used by the revisions to be
> -	pushed are available on a remote tracking branch. Otherwise the
> -	push will be aborted and the command will exit with non-zero status.
> +--recurse-submodules=<check|on-demand>::
> +	Make sure all submodule commits used by the revisions to be
> +	pushed are available on a remote tracking branch. If check is
> +	used it will be checked that all submodule commits that changed
> +	in the revisions to be pushed are available on a remote.
> +	Otherwise the push will be aborted and exit with non-zero
> +	status. If on-demand is used all submodules that changed in the
> +	revisions to be pushed will be pushed. If on-demand was not able
> +	to push all necessary revisions it will also be aborted and exit
> +	with non-zero status.
Hi,
this desciption seems awkward. Not sure how to improve it, but:
- the argument 'check' is changed to '<check|on-demand>', i.e. brackets 
are added. This changes the meaning, because brackets are used around a 
name for a value provided by the user. So here brackets shouldn't be 
used, because 'check' and 'on-demand' are literals.
- s/if check is used it will be checked/if check is used git will verify 
that/
- s/a remote/the remote/
- s/Otherwise the push/If any commits are missing the push/ (because 
'Otherwise' could refer to 'If check is used'.)

Zbyszek
