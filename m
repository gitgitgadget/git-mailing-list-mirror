From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 09:09:55 +0100
Message-ID: <k8nb0t$2pf$1@ger.gmane.org>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com> <CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 09:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TboLM-0001IP-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 09:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab2KWIKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 03:10:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:55215 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856Ab2KWIKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 03:10:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TboLG-0001GB-Q7
	for git@vger.kernel.org; Fri, 23 Nov 2012 09:10:30 +0100
Received: from dsdf-4db513fd.pool.mediaways.net ([77.181.19.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 09:10:30 +0100
Received: from jojo by dsdf-4db513fd.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 09:10:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db513fd.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210244>

Marc Khouzam wrote:
> The uniq program only works with sorted input.  The man page states
> "uniq prints the unique lines in a sorted file".
...
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -321,7 +321,7 @@ __git_refs ()
>                                if [[ "$ref" == "$cur"* ]]; then
>                                        echo "$ref"
>                                fi
> -                       done | uniq -u
> +                       done | sort | uniq -u

Is 'sort -u' not universally available and sufficient here? It is POSIX at 
least:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sort.html

Bye, Jojo 
