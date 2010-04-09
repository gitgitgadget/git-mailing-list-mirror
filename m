From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Status of all files (was: Re: How can I tell if a file is ignored by git?
Date: Fri, 09 Apr 2010 05:11:12 -0700
Message-ID: <864ojkx1un.fsf@red.stonehenge.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
	<j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
	<20100409113248.GB27353@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Apr 09 14:18:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0DAO-00064C-8l
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 14:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab0DIMS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 08:18:27 -0400
Received: from red.stonehenge.com ([208.79.95.2]:57004 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0DIMS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 08:18:26 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2010 08:18:26 EDT
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id AF8D487D4; Fri,  9 Apr 2010 05:11:12 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.4.13; tzolkin = 5 Ben; haab = 6 Pop
In-Reply-To: <20100409113248.GB27353@thyrsus.com> (Eric Raymond's message of
	"Fri, 9 Apr 2010 07:32:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144427>

>>>>> "Eric" == Eric Raymond <esr@thyrsus.com> writes:

Eric> There could be something better.  Emacs VC mode, and other similar
Eric> front ends, would be greatly aided by a command that lists all files,
Eric> each with a status code it can understand.  Our canonical list
Eric> (omitting two that apply only to locking systems) is:

A lot of these don't make sense for git and other DVCS.  How have
hg and bzr interpreted these "canonical" states?

For example:

Eric>   'needs-update      The file has not been edited by the user, but there is
Eric>                      a more recent version on the current branch stored
Eric>                      in the master file.

This makes sense only with a file-based VCS, not a tree-based VCS like
git.

Eric>   'needs-merge       The file has been edited by the user, and there is also
Eric>                      a more recent version on the current branch stored in
Eric>                      the master file.  This state can only occur if locking
Eric>                      is not used for the file.

Ditto.

Eric>   'removed           Scheduled to be deleted from the repository
Eric>   on next commit.

Not useful in git.

Eric>   'missing           The file is not present in the file system, but the VC
Eric>                      system still tracks it.

Not available in git.  (If it's not a real file, it can't be tracked. :)

Eric>   'ignored           The file showed up in a dir-status listing with a flag
Eric>                      indicating the version-control system is ignoring it,

Eric>   'unregistered      The file is not under version control.

These two would be identical in git.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
