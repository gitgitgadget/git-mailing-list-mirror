From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Thu, 18 Aug 2011 09:53:15 -0400 (EDT)
Message-ID: <14776204.81375.1313675595871.JavaMail.root@mail.hq.genarts.com>
References: <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 15:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu37d-0003tr-1v
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 15:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab1HRN6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 09:58:55 -0400
Received: from hq.genarts.com ([173.9.65.1]:52555 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755729Ab1HRN6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 09:58:55 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Aug 2011 09:58:54 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8C4AF15C8007;
	Thu, 18 Aug 2011 09:53:23 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WCqjES44ev3c; Thu, 18 Aug 2011 09:53:16 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1127015C8006;
	Thu, 18 Aug 2011 09:53:16 -0400 (EDT)
In-Reply-To: <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179599>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Conrad Irwin" <conrad.irwin@gmail.com>
> Sent: Wednesday, August 17, 2011 2:41:41 PM
> Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
>
> We should be giving these warning messages immediately after creating
> potentially problematic refs, i.e. just after "git branch v1.0.0" and
> "git checkout -b v1.0.0". The user experience should look like this
> instead:
> 
> $ git branch v1.0.0
> warning: refname 'v1.0.0' is ambiguous.
> advice: you may want to rename it to an unambigous name with
> advice: git branch -m v1.0.0 v1.0.0-branch
> $ git branch -m v1.0.0 v1.0.0-branch ;# thanks for an advice
> 
> $ git checkout -b v1.0.0
> warning: refname 'v1.0.0' is ambiguous.
> advice: you may want to rename it to an unambigous name with
> advice: git branch -m v1.0.0-branch-2
> $ git branch -m v1.0.0-branch-2 ;# thanks for an advice

Should case insensitive matches be added to the tests?  This morning I discovered coworkers working on branches foo and Foo thinking they were on the same branch...  Rather trivial to clean up, but certainly caused some confusion in the office.

Thanks,
Stephen
