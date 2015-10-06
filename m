From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git interactive rebase bug?
Date: Tue, 06 Oct 2015 08:53:50 +0200
Message-ID: <vpq37xopjwh.fsf@grenoble-inp.fr>
References: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 08:54:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjM8S-0004Ni-JZ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 08:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbbJFGxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 02:53:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51308 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbbJFGxy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 02:53:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t966rn4n024633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 6 Oct 2015 08:53:49 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t966roKp014462;
	Tue, 6 Oct 2015 08:53:50 +0200
In-Reply-To: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
	(Jacob Keller's message of "Mon, 5 Oct 2015 15:39:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Oct 2015 08:53:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t966rn4n024633
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444719231.97127@cEY9dp/APjeT5qldH4B+vQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279123>

Jacob Keller <jacob.keller@gmail.com> writes:

> I've been experiencing a very annoying bug when performing interactive
> rebases. The rebase process will stall after I close the editor, and I
> have to kill the process and then restart the rebase using "git rebase
> --continue"
>
> I am not sure how to debug this further. Suggestions are welcome.

First, I'd try "pstree" ("pstree -p" to get pid) to see if your editor is really dead.

Then, "strace -p" on the git process, to see if it's doing some system
calls while hanged, or if it's hanged on a particular syscall.
Hopefully, this will yield some "open" calls and tell you which files
Git is currently working with.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
