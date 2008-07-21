From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Hacks for AIX
Date: Mon, 21 Jul 2008 10:39:28 -0500
Message-ID: <hT7kYDX9f_eBxi8JC0s7jG9oqm8sZ1QCTlEg1n8Dqus7U98hWLWnBA@cipher.nrlssc.navy.mil>
References: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com> <7v3am9sn2p.fsf@gitster.siamese.dyndns.org> <7vd4l9c5ud.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Cowan <chris.o.cowan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 17:41:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKxVn-0004NQ-U8
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 17:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbYGUPkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 11:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYGUPkT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 11:40:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55701 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYGUPkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 11:40:18 -0400
Received: by mail.nrlssc.navy.mil id m6LFdScs014734; Mon, 21 Jul 2008 10:39:28 -0500
In-Reply-To: <7vd4l9c5ud.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 21 Jul 2008 15:39:28.0403 (UTC) FILETIME=[F617F630:01C8EB47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89362>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>>     * /usr/bin/patch - really old version, doesn't do well with some
>>> diff formats.   I avoid using it.
>> t4109 seems to use patch to produce expected output for the tests; we
>> should ship a precomputed expected results.  Do you know of any other
>> places "patch" is used?
> 
> As usual, I won't commit this patch unless I hear from people who
> potentially would benefit from it.  I do not need such a patch myself and
> I really shouldn't be spending too much of my time on these.


Unless I'm doing something wrong, this doesn't apply cleanly to master.


> -- >8 --
> [PATCH] do not rely on external "patch" in tests
> 
> Some of our tests assumed a working "patch" command to produce expected
> results when checking "git-apply", but some systems have broken "patch".
> 
> We can compare our output with expected output that is precomputed
> instead to sidestep this issue.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4109-apply-multifrag.sh |  119 +++++++++++++++++++++++++++++++++++---------
>  t/t4110-apply-scan.sh      |   35 ++++++++++---
>  2 files changed, 123 insertions(+), 31 deletions(-)
> 
> diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
> index bd40a21..4805863 100755
> --- a/t/t4109-apply-multifrag.sh
> +++ b/t/t4109-apply-multifrag.sh
> @@ -138,39 +138,112 @@ diff --git a/main.c b/main.c

The t4109-apply-multifrag.sh that I have only has 52 lines.

>  EOF

It does not have this line above. Perhaps you also moved the
../t4109/patch*.patch files into the script in another commit?

-brandon
