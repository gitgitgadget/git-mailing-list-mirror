From: greened@obbligato.org (David A. Greene)
Subject: Re: Subtree Split Includes Commits Outside Prefix Directory
Date: Sat, 21 May 2016 18:06:52 -0500
Message-ID: <87eg8vovsj.fsf@waller.obbligato.org>
References: <CAKU2X8bAXmVfJz9P7d3k-_d12sjyrzWt+kJCGj8V6fTDAjsFog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: ELI <eliptus@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 01:07:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Fz0-000743-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbcEUXGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:06:55 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:57772 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751592AbcEUXGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:06:54 -0400
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1b4Fyv-0004Es-70; Sat, 21 May 2016 18:06:53 -0500
In-Reply-To: <CAKU2X8bAXmVfJz9P7d3k-_d12sjyrzWt+kJCGj8V6fTDAjsFog@mail.gmail.com>
	(ELI's message of "Fri, 22 Apr 2016 11:38:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295240>

ELI <eliptus@gmail.com> writes:

> I then reviewed the commit history of contrib/subtree/git-subtree.sh
> and determined that the last successful subtree push was performed
> prior to the integration of this change:
> https://git.kernel.org/cgit/git/git.git/commit/contrib/subtree/git-subtree.sh?id=933cfeb90b5d03b4096db6d60494a6eedea25d03
>
> As a next step, I reversed that patch on my local install of git
> subtree, and the result was a successful subtree push.

So you're saying that this patch caused a regression?

> Unfortunately, I have not yet reproduced this with a test main project
> and subprojects, and I cannot make the project I observed it in
> public.

I very much want to see a testcase for this.  I'm planning to
fundamentally rewrite the split code this year and want to make sure it
covers everything it does now and fixes a few bugs that have been
exposed lately.

It's tough to revert that patch since it fixed a problem for someone and
we don't have a testcase demonstrating the problem you encountered.  Not
saying your problem isn't important but we need to understand it and
have a way to flag it before fixing or hiding it with a revert of the
above patch.

                       -David
