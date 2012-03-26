From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 16:53:02 -0500
Message-ID: <4F70E53E.6060608@gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org> <7vvclvrrad.fsf@alter.siamese.dyndns.org> <20120324165536.GA17932@neilslaptop.think-freely.org> <7v1uofqoa7.fsf@alter.siamese.dyndns.org> <20120326172028.GB12843@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:53:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHqh-0008BY-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab2CZVxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 17:53:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48313 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364Ab2CZVxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 17:53:05 -0400
Received: by yhmm54 with SMTP id m54so4234702yhm.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pzdbrCxwCYJ79FAMZAanUlqEzrHg4MpemBLq34rJJU0=;
        b=V7ijbIPGJrNX3Vs5Hp/14fEEy2c8q9VbJLi8mMZ72YuysNnR4nbHL/5h+G5JwoTyAJ
         Csu9cLtsRW07RHgxiPttgjvYxSlEqKcwnb5OJ1Ltz5H0USN+KxYQMoObakRQ3d9XBhce
         jDMr3tDInow+/UNXEAft7Mx1jzGInO1GIx9PFIQva6WxYcMzIUmWk2X/ieb624yJ/WCl
         po7UzQ+/lC1A67xkhYHDAwWdJOpULnu5azSQk4QehxbZXOdafwGXjNsw1DU8oqAbioto
         kyAh9LSgO3jY13U9B8N2BFkzwS6FN0sIt9H9PXG7zyey10Xqqs17qZIDF/FgalecRbLb
         nGvw==
Received: by 10.60.1.7 with SMTP id 7mr29175372oei.71.1332798784667;
        Mon, 26 Mar 2012 14:53:04 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id w4sm420766oeg.12.2012.03.26.14.53.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 14:53:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120326172028.GB12843@hmsreliant.think-freely.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193982>

On 3/26/2012 12:20 PM, Neil Horman wrote:
> On Mon, Mar 26, 2012 at 10:12:48AM -0700, Junio C Hamano wrote:
>> Neil Horman<nhorman@tuxdriver.com>  writes:
>>
>>> I agree, I think perhaps adding an --allow-empty option to the rebase logic, so
>>> that empty commits (or perhaps just initially empty, as opposed to commits made
>>> empty) would be very beneficial.
>>
>> Yeah, that probably may make sense.
>>
> Ok, cool, I'll have a patch in a few days, thanks!
>
IMO, it seems like --allow-empty is an appropriate patch for git-rebase 
(non-interactive), and that git-rebase -i would need a command like 
"k"eep to distinguish which empty commits are not to be discarded and 
which empty commits are ok to discard automatically.  git-rebase -i 
should allow explicit control on a commit by commit basis as opposed to 
blanket rules like "discard all empty commits" or "keep all empty 
commits" that apply to all commits in the rebase-to-do list based on a 
single cli option.

Maybe this is what you plan on doing.  Maybe there is a better command 
name than "k"eep for this.

v/r,
neal
