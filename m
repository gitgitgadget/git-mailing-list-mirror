From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: perl/Git.pm: Writing a test suite
Date: Fri, 30 May 2008 15:44:11 +0200
Message-ID: <484004AB.40008@gmail.com>
References: <483FB034.3050507@gmail.com> <20080530100306.GF18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 15:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24uq-00055N-QS
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYE3NoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYE3NoR
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:44:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:65234 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbYE3NoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 09:44:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so125883fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=b+RBwjcD1XGKOT0MhFSrykyPqN0X7PqubK7cugD2LJw=;
        b=HrjbwxMtc62DcyMot0oDys13zkH5R3S2FFL/U0gCABTNKEoyJFF7BPCZF5zS6GJBp/GPJLQSJpsM13D5Go175euNMEaea6c/sGaKSPfe3qZ1mCYRwciZg0bWcAaXWLfJl5sguCqzG9T9UIwLk5i0TumCj/T1fp5qx2QFiSd4o8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Tt7BtuowCvBUFTzU0sVJZegYlQAKHwUDQUDFsd5DsBGsJ+61Q5i4kUj1ldcAT/PlgrLxcjQ9bwDDHHOCZDiM8y4oUdUwZ6RSZq9zBMdtrRwtwxqY3x7IqmoZdY2VNDJzMjF+sxqWl8oUbSsvJYH1XnZSYG0Voe3rZjxjC9COFMA=
Received: by 10.86.68.20 with SMTP id q20mr3796594fga.2.1212155051340;
        Fri, 30 May 2008 06:44:11 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.225.53])
        by mx.google.com with ESMTPS id b17sm1530825fka.6.2008.05.30.06.44.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 06:44:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080530100306.GF18781@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83302>

Petr Baudis wrote:
> Lea Wiemann wrote:
>> it would seem sensible to me to create mock output for the external calls
> 
>  I think this is bad idea; you should test not just Git.pm
> functionality, but equally importantly also its integration with
> (current version of) Git.

Good point.  So I'll work on test repositories with real calls to Git 
where possible.

>   There are two possible ways, either using the Git test suite
> infrastructure, or the Perl test suite infrastructure.

I'd definitely want to use Perl's testing infrastructure, but probably 
it's sensible to use both Git's and Perl's infrastructure (e.g. call the 
Git.pm perl tests from the Git test suite shell scripts, and maybe have 
setup code in the shell scripts).  Here are two questions:

1. Is it OK for the Git.pm tests to be called from the Git test scripts 
but generate different-looking output (since the tests are run in Perl)?

2. I might need external test helpers from CPAN at some point.  Is that 
a bad idea because of dependencies, or are we OK with having additional 
dependencies for running the test suite if necessary?

-- Lea
