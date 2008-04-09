From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: Test suite failures due to Error.pm issues.
Date: Wed, 9 Apr 2008 10:34:30 +0200
Message-ID: <b77c1dce0804090134j514811d7mbffdc73dee5a90b7@mail.gmail.com>
References: <20080408221853.GA3819@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "carbonated beverage" <ramune@net-ronin.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 10:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjVm1-00029a-Vq
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 10:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbYDIIec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 04:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYDIIec
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 04:34:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:39323 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYDIIeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 04:34:31 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2427781wff.4
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VaELn4k/XmyqgzxCgWGPOsHyFVZD4VpLfFqunz4kbH8=;
        b=ju0luVmyXgQYA9g/olDGrbwRnh78F+6xj7Ovuz8t5X+echda+uettIa1qvz4T1xhj/CZWtjaKvXEtkQt6Wnd2GKpfBbOwVji2V7nyURoB/PA1iq31nVwSPXWbB0Mh3e1MQ19zkKtBPcCrm+pfmQMANsARTltTv3PxLREO7r0pmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vQsGA5ghONnk4TaCz/VbJU+j2sGm91r4gGGmfXPdC5spljixBEhCQlDSApHKj/zcUThBZg26aRIzNifnsCQew7Mzg8hxQc1bQG0RCw6NkNdmrqZS0QzoM1b0zlATYS8COuOlTE70qgvOQbH5xoOLgb1Hr1ZlWJCVn7alcko8T2I=
Received: by 10.142.47.6 with SMTP id u6mr3463008wfu.29.1207730070823;
        Wed, 09 Apr 2008 01:34:30 -0700 (PDT)
Received: by 10.142.156.10 with HTTP; Wed, 9 Apr 2008 01:34:30 -0700 (PDT)
In-Reply-To: <20080408221853.GA3819@net-ronin.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79088>

On 09/04/2008, carbonated beverage <ramune@net-ronin.org> wrote:
> Hi all,
>
>  I was trying to track down the cause of massive test failures in make
>  test, and running the failing entries via -v showed the following popping
>  up over and over again:
>
>  Can't locate Error.pm in @INC (@INC contains: /home/ramune/src/git/git/t/../perl/blib/lib /home/ramune/src/git/git/t/../perl/blib/arch/auto/Git /etc/perl /usr/local/lib/perl/5.8.8 /usr/local/share/perl/5.8.8
>   /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8 /usr/local/lib/site_perl .) at /home/ramune/src/git/git/t/../perl/blib/lib/Git.pm line 93.^
>  BEGIN failed--compilation aborted at /home/ramune/src/git/git/t/../perl/blib/lib/Git.pm line 93.^
>  Compilation failed in require at /home/ramune/src/git/git/t/../git-add--interactive line 5.^
>  BEGIN failed--compilation aborted at /home/ramune/src/git/git/t/../git-add--interactive line 5.^
>
>  Since git has private-Error.pm file, shouldn't that be picked up by the
>  make test invocation?

The private Error file is not installed if perl/Makefile.PL detects
than an Error.pm recent enough on your system. Do you actually have
perl/blib/lib/Error.pm ? Try to run (cd perl; make clean; cd ..; make)
and try the tests again.
