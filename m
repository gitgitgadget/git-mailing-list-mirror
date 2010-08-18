From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] submodule sync: Update "submodule.<name>.url"
Date: Wed, 18 Aug 2010 12:45:54 +0200
Message-ID: <4C6BB9E2.4060700@viscovery.net>
References: <1282125673-22956-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 12:46:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olg9l-0003Ew-3B
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 12:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab0HRKqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 06:46:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26096 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638Ab0HRKp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 06:45:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Olg9a-00036t-N4; Wed, 18 Aug 2010 12:45:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6CBC81660F;
	Wed, 18 Aug 2010 12:45:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <1282125673-22956-1-git-send-email-davvid@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153828>

Am 8/18/2010 12:01, schrieb David Aguilar:
> @@ -840,9 +840,10 @@ cmd_sync()
>  		then
>  		(
>  			clear_local_git_env
> +			say "Synchronizing submodule url for '$name'"
> +			git config submodule."$name".url "$url"

This git config applies to the super module, right? As such, shouldn't it
happen before you clear_local_git_env?

>  			cd "$path"
>  			remote=$(get_default_remote)
> -			say "Synchronizing submodule url for '$name'"
>  			git config remote."$remote".url "$url"
>  		)

-- Hannes
