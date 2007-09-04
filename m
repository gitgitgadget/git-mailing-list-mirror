From: Russ Brown <pickscrape@gmail.com>
Subject: Re: git-svn and a nested branches folder
Date: Tue, 04 Sep 2007 09:54:04 -0500
Message-ID: <46DD718C.7060908@gmail.com>
References: <46DD6EEA.9010304@gmail.com> <86veaqebf1.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 16:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZnK-0002zq-LT
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbXIDOyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbXIDOyR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:54:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:42365 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbXIDOyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:54:15 -0400
Received: by wr-out-0506.google.com with SMTP id 36so855861wra
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 07:54:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OL+Zza/KgUnOq6FS/Z5jz1iFXgU5ndXuhMfa24pDKtF0cGX4rAjLnxZt3H5CLmhKRrOV8B3qrsLK3majs2ubCLNXBJUHAWWFkZMOTBreSe2kgdSirb9ZdV5CZX0fIA6nao4QLPT/YjtRAK3VDAm3RlIWP3lmzkRFVgq+l9mo6CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tsARFkkoj66Nz92Jxf1vvkUq+xIfgO4Jn39k4djIZy9pY8GKHxzGw424fDRYRN6xeuMIWlBD5DpawzcIj11cMX8zKwXSnI84Zuuo/txZEidKDU1WEoPEnMFUv255ZEbFs2WKdUa6LKAfF616ojQok8NOh4N2xQtzWEL1km30Ddg=
Received: by 10.90.90.3 with SMTP id n3mr5485410agb.1188917654129;
        Tue, 04 Sep 2007 07:54:14 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.164.207.197])
        by mx.google.com with ESMTPS id s30sm5458761elf.2007.09.04.07.54.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 07:54:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <86veaqebf1.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57589>

David Kastrup wrote:
> Russ Brown <pickscrape@gmail.com> writes:
> 
>> I'm having some trouble with using git-svn to fetch a repository, and I
>> think it's because the repository doesn't store branches as a flat list
>> directly under the 'branches' directory.
>>
>> Basically, we have a structure like this:
>>
>> |
>> +-trunk
>> +-tags
>> +-branches
>>   + category-a
>>     + branch-a
>>     + branch-b
>>   + category-b
>>     + branch-c
>>     + branch-d
>>
>> etc. category-a and category-b are simple directories created using svn
>> mkdir. The branches are created using svn cp.
>>
>> It helps us to organise the branches better, but the rationale is
>> besides the point. The problem is that git-svn seems to want to
>> treat category-a and category-b as branches, which isn't right at
>> all. As a result, git-svn seems to skip most (if not all) revisions
>> that occur in these directories and creates a lot of entries in
>> unhandled.log.
> 
> So what did you specify in your .git/config file regarding the svn
> structure?
> 

I specified the 'branches' directory, but that's because earlier in the
life of the repo we did just do the flat branch layout, but decided to
make it more structured once that got unwieldy.

Is it possible to specify more than one folder for the branches option?

-- 

Russ
