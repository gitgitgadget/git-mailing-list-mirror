From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Tue, 19 Aug 2008 16:57:02 +0200
Message-ID: <48AADF3E.40304@viscovery.net>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com> <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Aug 19 16:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSew-0002sq-Oz
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYHSO5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbYHSO5F
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:57:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18982 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYHSO5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:57:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KVSdr-0002IA-9S; Tue, 19 Aug 2008 16:57:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 14FF64FB; Tue, 19 Aug 2008 16:57:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48AADDBB.1080203@viscovery.net>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92872>

Johannes Sixt schrieb:
> Nguyen Thai Ngoc Duy schrieb:
>> +	if (argc == 2 && !strcmp(argv[1], "--show-strategies")) {
>> +		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
>> +			printf("%s\n", all_strategy[i].name);
>> +		return 0;
> 
> Improved error checking, but quick and dirty:
> 
> +	if (!strcmp(argv[1], "--show-strategies")) {

Oops, not really improved. This still needs to check for argc >= 2.

> +		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
> +			printf("%s\n", all_strategy[i].name);
> +		return argc == 2 ? 0 :
> +			 error("--show-strategies does not take "
> +				"any arguments");

-- Hannes
