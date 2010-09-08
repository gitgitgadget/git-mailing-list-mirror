From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Why does git-svn redownload revisions?
Date: Wed, 8 Sep 2010 19:50:44 -0400
Message-ID: <1C149599-1AC6-464F-9FE0-298D224E9B49@silverinsanity.com>
References: <loom.20100908T181056-819@post.gmane.org> <B1E94440-DDCA-4C10-A0EE-E08A66DF3D7E@silverinsanity.com> <AANLkTinOTgB7HkeVdB-+ttvVMT1HFg91nt6pdD6Y_uML@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Daniel Trebbien <dtrebbien@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 01:50:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtUPl-0007FH-VO
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab0IHXut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 19:50:49 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38799 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab0IHXus convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 19:50:48 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id D27B21FFC32E; Wed,  8 Sep 2010 23:50:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 81DF31FFC32C;
	Wed,  8 Sep 2010 23:50:37 +0000 (UTC)
In-Reply-To: <AANLkTinOTgB7HkeVdB-+ttvVMT1HFg91nt6pdD6Y_uML@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155825>


On Sep 8, 2010, at 6:36 PM, Daniel Trebbien wrote:

>> Or you can downloading both trunk and nano as separate branches.  I think it fetches each revision twice, but it will prevent it from downloading the entire history for each subdirectory branch.
>> 
>>        fetch = trunk:refs/remotes/trunk
>> +       fetch = trunk/nano:refs/remotes/nano
>> 
>> This will make your history look a little odd since trunk will have every commit that nano does but be a completely separate branch.  (It also seems to confuse `git-svn find-rev`.)

> Looking through the Nano repository, it appears that early tags were
> copies of the entire trunk, but later tags (`nano_2_0_8` and onward)
> were copies of just `trunk/nano`.
> 
> Is there a way that I can inform git-svn that tags `nano_2_0_8`,
> `nano_2_0_9`, ... should all be based off of `remotes/trunk/nano`?

git-svn will automatically determine that it's branched off of trunk/nano, but will only save the commits for trunk/nano if you create a branch for it.  That's I think adding a fetch line for trunk/nano as the lesser of two evils.

~~ Brian
