From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Git super slow on Windows 7
Date: Wed, 25 Nov 2015 19:42:13 +0100
Message-ID: <0B47434E-00FE-463A-95F1-1F10537C9F7A@gmail.com>
References: <EEA07A84-26D8-4709-97AC-2C4F3A0CC5BD@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: GIT Mailing-list <git@vger.kernel.org>, stephan.arens@autodesk.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:42:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1f1K-0000Qv-Bv
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 19:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbbKYSmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 13:42:20 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33605 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbbKYSmR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 13:42:17 -0500
Received: by wmec201 with SMTP id c201so269676608wme.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NRSpNKYnWUkH2IYqA84cWQYMFgo2a3lNsKbijeBW08o=;
        b=WcBO8hsNekgq/9zFjK1jt8bx5gCH+iv8+IkL4xKCuILlY2QxLOTsKAZ7+gUB+N0FAq
         GPpt5L7ympu2IwQ15VUrA0VlXLo3uytoR2GS1+nqSQDU0/2YqGFtQGP3eFqN+e4uJduy
         nvZM9ToIf75ZSgXfG3xqsLokPDiysz0Is0fCAEZjFRHz45RngI3bUddugJaZvMk4J3yz
         Go84dsJztNOvAWRSeo9PyTQrB5r+GZ9svb3iwC/HiRYr2XbEBZP6QygWnrUuE7aw3Z6x
         hwQwidYqcTeSEnH8dMDbi7P5awMMmaP06N8z+Mk7LfJE2bfdA14ChuG+Ts93k38maY7V
         djQA==
X-Received: by 10.194.143.115 with SMTP id sd19mr50394611wjb.94.1448476935712;
        Wed, 25 Nov 2015 10:42:15 -0800 (PST)
Received: from slxbook4.railnet.train ([88.128.80.15])
        by smtp.gmail.com with ESMTPSA id i18sm4753809wmf.6.2015.11.25.10.42.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 10:42:15 -0800 (PST)
In-Reply-To: <EEA07A84-26D8-4709-97AC-2C4F3A0CC5BD@gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281726>

After some investigation I figured that ~50 Submodules are the culprit.
Does anyone have an idea how to speed up Git on Windows while keeping 50 Submodules?

Thanks,
Lars


> On 25 Nov 2015, at 13:35, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> Hi Johannes,
> 
> I am working with Git for Windows right now and it is dramatically slower than on OS X.
> I executed "time git status" on Windows and OS X with the same repository and the following results:
> 
> ## Windows git version 2.6.3.windows.1 (with enabled experimental flag on install):
> real    0m1.327s
> user    0m0.000s
> sys     0m0.015s
> 
> 
> ## OS X git version 2.4.9 (Apple Git-60):
> git status  0.06s user 0.13s system 102% cpu 0.186 total
> 
> 
> Initially it was even slower on Windows (~1.6s). According to [1] I used the following settings to make it faster:
> $ git config --global core.preloadindex true
> $ git config --global core.fscache true
> 
> Is this behavior normal/expected?
> If it is not normal, how would you debug the issue? How can I find out why it is so slow?
> 
> My user drive is not on a net share and the machine has a SSD.
> 
> Thanks,
> Lars
> 
> 
> [1] http://stackoverflow.com/questions/4485059/git-bash-is-extremely-slow-in-windows-7-x64
