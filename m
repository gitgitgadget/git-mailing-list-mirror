From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: Searching explanation of different diff algorithms
Date: Wed, 25 Sep 2013 10:55:57 +0200
Message-ID: <20130925085557.GA11402@domone.kolej.mff.cuni.cz>
References: <201309250924.15741.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Sep 25 11:03:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOl0U-00025D-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 11:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3IYJDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 05:03:34 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:56368 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab3IYJDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 05:03:33 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2013 05:03:33 EDT
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 2D5A350429;
	Wed, 25 Sep 2013 10:55:58 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id E3F975F822; Wed, 25 Sep 2013 10:55:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201309250924.15741.thomas@koch.ro>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235338>

On Wed, Sep 25, 2013 at 09:24:15AM +0200, Thomas Koch wrote:
> Is there any explanation available of the different merrits and drawbacks of 
> the diff algorithms that Git supports?
> 
> I'm not satisfied with the default diff but have enough processing power for a 
> slower algorithm that might produce diffs that better show the intention of the 
> edit.
> 
It is not just question of algorithm, even definition how should most
readable diff look like is problematic, for example when large block is
rewritten and one line is unchanged then you get diff like

if (x){
- foo
+ bar
} else {
- foo
+ bar
}

but it is better to create following diff as it does not break flow of code.

if (x) {
- foo
-} else {
- foo
+ bar
+} else {
+ bar
}
