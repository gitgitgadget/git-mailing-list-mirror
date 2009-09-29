From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 21:55:37 +0200
Message-ID: <vpqk4zhplty.fsf@bauges.imag.fr>
References: <h9nlhj$heq$1@ger.gmane.org>
	<m33a66br69.fsf@localhost.localdomain>
	<ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>
	<200909292058.53045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SLONIK.AZ@gmail.com, Anteru <newsgroups@catchall.shelter13.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 21:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsiqY-0003oW-GR
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 21:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZI2T6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 15:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbZI2T6k
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 15:58:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:64740 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbZI2T6k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 15:58:40 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8TJtc8j021124
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 21:55:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MsinS-0004t6-0P; Tue, 29 Sep 2009 21:55:38 +0200
In-Reply-To: <200909292058.53045.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 29 Sep 2009 20\:58\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 29 Sep 2009 21:55:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129325>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 29 Sep 2009, Leo Razoumov wrote:
>> On 2009-09-28, Jakub Narebski <jnareb@gmail.com> wrote:
>> > [..snip..]
>> >  Besides with nonlinear history with
>> >  revision numbers such as 12678 and 12687 you know that 12678 is older
>> >  than 12687 if and only if 12678 and 12687 are on the same line of
>> >  development.
>> 
>> The statement above is incorrect!! In a Mercurial repo local revision
>> numbers are strictly ordered in commit time. 12678 < 12687 means that
>> 12678 was committed prior to 12687. But these two commits could belong
>> to two completely unrelated lines of development.
>
> This is impossible with distributed development.

Yes, the accurate statement is (I think): "In a Mercurial repo local
revision numbers are strictly ordered according _the time when the_
_commit entered the repository_" (i.e. the time you did a merge, not
the time the other guy did the commit).

Just tested:

$ hg log
changeset:   3:4d6db21df0cd
tag:         tip
parent:      1:31f8406ae59c
parent:      2:33bfb84a5113
user:        Matthieu Moy <Matthieu.Moy@imag.fr>
date:        Tue Sep 29 21:54:25 2009 +0200
summary:     merge

changeset:   2:33bfb84a5113
parent:      0:a508b050e5ae
user:        Matthieu Moy <Matthieu.Moy@imag.fr>
date:        Tue Sep 29 21:54:02 2009 +0200
summary:     in branch bar

changeset:   1:31f8406ae59c
user:        Matthieu Moy <Matthieu.Moy@imag.fr>
date:        Tue Sep 29 21:54:11 2009 +0200
summary:     in branch foo

changeset:   0:a508b050e5ae
user:        Matthieu Moy <Matthieu.Moy@imag.fr>
date:        Tue Sep 29 21:53:33 2009 +0200
summary:     init

Either I have a time machine at home, or changesets 1 was not made
before changeset 2.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
