From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 10:59:14 +0200
Message-ID: <vpqsioxn82l.fsf@anie.imag.fr>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	<87vbtt6dyq.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, d9ba@mailtor.net,
	jrnieder@gmail.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:00:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehQM-0001tH-I9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbaD1JAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:00:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60100 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110AbaD1JAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:00:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3S8xDXx025242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2014 10:59:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3S8xEXi002672;
	Mon, 28 Apr 2014 10:59:14 +0200
In-Reply-To: <87vbtt6dyq.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 28 Apr 2014 10:43:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Apr 2014 10:59:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3S8xDXx025242
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399280355.25863@xjrPa9zxgdwFTDV37eBb8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247250>

David Kastrup <dak@gnu.org> writes:

> There seem to be a few more occurences (git-sh-setup.sh and pager.c):

Not since f82c3ffd862c7 (Wed Feb 5 2014, move LESS/LV pager environment
to Makefile).

> Searching for LESS seems to implicate a few more possible candidates in
> contrib/examples:
>
> contrib/examples/git-log.sh:LESS=-S ${PAGER:-less}
> contrib/examples/git-whatchanged.sh:LESS="$LESS -S" ${PAGER:-less}

Yes, I did see these, but I considered that contrib/examples/ should
remain a snapshot of what the commands used to look like at the time
they were shell scripts.

There's also user-manual.txt:

,----
| Basically, the initial version of `git log` was a shell script:
| 
| ----------------------------------------------------------------
| $ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
| 	LESS=-S ${PAGER:-less}
| ----------------------------------------------------------------
`----

that I left intact. I can change them too if people prefer.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
