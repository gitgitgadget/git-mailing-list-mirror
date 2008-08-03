From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Missing pieces for 1.6.0 on MinGW?
Date: Sun, 3 Aug 2008 12:17:33 +0200
Message-ID: <1E34BC5D-5A83-4B27-8F62-96F582F0625F@zib.de>
References: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org> <1217754985.4895776973fda@webmail.nextra.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 03 12:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPage-0002qF-Fb
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 12:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbYHCKRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 06:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYHCKRn
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 06:17:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:39358 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbYHCKRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 06:17:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m73AHPhb019514;
	Sun, 3 Aug 2008 12:17:30 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db91b8e.pool.einsundeins.de [77.185.27.142])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m73AHEHa018468
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 3 Aug 2008 12:17:14 +0200 (MEST)
In-Reply-To: <1217754985.4895776973fda@webmail.nextra.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91224>


On Aug 3, 2008, at 11:16 AM, Johannes Sixt wrote:

> Zitat von Junio C Hamano <gitster@pobox.com>:
>> Just a quick question before the weekend ends and -rc2 gets  
>> tagged.  (I
>> lost track of that argv0 vs bin/git vs libexec/git-core/git-foo
>> discussion).
>>
>> Are there any missing but necessary patches we need before 1.6.0 for
>> MinGW?
>
> Yes, there are some open issues:
>
> (1) git-gui was fixed for the msysgit installer, but it broke for  
> me; but I
> think I know where to fix it.

I now recognized that not all hunks that I have in 4msysgit were applied
by Shawn.  See separate mail

  http://article.gmane.org/gmane.comp.version-control.git/91221


> (2) the non-builtins in $(bindir) don't set argv0_path, and  
> consequently don't
> find ETC_GITCONFIG.

Setting argv0_path correctly wouldn't help alone.  The relative
path to $prefix is different in $prefix/bin and
$prefix/libexec/git-core.  Thus, we cannot do the same computation.
system_path() would need to check from which directory the computation
starts.


> (3) the 'mingw_main undefined' error is still a mystery. I'm about  
> to send a
> preprocessed file to Steffen (it's a bit large, even compressed, so  
> I'll do
> that in a private mail).

ok.

	Steffen
