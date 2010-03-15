From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: [PATCH] rebase--interactive: don't enforce valid branch
Date: Sun, 14 Mar 2010 22:28:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com> <7vsk82i2kd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 06:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr2ri-0007Xb-Pf
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 06:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab0COF3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 01:29:17 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:59883 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578Ab0COF3Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 01:29:16 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2F5ShOr001786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Mar 2010 00:28:44 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7vsk82i2kd.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142170>

On Sun, 14 Mar 2010, Junio C Hamano wrote:

> Dave Olszewski <cxreg@pobox.com> writes:
>
>> git rebase allows you to specify a non-branch commit-ish as the "branch"
>> argument, which leaves HEAD detached when it's finished.  This is
>> occasionally useful, and this patch brings the same functionality to git
>> rebase ---interactive.
>
> Three dashes?

Oops, good catch

>> +test_expect_success 'rebase while detaching HEAD' '
>> +	grandparent=$(git rev-parse HEAD~2) &&
>> +	test_tick &&
>> +	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
>
> What's the point of saying this?  You could instead say:
>
> 	git rebase -i HEAD~2
>
> no?

There's already a test for rebasing on a previously detached HEAD.  The
form "git rebase -i HEAD~2" specifies a non-branch upstream, but doesn't
take the branch argument which is the point of the change.
