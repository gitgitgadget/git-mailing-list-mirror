From: David Kastrup <dak@gnu.org>
Subject: Re: Fwd: [Bug] - Processing commit message after amend
Date: Fri, 16 May 2014 12:34:15 +0200
Message-ID: <87mweif1w8.fsf@fencepost.gnu.org>
References: <CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNfMrw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michal Stasa <michal.stasa@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 12:34:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlFTD-0005dt-BD
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbaEPKe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 06:34:28 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:40880 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757081AbaEPKe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 06:34:27 -0400
Received: from localhost ([127.0.0.1]:39921 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WlFT7-0000gg-UI; Fri, 16 May 2014 06:34:26 -0400
Received: by lola (Postfix, from userid 1000)
	id B5A15E0BD9; Fri, 16 May 2014 12:34:15 +0200 (CEST)
In-Reply-To: <CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNfMrw3Q@mail.gmail.com>
	(Michal Stasa's message of "Fri, 16 May 2014 12:18:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249295>

Michal Stasa <michal.stasa@gmail.com> writes:

> I have stumbled on a weird bug. At work, we use redmine as an issue
> tracker and its task are marked by a number starting with #. When I
> commit some work and write #1234 in the message, it works. However,
> later on when I remember that I forgot to add some files and amend the
> commit, vim appears and I cannot perform the commit because the
> message starts with # which is a comment in vim and thus I get an
> error that my commit message is empty.
>
> Steps to reproduce:
> 1) commit a file
> git commit File1.txt -m "#1234 documentation added"
>
> 2) amend previous commit
> git commit File2.txt -- amend
>
> 3) go for :wq right away

git commit --amend -C HEAD File2.txt

should do the trick without starting the editor.

> However, if you use amend and no edit option, it works
> git commit --amend --no-edit

Ah, so you got your solution.  It's not like you could add that sort of
commit message interactively to start with, so it's not all that
surprising that you won't be able to amend it interactively.

-- 
David Kastrup
