From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 09 Nov 2007 08:13:25 +0100
Message-ID: <47340895.6000403@viscovery.net>
References: <11945685673280-git-send-email-dsymonds@gmail.com> <11945685732608-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:13:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqO3l-0001HV-Vy
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 08:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbXKIHNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 02:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXKIHNb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 02:13:31 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58236 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbXKIHNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 02:13:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IqO2z-0005rI-Mf; Fri, 09 Nov 2007 08:12:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3024A6C4; Fri,  9 Nov 2007 08:13:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <11945685732608-git-send-email-dsymonds@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64133>

David Symonds schrieb:
> +test_expect_success 'remove and restore with relative path' '
> +
> +	cd dir1 &&
> +	rm ../file0 &&
> +	git checkout HEAD -- ../file0 &&
> +	test "base" = "$(cat ../file0)" &&
> +	rm ../dir2/file2 &&
> +	git checkout HEAD -- ../dir2/file2 &&
> +	test "bonjour" = "$(cat ../dir2/file2)" &&
> +	rm ../file0 ./file1 &&
> +	git checkout HEAD -- .. &&
> +	test "base" = "$(cat ../file0)" &&
> +	test "hello" = "$(cat file1)" &&
> +	cd -

What if this test fails? Then the rest of the tests run from the wrong 
directory. You should put the test in parenthesis (and drop the cd -).

-- Hannes
