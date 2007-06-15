From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pull into dirty working tree
Date: Fri, 15 Jun 2007 15:33:27 +1200
Message-ID: <46a038f90706142033p1b7f5b49uc5b4af72b0419c8e@mail.gmail.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
	 <18033.14520.846510.640130@lisa.zopyra.com>
	 <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
	 <46a038f90706141746n1cb69258r23ba676bbcf7c425@mail.gmail.com>
	 <alpine.LFD.0.98.0706141801030.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2Z0-00063w-NJ
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbXFODd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbXFODd3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:33:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:44103 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbXFODd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:33:28 -0400
Received: by wx-out-0506.google.com with SMTP id t15so747718wxc
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 20:33:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dNIoj2d5C4hruC94yhSjjAMA6pX4vouMqO3COjzfvw5LVx5oyxJM5HBelMX7DNQpChbyeFUXRNUTNxUpWnIyIFgR7X4elbc+CaYgtn9p8+hlk9AAUBEydfjI2iqgz7bT4rnvQafxydx2VZS247KZ07JsAwHfmfhL8UjYTB3227M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sHIOLharqU9E5ewvuAe7jtp1T4W6CAQeIHkOUtaAk0iCXInOHDIhvDNBvqMs49F2CF+lOGI7L7pMJhkej0aMEPEVxjEHCZjo3ZAogwvnVlYtzWJa3IUuTbyem0RFQBcZdAw/hMJluTzXli4rdhA9ShaWQt4z5FoUqSmnSY4oktY=
Received: by 10.90.75.10 with SMTP id x10mr2258996aga.1181878408034;
        Thu, 14 Jun 2007 20:33:28 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Thu, 14 Jun 2007 20:33:27 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706141801030.14121@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50235>

On 6/15/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> But yeah, if you can check in stage 1 (_without_ changing the working
> tree) whether the merge will work, then everything is fine.

Aha- so at phase 1 we know
 - what paths are dirty in the checkout
 - what paths of the merge need an actuall diff3 merge

perhaps we can do those diff3 merges elsewhere (tempfiles). If they
are trivial diff3 merges, then we can complete the merge operation
without touching the checkout. After this is complete, we can then
update the checkout...

cheers,



m
