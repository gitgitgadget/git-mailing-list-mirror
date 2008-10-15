From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
 interfere with the test
Date: Wed, 15 Oct 2008 10:10:56 +0200
Message-ID: <48F5A590.3050905@viscovery.net>
References: <1224022020.2699.4.camel@mattlaptop2.local> <1224022216.2699.5.camel@mattlaptop2.local> <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <48F589EC.6050307@viscovery.net> <7vmyh64bgy.fsf@gitster.siamese.dyndns.org> <48F59928.5040502@viscovery.net> <7v7i8a47f6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq1UL-0000Bu-2w
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 10:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYJOILA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 04:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbYJOILA
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 04:11:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53504 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYJOIK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 04:10:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kq1T6-0000Rm-KW; Wed, 15 Oct 2008 10:10:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 66F9269F; Wed, 15 Oct 2008 10:10:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v7i8a47f6.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98258>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>  - Do you mean, by "educate users", that we teach users not to play fun
>>>    games with ACL in a git controled working tree?
>> Correct. In the case of a shared repository we can educate users not to
>> play with ACLs.
>>
>>>  - Do you mean, by "fix the code", that we teach adjust_shared_perm() to
>>>    deal with ACL?
>> Correct in principle, but we need not go this route in the case of shared
>> repositories because we better educate users.
> 
> If that is the case what difference does your suggestion of not putting it
> in test-lib.sh make?  We discourage users from playing ACL games, and we
> protect ourselves from such by making sure the trash directory used for
> running tests are not contaminated with ACL.  Wouldn't it make more sense
> to do so for all the tests, so that future test writers do not have to
> worry about it?

We have to decide case by case. In the case of shared directories it makes
sense to suggest "do not play ACL games". In other cases, however, this
suggestion could not work out that well, and a workaround in the code is
the better solutions. But we do not know what those other cases are, and
the test suite may be a tool to uncover them.

Perhaps I'm worrying too much because a case that warrants a change in the
code would either have to happen frequently or be backed with very strong
arguments that ACLs are required in that particular way. (And in both
cases there would still have be conflicts in the way how git handles
permissions - we wouldn't care otherwise.) But no such case has turned up
so far.

-- Hannes
