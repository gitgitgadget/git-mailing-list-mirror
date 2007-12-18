From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git with custom diff for commits
Date: Tue, 18 Dec 2007 09:57:48 +0100
Message-ID: <vpqk5ncz8fn.fsf@bauges.imag.fr>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
	<vpq1w9kaphg.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712172310090.9446@racer.site>
	<7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerald Gutierrez <ggmlfs@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YOD-0001TS-DL
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbXLRJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbXLRJEy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:04:54 -0500
Received: from imag.imag.fr ([129.88.30.1]:47142 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbXLRJEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:04:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBI8vmLQ021066
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 09:57:49 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J4YGq-0001R1-5X; Tue, 18 Dec 2007 09:57:48 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J4YGq-0006Ab-3K; Tue, 18 Dec 2007 09:57:48 +0100
In-Reply-To: <7vbq8o6gxw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 17 Dec 2007 15\:26\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Dec 2007 09:57:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68710>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> It will show an empty output for "git diff", but I doubt thit will 
>>> change anything at commit time. Probably the "filter" thing on the same 
>>> file (also "man gitattributes") can help though.
>>
>> Ah, right.  I completely missed that you were talking about git-commit, 
>> not git-log on git commits.
>>
>> Yes, setting up a "clean" filter that removes the timestamps is probably 
>> the reasonable thing to do here.
>
> I wouldn't do filters for something like that.  Can you guarantee that
> the output from corresopnding smudge filter will load cleanly back to
> the mysql database?

The original poster said the date was an SQL comment, so, it should be
safe to strip it. That said, precommit hook is probably a good or
better solution. At least, if you're not sure you didn't make a
mistake writting it, you'll notice either a good commit or no commit
at all. With filters, you might well notice you corrupted the commit
too late :-(.

-- 
Matthieu
