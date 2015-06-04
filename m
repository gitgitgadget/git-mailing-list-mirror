From: Ed Avis <eda@waniasset.com>
Subject: Re: Suggestion: make git checkout safer
Date: Thu, 4 Jun 2015 10:47:32 +0000 (UTC)
Message-ID: <loom.20150604T123949-199@post.gmane.org>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <loom.20150603T114527-151@post.gmane.org> <xmqqh9qoy9sx.fsf@gitster.dls.corp.google.com> <004801d09e25$a339b0f0$e9ad12d0$@nexbridge.com> <CAGZ79kYv5Xgfv=3KD0oPrUsJD2Yw-EHu7U=_35FZTm4Rp5hbBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 12:48:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Sgs-0006AJ-Qs
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 12:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbbFDKr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 06:47:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:45509 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbbFDKr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 06:47:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z0Sgc-0005y5-Vq
	for git@vger.kernel.org; Thu, 04 Jun 2015 12:47:47 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 12:47:46 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 12:47:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270765>

Stefan Beller <sbeller <at> google.com> writes:

>So in one mode, we do actually warn about contents going missing, and the
>other mode is designed to actually make things go missing without any
>warning.

I think this is a big part of the issue.  Two rather different operations
are given the name 'checkout', and the safety standards applied to them
also differ greatly.  The manual page doesn't make it clear that it can
be quite a dangerous command to run, even without --force.

>If I were to come up with a name for such an action it's
>maybe "reset" or "reset-file(s)".

Agreed.  Or 'git clean' could become more powerful and able to reset file
contents as well as deleting untracked files.  The name and documentation of
'git clean' already make it clear that it's not something safe to run without
thinking first.

Julio H. asked how I had learned to run 'git checkout .'.  I think it was just
word of mouth.  I had deleted some files from the working tree and asked a
colleague how to restore them from the repository - which is, after all, a
bread-and-butter operation for any version control system.  What is the
correct command to run, then, to safely restore missing files?

And yes, it probably would be better to use git's native mechanisms to throw
away local changes to a file, rather than the sledgehammer approach of just
deleting it and checking it out again.  Most of the time I do so.  Sometimes
when everything is a real mess it is more straighforward to reach for 'rm' -
or indeed for the delete option in your IDE or file browser.

-- 
Ed Avis <eda@waniasset.com>
