From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3] Disallow empty section and variable names
Date: Mon, 31 Jan 2011 17:48:39 +0100
Message-ID: <4D46E7E7.4010805@web.de>
References: <20110108144644.GA11019@localhost.suse.cz> <20110127145253.GD6312@fm.suse.cz> <20110130203445.GA9689@fm.suse.cz> <4D46694F.5070208@viscovery.net> <20110131091728.GB24297@fm.suse.cz> <4D468109.8020409@viscovery.net> <20110131130855.GC24297@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 31 17:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjwvp-00059g-TF
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 17:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab1AaQsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 11:48:43 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:50376 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab1AaQsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 11:48:43 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id BE3F518698033;
	Mon, 31 Jan 2011 17:48:41 +0100 (CET)
Received: from [93.240.120.190] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pjwvh-0003mg-00; Mon, 31 Jan 2011 17:48:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110131130855.GC24297@fm.suse.cz>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX198exwi6TzJFNYkLlqT/juQ5Uxg3oFZLWq0RleE
	dhpz+kApOl3aiyVRZ0t+QjKt8QSnvnhlDKpl8AUbPIJWCLl/aD
	zhtL/HdCLHsmTJY0wyEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165733>

Am 31.01.2011 14:08, schrieb Libor Pechacek:
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 884a5e5..7106c6c 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -124,7 +124,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
>  	(
>  		cd downstream &&
>  		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
> -		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
> +		git config -f .gitmodules --unset submodule.submodule.fetchRecurseSubmodules true &&

This is not quite the right fix (notice the extra "true" value
at the end). IMHO this should be fixed separately, patch coming.
