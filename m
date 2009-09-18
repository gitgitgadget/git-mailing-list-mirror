From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Add compiled date to git --version output?
Date: Fri, 18 Sep 2009 00:43:47 -0400
Message-ID: <F73940A6-02F5-48EE-BD11-FCEC5B21B054@gernhardtsoftware.com>
References: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 06:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoVKd-0003AO-Lr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 06:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbZIREns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 00:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbZIREns
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 00:43:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47431 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZIREnr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 00:43:47 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 190611FFC08E; Fri, 18 Sep 2009 04:43:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id F396E1FFC08B;
	Fri, 18 Sep 2009 04:43:38 +0000 (UTC)
In-Reply-To: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128782>


On Sep 18, 2009, at 12:17 AM, Nazri Ramliy wrote:

> +       printf("git version %s compiled %s %s\n",
> +                       git_version_string,
> +                       __DATE__,
> +                       __TIME__);

> Thoughts?

Any idea how compatible that is?  Sure, it'll work with GCC's cpp, but  
we try to work with a huge variety of compilers.

At the very least you might want to wrap it all in #ifdefs or something:

#if defined(__DATE__) && defined(__TIME__)
/* your version */
#else
/* old version */
#endif

(Or play fun tricks with #ifndef ... #define, but then you also have  
to play with the format string or something.)

~~Brian
