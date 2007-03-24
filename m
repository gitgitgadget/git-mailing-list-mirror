From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Sat, 24 Mar 2007 01:03:54 +0100
Message-ID: <200703240103.55258.jnareb@gmail.com>
References: <7v648u38ws.fsf@assigned-by-dhcp.cox.net> <200703231523.58150.jnareb@gmail.com> <20070323153314.GA2364@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Mar 24 01:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUuRR-0007bU-BA
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 01:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992646AbXCXAs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 20:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992648AbXCXAs6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 20:48:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11254 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992646AbXCXAsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 20:48:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1168470uga
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 17:48:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IaBmjCy+eKE5PK/RPaPTi6CilNBIpGLrscCf+71Ckywx4Sbd0XJ7zQyuY/oTEbUUI0U035Ehct16Jssot7nfMfHg6yqBrIMOYKw34IMdtoX8R5/wiIdmWqzEb1e0m2VxxDmQ7DTBZmevfvA0bhdeurA0HrdZFfz3IQtLQ06M5yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pgOteokeZadFYuixADotUtV5DdVDDVh3QBcoGih4Wvq97P0K3cgdiC4qVkjlUN8fsu0Ddfwbb8dttbNrgUjr7rSOFNviIoMdzTvZgjjkYfz4tEikg1n5/RdsCNSGi7S0pOr85NHS3ZmYrKjZIMA+glfq8uDE/b/pGd/4xEjcskk=
Received: by 10.67.92.1 with SMTP id u1mr7608919ugl.1174697333407;
        Fri, 23 Mar 2007 17:48:53 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g8sm9590924muf.2007.03.23.17.48.51;
        Fri, 23 Mar 2007 17:48:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070323153314.GA2364@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42971>

J. Bruce Fields wrote:
> On Fri, Mar 23, 2007 at 03:23:55PM +0100, Jakub Narebski wrote:
>> J. Bruce Fields wrote:
>>> 
>>> The input to git-am is email, not log messages.
>> 
>> But that means that commit message which doesn't have empty line after
>> first line cannot be send via git-send-email + git-am without changes,
>> not be subject to git-rebase (which uses git-am machinery unless invoked
>> with --merge option) without changing commit message, isn't it?
> 
> Yup.
> 
> Doesn't seem like a big deal to me.  But then it'd also seem more
> sensible to me if git-rebase worked directly with the original commits
> rather than going through git-format-patch/git-am.  Maybe what I want is
> a git-cherry-pick that will accept a range.

git-rebase works directly with original commits if you use merge driven
git-rebase, with --merge option (or -s <strategy> option, which implies
--merge), which is present since Jun 21, 2006.

BTW. I do wonder if "git rebase --merge" accepts and honors -C<n> option...

-- 
Jakub Narebski
Poland
