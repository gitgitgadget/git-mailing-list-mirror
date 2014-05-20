From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: EXT :Re: GIT and large files
Date: Tue, 20 May 2014 23:01:34 +0400
Message-ID: <20140520230134.25cbbffe1b0ce95de60024a5@domain007.com>
References: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
	<xmqqmwec1i9f.fsf@gitster.dls.corp.google.com>
	<C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD631@XMBVAG73.northgrum.com>
	<xmqqoaysz59s.fsf@gitster.dls.corp.google.com>
	<C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD670@XMBVAG73.northgrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Stewart, Louis (IS)" <louis.stewart@ngc.com>
X-From: git-owner@vger.kernel.org Tue May 20 21:10:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmpQF-0005rV-D5
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 21:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbaETTJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 15:09:55 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36571 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaETTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 15:09:55 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 May 2014 15:09:54 EDT
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s4KJ1XNp006669;
	Tue, 20 May 2014 23:01:34 +0400
In-Reply-To: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD670@XMBVAG73.northgrum.com>
X-Mailer: Sylpheed 3.3.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249729>

On Tue, 20 May 2014 18:18:08 +0000
"Stewart, Louis (IS)" <louis.stewart@ngc.com> wrote:

> From you response then there is a method to only obtain the Project,
> Directory and Files (which could hold 80 GBs of data) and not the
> rest of the Repository that contained the full overall Projects?

Please google the phrase "Git shallow cloning".

I would also recommend to read up on git-annex [1].

You might also consider using Subversion as it seems you do not need
most benefits Git has over it and want certain benefits Subversion has
over Git:
* You don't need a distributed VCS (as you don't want each developer to
  have a full clone).
* You only need a single slice of the repository history at any given
  revision on a developer's machine, and this is *almost* what
  Subversion does: it will keep the so-called "base" (or "pristine")
  versions of files comprising the revision you will check out, plus
  the checked out files theirselves.  So, twice the space of the files
  comprising a revision.
* Subversion allows you to check out only a single folder out of the
  entire revision.
* IIRC, subversion supports locks, when a developer might tell the
  server they're editing a file, and this will prevent other devs from
  locking the same file.  This might be used to serialize editions of
  huge and/or unmergeable files.  Git can't do that (without
  non-standard tools deployed on the side or a centralized "meeting
  point" repository).

My point is that while Git is fantastic for managing source code
projects and project of similar types with regard to their contents,
it seems your requirements are mainly not suitable for the use case
Git is best tailored for.  Your apparent lack of familiarity with Git
might as well bite you later should you pick it right now.  At least
please consider reading a book or some other introduction-level
material on Git to get the feeling of typical workflows used with it.


1. https://git-annex.branchable.com/
