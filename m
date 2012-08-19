From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Test failures in t4034
Date: Sun, 19 Aug 2012 23:36:02 +0200
Message-ID: <50315C42.5060403@kdbg.org>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com> <5030FD49.6060704@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:36:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3DAx-0007d6-Kz
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 23:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab2HSVgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 17:36:08 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:13824 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751200Ab2HSVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 17:36:07 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A1F8313004D;
	Sun, 19 Aug 2012 23:36:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 60B3A19F3C6;
	Sun, 19 Aug 2012 23:36:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5030FD49.6060704@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203735>

Am 19.08.2012 16:50, schrieb Ramsay Jones:
> Brian Gernhardt wrote:
>> I've been getting a couple of test failures and finally had the
>> time to track them down.
>> 
>> t4034-diff-words fails tests "22 diff driver 'bibtex'" and "26 diff
>> driver 'html'".  Bisecting shows that the file started giving me
>> errors in commit 8d96e72 "t4034: bulk verify builtin word regex
>> sanity", which appears to introduce those tests.  I don't see
>> anything obviously wrong with the tests and I'm not familiar with
>> the diff-words code, so I'm not sure what's wrong.
>> 
>> I am running on OS X 10.8, with Xcode 4.4.1 (llvm-gcc 4.2.1).
> 
> I had the same problem (or at least it *looks* like the same problem)
> on Linux last year (May 2011), which turned out to be a bug in the
> regex routines in an old version of glibc.

I also had the same problem, but did not remember why I don't have it
anymore. Now that you mention it: It was the same situation and I came
to the same conclusion (old glibc, bogus regex implementation). I worked
it around with NO_REGEX=YesPlease in config.mak.

-- Hannes
