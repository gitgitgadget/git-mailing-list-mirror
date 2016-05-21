From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH 0/3] subtree: add 'git-subtree-repo' and list command
Date: Sat, 21 May 2016 17:59:36 -0500
Message-ID: <87mvnjow4n.fsf@waller.obbligato.org>
References: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dave <davidw@realtimegenomics.com>,
	Mathias Nyman <mathias.nyman@iki.fi>
To: Nicola Paolucci <npaolucci@atlassian.com>
X-From: git-owner@vger.kernel.org Sun May 22 00:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Fs2-0001wd-GW
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 00:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbcEUW7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 18:59:40 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:57710 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751551AbcEUW7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 18:59:39 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 May 2016 18:59:39 EDT
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1b4Frt-0004CN-Kj; Sat, 21 May 2016 17:59:37 -0500
In-Reply-To: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
	(Nicola Paolucci's message of "Thu, 10 Mar 2016 10:44:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295238>

Nicola Paolucci <npaolucci@atlassian.com> writes:

> To my knowledge 'git subtree' currently lacks a way to
> track where injected repositories come from originally.
> Adding this information allows for useful extensions to 
> the command and makes it easier to use subtrees to track
> external dependencies.

Thanks for working on this.  I just sent a reply to your earlier
iteration.

What is the intent for use of this?  Is it simply to record from where
commits were pulled or do you intend to use this information later on to
have git-subtree guess from where to fetch future commits?

I would be opposed to the latter because I think it potentially limits
the utility of git-subtree and may be misleading.  I frequently pull
commits for a subtree from several different clones of the same
reposiory.  How does git-subtree list handle that situation?

Does git-subtree list really print out repository information for every
commit added by git-subtree?  That's potentially a lot of commits.  It
might be more useful to aggregate repository information and only dump
out unique URLs.  In any case, processing all commits seems like a ton
of work for such a simple operation.  Maybe this information should be
cached in .gitconfig.

I'm actually in the middle of cleaing up metadata but I'm not going to
block these commits due to that.  Just be aware that it may change a
bit.

                  -David
