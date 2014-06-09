From: David Kastrup <dak@gnu.org>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 09 Jun 2014 16:04:43 +0200
Message-ID: <87vbsayy9w.fsf@fencepost.gnu.org>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
	<CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Pierre-Fran=E7ois?= CLEMENT <likeyn@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 16:04:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu0Bu-0007Sb-2E
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 16:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbaFIOEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 10:04:46 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:37569 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbaFIOEp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2014 10:04:45 -0400
Received: from localhost ([127.0.0.1]:36611 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wu0Bo-0002gq-8E; Mon, 09 Jun 2014 10:04:44 -0400
Received: by lola (Postfix, from userid 1000)
	id D44AAE075E; Mon,  9 Jun 2014 16:04:43 +0200 (CEST)
In-Reply-To: <CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
	(=?iso-8859-1?Q?=22Pierre-Fran=E7ois?= CLEMENT"'s message of "Mon, 9 Jun
 2014 13:24:56
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251078>

Pierre-Fran=E7ois CLEMENT <likeyn@gmail.com> writes:

> Hi all,
>
> Someone pointed out on the "Git for human beings" Google group
> (https://groups.google.com/d/topic/git-users/27_FxIV_100/discussion)
> that using git-reset's hard mode when having staged untracked files
> simply deletes them from the working dir.
>
> Since git-reset specifically doesn't touch untracked files, one could
> expect having staged untracked files reset to their previous
> "untracked" state rather than being deleted.
>
> Could this be a bug or a missing feature? Or if it isn't, can someone
> explain what we got wrong?

git reset --keep maybe?

In a work dir and index without modifications, I expect

git apply --index ...
git reset --hard

to remove any files that git apply created.  It would not do so using
your proposal.  I agree that it seems a bit of a borderline, but I
consider it better that once a file _is_ tracked, git reset --hard will
first physically remove it before untracking it.

--=20
David Kastrup
