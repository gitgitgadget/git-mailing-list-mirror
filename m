From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sat, 10 Apr 2010 21:58:54 +0200
Message-ID: <4BC0D87E.70001@kdbg.org>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com> <20100410042609.GA24295@coredump.intra.peff.net> <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Eugene Sajine <euguess@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:59:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gpv-0007yx-3I
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab0DJT7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:59:18 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:46206 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751284Ab0DJT7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:59:17 -0400
Received: from [178.112.34.78] (178.112.34.78.wireless.dyn.drei.com [178.112.34.78])
	by bsmtp.bon.at (Postfix) with ESMTP id 5709F10013;
	Sat, 10 Apr 2010 21:59:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144587>

Am 10.04.2010 06:39, schrieb Junio C Hamano:
> I used to religiously rebase slushy topics that are not in any stable
> integration branches (we used to have only 'master' and 'pu'), and
>
> 	git rebase master foo
>          git rebase master bar
>          git rebase master baz
>
> was far easier to type than
>
> 	git checkout foo&&  git rebase master
> 	git checkout bar&&  git rebase master
> 	git checkout baz&&  git rebase master

I'm actually very glad that the current interface is the way it is - 
because it can do the rebase *without* the checkout. This way you can save 
a lot of recompilation due to changed timestamps if the topic is based on 
an old version.

Only that some (all?) variants of rebase still unnecessarily do the 
checkout...

Oh, and it would naturally extend to a master..topic syntax.

-- Hannes
