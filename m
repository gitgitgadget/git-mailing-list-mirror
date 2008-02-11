From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Suggestion: git status --untracked
Date: Mon, 11 Feb 2008 11:13:15 +0100
Message-ID: <vpq63wvztqc.fsf@bauges.imag.fr>
References: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVhO-0003oZ-IS
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYBKKPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYBKKPB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:15:01 -0500
Received: from imag.imag.fr ([129.88.30.1]:37924 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbYBKKO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:14:59 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1BADGqj007002
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 11:13:16 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JOVf1-0001Xm-Kb; Mon, 11 Feb 2008 11:13:15 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JOVf1-0008Rl-IG; Mon, 11 Feb 2008 11:13:15 +0100
In-Reply-To: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com> (Rafael Garcia-Suarez's message of "Mon\, 11 Feb 2008 10\:46\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 11 Feb 2008 11:13:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73502>

"Rafael Garcia-Suarez" <rgarciasuarez@gmail.com> writes:

> I find myself wanting sometimes to filter out the output of
> git-status, to feed it to another command (for example, git-add, or
> rm, or cat >> .gitignore). However it's not currently very easy to
> parse in a one-liner.
>
> I'm suggesting to add options to control this behaviour. My suggestion
> would be (for a start) to add an option --untracked that will list all
> untracked files on stdout, without a leading "#\t", and without
> listing the added / modified / removed files.

Actually, it's already available (since a few weeks in master IIRC,
not sure whether it's in the latest release), as

  git ls-files --exclude-standard -o

The --exclude-standard tells git ls-files to read .gitignore and
friends as most commands do, and -o means "show 'other' files".

Older gits didn't have the --exclude-standard, so you had to say
--exclude-from=.git/info/exclude --exclude-per-directory=.gitignore
(or stg like that) instead.

-- 
Matthieu
