From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH 3/3] git-apply: add tests for stripping of leading and trailing whitespace
Date: Mon, 17 Sep 2007 16:16:07 +0200
Message-ID: <m3myvlv0m0.fsf@maximus.localdomain>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
	<11899829424173-git-send-email-bfields@citi.umich.edu>
	<1189982942187-git-send-email-bfields@citi.umich.edu>
	<11899829421064-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXHOZ-0002iJ-UT
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 16:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbXIQOQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 10:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbXIQOQK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 10:16:10 -0400
Received: from khc.piap.pl ([195.187.100.11]:36043 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbXIQOQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 10:16:09 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 2DD1F7D835; Mon, 17 Sep 2007 16:16:08 +0200 (CEST)
In-Reply-To: <11899829421064-git-send-email-bfields@citi.umich.edu> (J. Bruce Fields's message of "Sun, 16 Sep 2007 18:49:02 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58448>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> +test_expect_success \
> +	'8 or more consecutive initial spaces' \
> +	'checkstrip 4'

It may be valid, some projects use tabs for indentation and spaces
for alignment, e.g.:

	if (cond && (cond1 ||
	             cond2))
		...

The second line is actually:
	             cond2))
<TAB--->SSSSSSSSSSSSScond2))
where 'S' means space.

This is the only way to write code which display correctly with
different tab sizes.

With tab = 4 spaces it would be expanded to:
    if (cond && (cond1 ||
                 cond2))
        ...
I.e., it would be still fine.


Most of the formating tools probably can't do it automatically.
-- 
Krzysztof Halasa
