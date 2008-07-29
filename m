From: Eric Raible <raible@gmail.com>
Subject: Re: What is 'git BRANCH'?
Date: Tue, 29 Jul 2008 23:45:00 +0000 (UTC)
Message-ID: <loom.20080729T233158-95@post.gmane.org>
References: <g6o4vi$rap$1@ger.gmane.org> <7vej5cba6z.fsf@gitster.siamese.dyndns.org> <7v63qob9hz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 01:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNytq-0007A0-IJ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYG2XpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbYG2XpV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:45:21 -0400
Received: from main.gmane.org ([80.91.229.2]:41133 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbYG2XpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:45:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNysP-00078F-HP
	for git@vger.kernel.org; Tue, 29 Jul 2008 23:45:09 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 23:45:09 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 23:45:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90711>

Junio C Hamano <gitster <at> pobox.com> writes:

> diff --git a/git.c b/git.c
> index 37b1d76..c99e769 100644
> --- a/git.c
> +++ b/git.c
> @@ -448,7 +448,7 @@ int main(int argc, const char **argv)
>  		cmd += 4;
>  		argv[0] = cmd;
>  		handle_internal_command(argc, argv);
> -		die("cannot handle %s internally", cmd);
> +		help_unknown_cmd(cmd);
>  	}

Which on windows leads to the less-than-friendly:

git BRANCH =>
git: 'BRANCH.exe' is not a git-command. See 'git --help'.

I wonder if it wouldn't be better to simply to a case-insensitive
comparison when comparing against the builtin array.  Alternatively,
at least the the extension (if any) ought to be stripped.

I'd be glad to come up with the patch for either given the word...

- Eric
