From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: [PATCH] rebase--interactive: don't enforce valid branch
Date: Sun, 14 Mar 2010 22:46:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003142242510.796@narbuckle.genericorp.net>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com> <7vsk82i2kd.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net> <7vvdcygmz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 06:47:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr39U-00039P-84
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 06:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670Ab0COFrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 01:47:39 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:44817 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759639Ab0COFri (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 01:47:38 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2F5knRo002797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Mar 2010 00:46:49 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7vvdcygmz8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142172>

On Sun, 14 Mar 2010, Junio C Hamano wrote:

>> There's already a test for rebasing on a previously detached HEAD.  The
>> form "git rebase -i HEAD~2" specifies a non-branch upstream, but doesn't
>> take the branch argument which is the point of the change.
>
> What I meant was that if you prefer to work on a detached HEAD (and I
> sometimes do), then your HEAD would likely to be detached already when you
> run rebase.  IOW, I would expect that
>
> 	git checkout HEAD^0
>        ... perhaps do something, perhaps do nothing, here ...
>        git rebase -i HEAD~2
>
> would be a lot more natural thing to do, and in that case you do not need
> to say HEAD^0 there.

That functionality already works.  It's certainly possible to do it as
you describe, but why require the extra step?  git-rebase already
supports detaching as part of its behavior, but rebase -i does not.
It may seem nitpicky, but it's asymmetric and occasionally it's handy
syntax.
