From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 12:19:03 -0400
Message-ID: <CA5A92BB-29E5-40C0-BA9A-ED076676D8BF@silverinsanity.com>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com> <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com> <49F025E7.7090404@drmicha.warpmail.net> <7vocunwz1n.fsf@gitster.siamese.dyndns.org> <49F02FC0.1010007@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 18:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx1fL-0003Yk-KC
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 18:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbZDWQTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 12:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754552AbZDWQTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 12:19:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33879 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbZDWQTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 12:19:08 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 615791FFC15A; Thu, 23 Apr 2009 16:19:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 53A781FFC142;
	Thu, 23 Apr 2009 16:19:00 +0000 (UTC)
In-Reply-To: <49F02FC0.1010007@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117346>


On Apr 23, 2009, at 5:07 AM, Michael J Gruber wrote:

> Junio C Hamano venit, vidit, dixit 23.04.2009 10:32:
>> Use "GIT_EDITOR=:" instead.  It also is *true* just like /bin/true,
>> but git knows a simple magic about this and avoids an extra
>> fork+exec.
>
> Good to know!
>
>> A similar trick exists for GIT_PAGER=cat (not "/bin/cat"), by the
>> way.
>>
>
> So, GIT_PAGER=cat differs from GIT_PAGER=/bin/cat even when `which
> cat`==/bin/cat?

Yes, if $GIT_PAGER == "cat", then git won't launch a pager at all.  If  
$GIT_PAGER == "/bin/cat", then git will launch /bin/cat and pipe all  
of it's output through it.  The result is (assuming a functional /bin/ 
cat) identical, but "cat" avoids the extra memory usage of "/bin/cat".

~~ Brian
