From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Small rerere in rebase regression
Date: Tue, 24 May 2016 21:48:29 +0200
Message-ID: <5744B00D.4020006@kdbg.org>
References: <57434572.6030306@kdbg.org>
 <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org>
 <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605241510370.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 24 21:48:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5IJk-0001Y0-B9
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbcEXTsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:48:36 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:33707 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389AbcEXTsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:48:35 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rDmDZ3S8Zz5tlB;
	Tue, 24 May 2016 21:48:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E23FC5291;
	Tue, 24 May 2016 21:48:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <alpine.DEB.2.20.1605241510370.4449@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295528>

Am 24.05.2016 um 15:18 schrieb Johannes Schindelin:
> Hannes, could you quickly test whether
> https://github.com/dscho/git/tree/interactive-rebase calls rerere twice,
> too? (Please call interactive rebase with the GIT_USE_REBASE_HELPER=true
> to avoid running the interactive rebase twice.)
>
> I have a hunch that it does not call rerere twice, which would be a nice
> bonus in that patch thicket

It prints the message only once:

gittest@master:1007> GIT_USE_REBASE_HELPER=true git rebase -i side
error: could not apply fa62fea... master

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".

Recorded preimage for 'a'
Could not apply fa62fea... mastergittest@master|REBASE-i 1/1:1008> 5~

(Take note of the missing LF at the end of the message.)

Can this result be interpreted as another indication that the "git 
rerere" call in die_with_patch can be removed, or are the two git-rebase 
implementations too different to be comparable?

-- Hannes
