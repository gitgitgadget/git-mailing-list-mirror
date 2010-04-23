From: Sergei Organov <osv@javad.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 15:44:14 +0400
Message-ID: <87zl0u5r75.fsf@osv.gnss.ru>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<20100423093943.GB30346@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 13:51:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5HPe-0006DL-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 13:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab0DWLvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 07:51:00 -0400
Received: from javad.com ([205.178.136.214]:46568 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221Ab0DWLu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 07:50:59 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2010 07:50:59 EDT
Received: (qmail 9701 invoked from network); 23 Apr 2010 11:44:16 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 23 Apr 2010 11:44:16 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.71)
	(envelope-from <osv@osv.gnss.ru>)
	id 1O5HIt-0003RQ-0H; Fri, 23 Apr 2010 15:44:15 +0400
In-Reply-To: <20100423093943.GB30346@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s
	message of "Fri, 23 Apr 2010 11:39:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145609>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2010.04.22 22:37:05 +0200, Goswin von Brederlow wrote:
>> Is there a risk? You do get an editor with all the files affected li=
sted
>> giving you a big fat warning what you are about to commit.
>
> And if I happen to have two unrelated changes in a single file that's
> worth nothing at all. For example, I might have changed the condition
> that causes some message to be shown, and discovered a typo in the
> message itself and fixed it along the way. That needs two commits, bu=
t
> the list of modified files doesn't tell that.
>
> Only "commit -v" would help there, showing the diff in the editor. Bu=
t
> reviewing the diff in the editor is a PITA and I lose the whole revie=
w
> progress if I find something I don't want to commit and have to abort=
=2E
> Using "git add [-i|-p|-e]", git helps me to keep track of the changes=
 I
> already reviewed and decided to commit.

And how do you check your changes for correctness before committing? I
have a habit to only commit the exact tree I've compiled, and I can
compile only the working tree, not the index, right? So for me,
committing the index sounds to be a wrong idea (unless it matches the
work-tree).

I think I'd like to have an ability to temporarily undo some of changes
putting them on shelf for later re-application (sounds like extension t=
o
stash?). This way, when preparing perfect commit, I'd undo everything
unrelated, check (build/run) the result, then commit. Then I'd re-do
everything that was undone using single command that would take all the
changes from the shelf back to working tree. Repeat as appropriate.
Multiple shelves would be the next improvement that will allow to
immediately sort the changes into different changesets during undoing.
Just dreaming... At least that's roughly how I actually managed this
with CVS using patch and emacs, -- far from being pretty, but works.

-- Sergei.
