From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: chrooting git daemon?
Date: Thu, 11 Jun 2009 23:27:08 +0200
Message-ID: <37C1FAEE-FCE3-4A38-AC89-0AAF3B1174DF@gmail.com>
References: <200906111530.31160.janklodvan@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Klod <janklodvan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 23:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MErnt-0002ct-7h
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 23:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbZFKV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbZFKV1L
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 17:27:11 -0400
Received: from ey-out-1920.google.com ([74.125.78.146]:23237 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbZFKV1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 17:27:10 -0400
Received: by ey-out-1920.google.com with SMTP id 3so206795eyh.26
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=M+G/LEWyrE5UXz2ca7OEVjfffv+hMlupIVVKel22fQE=;
        b=epv0v+rSNkkodLgQYIwgzvoUm4v3ulh7YL8AifRRYOIBs640Goaj1CFYxoDI0V+hni
         KyUJ5+CrQS6GRQThnWnivoTaJS8i66vLr2FidAsIJ5yPzDcpqH0PUEbVm9Yb0Y38F5uo
         iQU48ylcWP0o6CSwO2yz0vFE7zKTQlFJUo+RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=XKro//gnW0ptduxxWuWmxEgFHcM3eKGU5uLcGXGn3uZ3MKOkswWSzmz1t8vnGHNN/l
         Kv2d9mmtfmstanr7YaSQ8bGsqpFLW6ztdKWP423eYSXf1M/8lc8bzVxWOLxNi0QE4qCD
         1YPOcd0OeKFRky1IqScfFEQQ9WggkF685xFSQ=
Received: by 10.210.44.12 with SMTP id r12mr118322ebr.92.1244755631926;
        Thu, 11 Jun 2009 14:27:11 -0700 (PDT)
Received: from ?192.168.1.103? (90-228-223-91-no119.tbcn.telia.com [90.228.223.91])
        by mx.google.com with ESMTPS id 28sm119702eyg.14.2009.06.11.14.27.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 14:27:11 -0700 (PDT)
In-Reply-To: <200906111530.31160.janklodvan@gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121363>

11 jun 2009 kl. 17.30 skrev Jan Klod:

> Hello,
> please, is that hard / complicated to run git daemon in chroot and  
> what are
> the steps to do it best?
> Do you consider it useless precaution there?

You do know that chroot is not a security tool, right? If you do want  
security measures, I'd suggest setting up SSH accounts with the login  
shell set to git-shell. The main difference is that you can have any  
number of trees served from the same machine without handling them all  
by the same service instance. If you wanted to accomplish the same  
with git-daemon, you'd have to let all of them listen to different  
ports. At least that's how I understand it.

BR / Klas
