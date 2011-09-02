From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Fri, 02 Sep 2011 14:30:15 -0700
Message-ID: <4E614AE7.7090706@vilain.net>
References: <20110902140702.066a4668@robyn.woti.com> <4E612319.7030006@vilain.net> <20110902144922.383ed0f1@robyn.woti.com> <4E6127F5.5070009@vilain.net> <20110902154206.331b80e9@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 23:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzbJf-0007rW-2k
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 23:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab1IBVaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 17:30:17 -0400
Received: from uk.vilain.net ([92.48.122.123]:49101 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995Ab1IBVaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 17:30:16 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 88BDC824C; Fri,  2 Sep 2011 22:30:15 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id 8CA14807A;
	Fri,  2 Sep 2011 22:30:13 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.1) Gecko/20110830 Thunderbird/6.0.1
In-Reply-To: <20110902154206.331b80e9@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180638>

On 9/2/11 12:42 PM, Bryan Jacobs wrote:
> On Fri, 02 Sep 2011 12:01:09 -0700
> Sam Vilain<sam@vilain.net>  wrote:
>
>> That's one way to do it; in fact, if the trees match you don't need
>> to do anything complicated like cherry-pick.
>>
>> ie, say you're committing
>>
>>      r1---A---B---C---D
>>
>> and it blows up at
>>
>>      r1--r2--r3--C---D
>>
>> So long as the tree from the fetched r3 == the tree from B, then you
>> can just go ahead and write out new commits for C and D without doing
>> any merging (ie cherry-pick or rebase).  You could also put merge
>> commits back the way they were, too.
> When you say "write out new commits" you mean create a commit object
> with the same contents, but a different parent? Does git-svn do this
> somewhere already?

I guess it doesn't, but if it did it would certainly make this easier.  
I'm not sure why it would need to modify the WC at all.  Eric, is this 
just historical or is there a better reason for that?

Sam
