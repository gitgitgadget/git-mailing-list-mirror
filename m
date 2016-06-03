From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 3 Jun 2016 23:31:51 +0200
Message-ID: <5751F747.1070700@kdbg.org>
References: <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160603123226.4687-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:32:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8whR-0006C7-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbcFCVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:32:06 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:49993 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932861AbcFCVby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 17:31:54 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rLy3C64fPz5tlG;
	Fri,  3 Jun 2016 23:31:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3DA5852A6;
	Fri,  3 Jun 2016 23:31:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160603123226.4687-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296412>

Am 03.06.2016 um 14:32 schrieb William Duclot:
> CSS is widely used, motivating it being included as a built-in pattern.
>
> It must be noted that the word_regex for CSS (i.e. the regex defining
> what is a word in the language) does not consider '.' and '#' characters
> (in CSS selectors) to be part of the word. This behavior is documented
> by the test t/t4018/css-rule.
> The logic behind this behavior is the following: identifiers in CSS
> selectors are identifiers in a HTML/XML document. Therefore, the '.'/'#'
> character are not part of the identifier, but an indicator of the nature
> of the identifier in HTML/XML (class or id). Diffing ".class1" and
> ".class2" must show that the class name is changed, but we still are
> selecting a class.
>
> Logic behind the "pattern" regex is:
>      1. reject lines ending with a colon/semicolon (properties)
>      2. if a line begins with a name in column 1, pick the whole line
>
> Credits to Johannes Sixt (j6t@kdbg.org) for the pattern regex and most
> of the tests.
>
> Signed-off-by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
> Changes since V3:
>      - Add a few tests
>      - Remove a redondant test
>      - Handle trailing spaces
>      - Reword in doc
>      - Improvement of the pattern regex

Thanks, I think we can take this version.

-- Hannes
