From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Add a setting to require a filter to be successful
Date: Fri, 17 Feb 2012 08:08:00 +0100
Message-ID: <4F3DFCD0.6070002@viscovery.net>
References: <7vobsywck1.fsf@alter.siamese.dyndns.org> <4f3daaf7.e302440a.02ba.fffff463@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: jehan@orb.com
X-From: git-owner@vger.kernel.org Fri Feb 17 08:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyHvh-0005RB-3F
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 08:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2BQHII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 02:08:08 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60059 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750814Ab2BQHIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 02:08:06 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RyHvF-00086I-AE; Fri, 17 Feb 2012 08:08:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E569D1660F;
	Fri, 17 Feb 2012 08:08:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4f3daaf7.e302440a.02ba.fffff463@mx.google.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190936>

Am 2/17/2012 2:19, schrieb jehan@orb.com:
> @@ -747,13 +753,19 @@ int convert_to_git(const char *path, const char *src, size_t len,
...
>  	ret |= apply_filter(path, src, len, dst, filter);
> +	if (!ret && required)
> +		die("required filter '%s' failed", ca.drv->name);

Wouldn't it be much more helpful if this were:

	die("%s: clean filter '%s' failed", path, ca.drv->name);

Likewise (with s/clean/smudge/) in convert_to_working_tree_internal().

> +	! git checkout -- test.fs

	test_must_fail git checkout -- test.fs

> +	! git add test.fc

	test_must_fail git add test.fc

-- Hannes
