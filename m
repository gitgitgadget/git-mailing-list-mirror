From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3700-add: add a POSIXPERM prerequisite to a new test
Date: Mon, 22 Jun 2009 00:42:52 -0700
Message-ID: <7vab40g1dv.fsf@alter.siamese.dyndns.org>
References: <1245316674-32377-1-git-send-email-bebarino@gmail.com>
	<7vfxdxxzps.fsf@alter.siamese.dyndns.org> <4A3A8412.7070705@gmail.com>
	<7veitho0gu.fsf@alter.siamese.dyndns.org> <4A3A8E73.1010807@gmail.com>
	<4A3F331E.5080301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 09:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIeBO-00021n-UL
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 09:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbZFVHmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbZFVHmy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 03:42:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48406 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZFVHmy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 03:42:54 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622074254.JPBW2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Mon, 22 Jun 2009 03:42:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 6vis1c00A4aMwMQ04visbf; Mon, 22 Jun 2009 03:42:52 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=M3Hjj7zPaTYA:10 a=fv-XvKvnAAAA:8
 a=A9qS8gIqAAAA:8 a=bTI1VuI853D9T2-Xp48A:9 a=fXhjXBWBjmSQlxcXrWoq2l-0RPIA:4
 a=OPgVorjKtMgA:10 a=l9rlz7MJbUIA:10 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
In-Reply-To: <4A3F331E.5080301@viscovery.net> (Johannes Sixt's message of "Mon\, 22 Jun 2009 09\:30\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122015>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> The new test does a 'chmod 0', which does not have the intended
> effect on Windows.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Stephen Boyd schrieb:
>> Junio C Hamano wrote:
>>> Why do you need POSIXPERM for this?
>> 
>> I copied a previous test and it was doing chmod 0 foo2.
> ...
>> +test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
>> +       git config add.ignore-errors 1 &&
>> +       git reset --hard &&
>> +       date >foo1 &&
>> +       date >foo2 &&
>> +       chmod 0 foo2 &&
>
> I can only guess that you missed this 'chmod 0' despite Stephen's
> explanation and dropped POSIXPERM when you applied the patch.

Actually, I wanted to add the test to 'maint' and 'maint-$v' for values of
$v that are lower than 1.6.3, so I did want to drop POSIXPERM on the
branch the patch initially applied; I forgot to make an evil merge when I
merged the result up, crossing 1.6.2/1.6.3 boundary..

Will queue on 'maint'.  Thanks.
