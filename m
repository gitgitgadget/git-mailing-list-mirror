From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git with custom diff for commits
Date: Tue, 18 Dec 2007 00:08:43 +0100
Message-ID: <vpq1w9kaphg.fsf@bauges.imag.fr>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerald Gutierrez <ggmlfs@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P5b-0006ZX-JB
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760675AbXLQXJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760437AbXLQXJM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:09:12 -0500
Received: from imag.imag.fr ([129.88.30.1]:37752 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760061AbXLQXJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:09:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBHN8hsa003641
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 00:08:43 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J4P4l-0006Ix-6O; Tue, 18 Dec 2007 00:08:43 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J4P4l-00065R-3Q; Tue, 18 Dec 2007 00:08:43 +0100
In-Reply-To: <Pine.LNX.4.64.0712172300510.9446@racer.site> (Johannes Schindelin's message of "Mon\, 17 Dec 2007 23\:01\:37 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Dec 2007 00:08:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68654>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 17 Dec 2007, Gerald Gutierrez wrote:
>
>> I do a nightly mysqldump of a database and check it into a git 
>> repository. mysqldump generates a timestamp as part of that output which 
>> is causing git to think that the file changes every night when it really 
>> doesn't. The timestamp is simply in an SQL comment.
>> 
>> So what I'd like to do is teach git to ignore that particular SQL 
>> timestamp comment. I've tried to set up an external diff script that 
>> runs diff -I "<<sql timestamp comment>>" that effectively ignores the 
>> timestamp. While this works with "git diff", it seems when git commits, 
>> it still sees the differences.
>> 
>> How do I properly teach git to ignore these types of differences?
>
> You might be interested in reading Documentation/gitattributes.txt, look 
> for "diff driver".

It will show an empty output for "git diff", but I doubt thit will
change anything at commit time. Probably the "filter" thing on the
same file (also "man gitattributes") can help though.

-- 
Matthieu
