From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Remove '< >' from [<options>] since it's not necessary.
Date: Mon, 21 Sep 2009 08:50:45 +0200
Message-ID: <vpq7hvssse2.fsf@bauges.imag.fr>
References: <1253476116-24284-1-git-send-email-tfransosi@gmail.com>
	<auto-000020523806@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thiago Farina <tfransosi@gmail.com>
To: tom fogal <tfogal@alumni.unh.edu>
X-From: git-owner@vger.kernel.org Mon Sep 21 08:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpcjq-0001Mm-Mg
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 08:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZIUGu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 02:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZIUGu5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 02:50:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53260 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbZIUGu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 02:50:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8L6kMkk007585
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Sep 2009 08:46:22 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MpcjV-0002vF-KF; Mon, 21 Sep 2009 08:50:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MpcjV-0001Ud-Ix; Mon, 21 Sep 2009 08:50:45 +0200
In-Reply-To: <auto-000020523806@sci.utah.edu> (tom fogal's message of "Sun\, 20 Sep 2009 14\:52\:26 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Sep 2009 08:46:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8L6kMkk007585
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254120384.97317@LGLdLVS3XHj1hljEM05rCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128866>

tom fogal <tfogal@alumni.unh.edu> writes:

> Thiago Farina <tfransosi@gmail.com> writes:
>> -	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
>> +	"git log [options] [<since>..<until>] [[--] <path>...]\n"
>>  	"   or: git show [options] <object>...";
>
> To me, "<blah>" implies to me that the author meant, "something which
> is sort-of `blah'-ish but is not actually the string literal, `blah'",
> whereas `blah' means, "the string literal, `blah'."

Strictly speaking, you're right, but in the particular case of
[options], it's rather well established that it means "one or several
options", and not the litteral "option". In any case, we should be
consistant:

Documentation$ grep -n '\[<options>\]' *.txt
git-log.txt:11:'git log' [<options>] [<since>..<until>] [[\--] <path>...]
git-stash.txt:11:'git stash' list [<options>]
git-stash.txt:67:list [<options>]::
Documentation$ grep -n '\[options\]' *.txt
git-annotate.txt:10:'git annotate' [options] file [revision]
gitcli.txt:84:usage: git-describe [options] <committish>*
git-cvsserver.txt:25:'git cvsserver' [options] [pserver|server] [<directory> ...]
git-fast-export.txt:11:'git fast-export [options]' | 'git fast-import'
git-fast-import.txt:11:frontend | 'git fast-import' [options]
git-rebase.txt:11:'git rebase' [-i | --interactive] [options] [--onto <newbase>]
git-rebase.txt:13:'git rebase' [-i | --interactive] [options] --onto <newbase>
git-rev-parse.txt:405:some-command [options] <args>...
git-send-email.txt:11:'git send-email' [options] <file|directory|rev-list options>...
git-show.txt:11:'git show' [options] <object>...
git-svn.txt:10:'git svn' <command> [options] [arguments]

=> either get rid of the 3 occurences of [<options>], not just one, or
get rid of all the [options]. My vote goes for the first.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
