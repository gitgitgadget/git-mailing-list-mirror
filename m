From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Allow to override mergetool.prompt with $GIT_MERGETOOL*_PROMPT
Date: Wed, 20 Jan 2010 16:59:44 +0100
Message-ID: <4B572870.6090001@viscovery.net>
References: <4B572192.2020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 16:59:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXcyG-0004MD-L6
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 16:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab0ATP7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647Ab0ATP7s
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 10:59:48 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63926 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751335Ab0ATP7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 10:59:47 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXcy9-0001Xu-ER; Wed, 20 Jan 2010 16:59:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 268B31660F;
	Wed, 20 Jan 2010 16:59:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B572192.2020606@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137554>

Sebastian Schuberth schrieb:
> +should_prompt_merge () {
> +	local prompt=$(git config --bool mergetool.prompt || echo true)

'local' is not portable. (The next patch shouldn't introduce it, either.)

> -prompt=$(git config --bool mergetool.prompt || echo true)
> +should_prompt_merge
> +prompt=$?

Previously, prompt was either "true" or "false", but now it is a number.
This is not what the user (function merge_file) expects.

-- Hannes
