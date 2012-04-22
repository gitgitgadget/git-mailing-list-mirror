From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Apr 2012, #08; Fri, 20)
Date: Sun, 22 Apr 2012 17:07:15 +0200
Message-ID: <4F941EA3.7080200@kdbg.org>
References: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 17:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLyNl-0000yR-N0
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 17:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab2DVPHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 11:07:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22917 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab2DVPHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 11:07:14 -0400
Received: from [192.168.0.201] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3C2CC1000F;
	Sun, 22 Apr 2012 17:03:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196081>

Am 21.04.2012 02:06, schrieb Junio C Hamano:
> * th/difftool-diffall (2012-04-14) 8 commits
>   - difftool: print list of valid tools with '--tool-help'
>   - difftool: teach difftool to handle directory diffs
>   - difftool: eliminate setup_environment function
>   - difftool: stop appending '.exe' to git
>   - difftool: remove explicit change of PATH
>   - difftool: exit(0) when usage is printed
>   - difftool: add '--no-gui' option
>   - difftool: parse options using Getopt::Long
> 
> Rolls the two-directory-diff logic from diffall script (in contrib/) into
> "git difftool" framework.

This does not pass test 33 (the last one) on Windows:

+++ git difftool --dir-diff --extcmd ls branch
Use of uninitialized value in length at d:/Src/mingw-git/git-difftool line 55.
Use of uninitialized value in length at d:/Src/mingw-git/git-difftool line 55.
exiting now at d:/Src/mingw-git/git-difftool line 120.
usage: git diff [--no-index] <path> <path>
diff --raw --no-abbrev -z branch: command returned error: 129

("exiting now" is a debugging "warn" call that I inserted)

I don't know what's going on. One possibility is that an old Git.pm is
being used, because I haven't 'make install' yet.

I'm not going to look into this, but I can run tests if you tell me what
to do.

-- Hannes
