From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Out of memory error with git rebase
Date: Wed, 26 Oct 2011 12:55:12 +0200
Message-ID: <4EA7E710.1020006@kdbg.org>
References: <83vcrc9kh7.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Wed Oct 26 12:55:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ18l-0002XN-P4
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 12:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680Ab1JZKzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 06:55:16 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:16370 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932634Ab1JZKzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 06:55:15 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 47EFBA7EB3;
	Wed, 26 Oct 2011 12:55:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DF17D19F4A9;
	Wed, 26 Oct 2011 12:55:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <83vcrc9kh7.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184255>

Am 26.10.2011 11:21, schrieb Hannu Koivisto:
> If 'git rebase origin/master' dies with an out of memory error
> (probably due to a few of large binary files in the repository, the
> largest being ~300MB and ~1GB in total in one directory), which
> settings should be tweaked and how to get rid of the problem?  I
> tried...

Try 'git rebase -m origin/master'. Without -m, rebase uses
format-patch+am, i.e., assuming there are changes to the binary files
that are to be rebased, a binary patch file would have to be generated
and applied later. This is very likely where git bails out.

-- Hannes
