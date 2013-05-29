From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] completion: zsh: improve bash script loading
Date: Wed, 29 May 2013 08:17:50 +0200
Message-ID: <51A59D8E.1040502@viscovery.net>
References: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 08:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZhw-000170-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759478Ab3E2GR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:17:56 -0400
Received: from so.liwest.at ([212.33.55.13]:15006 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378Ab3E2GRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:17:55 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UhZho-0002vT-0S; Wed, 29 May 2013 08:17:52 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A56301660F;
	Wed, 29 May 2013 08:17:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225751>

Am 5/29/2013 5:24, schrieb Felipe Contreras:
> +if [ -z "$script" ]; then
> +	local -a locations
> +	locations=(
> +		'/etc/bash_completion.d/git' # fedora, old debian
> +		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
> +		'/usr/share/bash-completion/git' # gentoo
> +		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
> +		)

Won't you need

	local e

here, or does it not matter?

> +	for e in $locations; do
> +		test -f $e && script="$e" && break
> +	done
> +fi

-- Hannes
