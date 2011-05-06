From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: Question about PERL_PATH
Date: Fri, 6 May 2011 17:42:19 +0100
Message-ID: <4DC424EB.6000107@mev.co.uk>
References: <4DC3F804.3080205@mev.co.uk> <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIO6o-0005f1-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab1EFQmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 12:42:25 -0400
Received: from mail.mev.co.uk ([62.49.15.74]:38791 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab1EFQmY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 12:42:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.mev.co.uk (Postfix) with ESMTP id 06A0625032;
	Fri,  6 May 2011 17:42:24 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at mail.mev.co.uk
Received: from mail.mev.co.uk ([127.0.0.1])
	by localhost (mantis.mev.local [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wQfkofmo2Eqx; Fri,  6 May 2011 17:42:21 +0100 (BST)
Received: from remote.mev.co.uk (mev2008.mev.local [10.0.0.1])
	by mail.mev.co.uk (Postfix) with ESMTPS id 662BE25007;
	Fri,  6 May 2011 17:42:21 +0100 (BST)
Received: from [10.0.0.210] (10.0.0.254) by remote.mev.co.uk (10.0.0.1) with
 Microsoft SMTP Server (TLS) id 8.1.436.0; Fri, 6 May 2011 17:42:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110503 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172987>

On 06/05/11 17:05, Junio C Hamano wrote:
> Ian Abbott <abbotti@mev.co.uk> writes:
> 
>> The Gentoo ebuilds for git have started invoking 'make' with the option
>> 'PERL_PATH=/usr/bin/env perl'.  This doesn't seem to cause any problems
>> except when running git instaweb, which outputs an error similar to the
>> following:
>>
>> /usr/libexec/git-core/git-instaweb: line 135: /usr/bin/env perl: No such
>> file or directory
> 
> The variable is not PERL_COMMAND_LINE, but is PERL_PATH, so I think it
> should expects the path to the program.
> 
> Our testsuite also rely on it being the path to the program by enclosing
> the reference to it inside double quotes, to make sure that PERL_PATH set
> to "/Program Files/Perl/perl.exe" works.  Didn't Gentoo folks see any test
> breakage before shipping the ebuild procedure?

Both you and Michael make excellent points and I've submitted a Gentoo
bug report mentioning this thread, so we'll see what happens!

http://bugs.gentoo.org/show_bug.cgi?id=366241

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
