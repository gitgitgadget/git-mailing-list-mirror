From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFD] Alternative to git-based wiki: wiki as foreign VCS
Date: Tue, 22 Feb 2011 11:33:19 +0100
Message-ID: <vpq7hcsmk9c.fsf@bauges.imag.fr>
References: <vpqoc6a8x0k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 11:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrpYf-00072R-1L
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 11:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab1BVKdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 05:33:24 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57798 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab1BVKdW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 05:33:22 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1MAXItr030325
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Feb 2011 11:33:18 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PrpYV-0001oP-Eu; Tue, 22 Feb 2011 11:33:19 +0100
In-Reply-To: <vpqoc6a8x0k.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu\, 17 Feb 2011 17\:07\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Feb 2011 11:33:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1MAXItr030325
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298975599.25055@4xa5p+mJKNRp50Vnt1CYEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167539>

Hi again,

So, nobody's more inspired to comment on this proposal? ;-)

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hi,
>
> I think most people on this list already faced the issue: wikis are
> cool, easy to contribute, ... but it's hard to force yourself to use a
> purely web-based tool to interact with something which really looks
> like a version-control system.
>
> One solution is to use a git-based wiki, like ikiwiki [1], golum
> [2], ... but in many contexts, this is not applicable: because one
> has an existing wiki and doesn't want to migrate, because the
> git-based wiki lacks features XYZ that you rely on, or because one is
> a small contributor to a large project (say, wikipedia) and cannot
> force the project to change.
>
> I'm thinking of an alternative to this: implement a foreign VCS
> interface for a wiki engine. Today, one can interact with, say, SVN,
> using Git (via git-svn [3]). This way, we can get most of the Git
> goodness locally, and just "publish" the changes on an SVN repository.
>
> I think that should be feasible to implement the same kind of things
> to interact with, say, MediaWiki. Typical scenarios would be:
>
> 1) Work locally, possibly collaboratively on a set of pages, and then
>    publish them on a wiki (let's call this "git mw set-tree" by
>    analogy with "git svn set-tree").
>
> 2) Wait for user contributions on the wiki, and fetch them to the Git
>    repository with one command (let's call this "git mw fetch" by
>    analogy with "git svn fetch").
>
> 3) Allow one to easily download a set of files, and later get updates
>    (i.e. "git clone/git pull" is far better than downloading from a
>    browser)
>
> I'm personnaly interested in this in a teaching context, since I love
> Git, and I use a wiki [4] to publish some documents to my students.
> Scenario 1) corresponds to teachers preparing stuffs (without
> necessarily publishing drafts), and 2) corresponds to two cases:
> coworker unwilling to use Git, but willing to use a wiki, and students
> contributing some content. Senario 3) corresponds to the case where we
> distribute a set of files (say, example pieces of code), and reference
> these files from a wiki documentation. See [5] for an example.
>
> I've already got half a solution where I publish content on GitHub,
> and include them on a wiki with the "Include" extension [6]. It solves
> scenario 1) partially and 3) nicely, but not 2).
>
> Together with Sylvain Boulme (in Cc), we plan to propose a project to
> students to develop a git-svn-like interface to interact with
> mediawiki. Students have a bit less than a month in May-June and work
> in teams of 2 to 4 students (last year, we got the textconv
> functionality in "git blame" and "git gui blame", and some better
> error messages with the same project).
>
> It sounds feasible to write a usable prototype, probably re-using code
> from tools interacting with mediawiki (like wikipediafs [7]), and
> basing the work on git remote helpers [8]. We should be able to make
> this a free software.
>
> Among the design goals:
>
> * No restriction on the Git workflow. Unlike "git-svn" which promotes
>   a flow with SVN as the central repository, we should target a
>   workflow where people merge freely using Git, and then publish/fetch
>   changes from the wiki (i.e. a merge-based workflow, as opposed to a
>   rebase-based one).
>
> * Ability to import only a subset of the wiki (nobody want to "git
>   clone" the whole wikipedia ;-) ). At least a manually-specified list
>   of pages, and better, the content of one category.
>
> * Ability to work interact with several wikis (e.g. a test, private
>   instance, and a public instance).
>
> And then, fancy extensions can be imagined:
>
> * Manage non-text files as Media files uploaded to the wiki.
>
> * Manage directories in Git as subcategories in the wiki.
>
> Any opinions? Advices? Does this sounds like a good idea? Any pitfall
> to avoid?
>
> Thanks in advance,
>
> Footnotes:
> [1] http://ikiwiki.info/
> [2] https://github.com/github/gollum
> [3] http://www.kernel.org/pub/software/scm/git/docs/git-svn.html
> [4] http://ensiwiki.ensimag.fr/index.php/Accueil (French)
> [5] http://ensiwiki.ensimag.fr/index.php/LdB_-_Modes_d%27adressages#Mode_d.27adressage_.C2.AB.C2.A0Indirect_Registre.C2.A0.C2.BB
> [6] http://www.mediawiki.org/wiki/Extension:Include
> [7] http://wikipediafs.sourceforge.net/
> [8] http://www.kernel.org/pub/software/scm/git/docs/git-remote-helpers.html

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
