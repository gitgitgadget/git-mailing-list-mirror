From: Hannu Koivisto <azure@iki.fi>
Subject: Re: Out of memory error with git rebase
Date: Mon, 31 Oct 2011 12:33:45 +0200
Organization: NOYB
Message-ID: <83r51ta1rq.fsf@kalahari.s2.org>
References: <83vcrc9kh7.fsf@kalahari.s2.org> <4EA7E710.1020006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 11:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKpBx-0006H9-L0
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 11:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933378Ab1JaKeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 06:34:04 -0400
Received: from lo.gmane.org ([80.91.229.12]:36329 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932685Ab1JaKeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 06:34:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RKpBn-0006BT-8e
	for git@vger.kernel.org; Mon, 31 Oct 2011 11:33:59 +0100
Received: from s2.org ([80.83.7.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 11:33:59 +0100
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 11:33:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:iCfXBfpQcijwXlOvsUeOUnx1P+M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184501>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.10.2011 11:21, schrieb Hannu Koivisto:
>> If 'git rebase origin/master' dies with an out of memory error
>> (probably due to a few of large binary files in the repository, the
>
> Try 'git rebase -m origin/master'. Without -m, rebase uses
> format-patch+am, i.e., assuming there are changes to the binary files
> that are to be rebased, a binary patch file would have to be generated
> and applied later. This is very likely where git bails out.

Thanks, -m seems to help, even though the large binary files are
not touched by the rebased commits (instead, they are touched by
the commits on top of which I'm rebasing).

>From the documentation I can't figure out any reason why one
wouldn't always want to use -m.  Why is it not the default?  I
think it's pretty much impossible for ordinary users to figure out
that they need -m in a situation like this.

-- 
Hannu
