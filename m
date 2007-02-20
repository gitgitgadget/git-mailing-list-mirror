From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 10:53:29 -0800
Message-ID: <86y7msr786.fsf@blue.stonehenge.com>
References: <86sld0sq7c.fsf@blue.stonehenge.com>
	<863b50snvv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 19:53:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJa7J-00078b-9z
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbXBTSxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbXBTSxa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:53:30 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:44212 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030356AbXBTSx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:53:29 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 588CE1DE376; Tue, 20 Feb 2007 10:53:29 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.9; tzolkin = 5 Muluc; haab = 2 Kayab
In-Reply-To: <863b50snvv.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Tue, 20 Feb 2007 10:08:20 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40254>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
Randal> If git wants to add local Perl modules, they belong in
Randal> ${prefix}/lib/perl/ or something, with the appropriate "use lib" added
Randal> to the Perl scripts.

Randal> Oddly enough, if I define NO_PERL_MAKEMAKER, I get the behavior I want.

Randal> I suggest that NO_PERL_MAKEMAKER is the *only* correct behavior in this case,
Randal> so I propose that the code be made unconditional, and the Makemaker stuff be
Randal> pulled out.

So, something spookier is happening on this solaris box then.  I can
see that if MakeMaker is used, the Makefile.PL is referring to INST_LIBDIR
which should indeed be private inside git's area.  And in fact, I can
verify on my laptop that Git.pm was indeed installed into /opt/git/lib/site_perl/5.8.8/

I don't know why this isn't working on solaris. :( It might be that the
MakeMaker is too old, and doesn't respect the same prefix elements.

Call off the hounds... I can locally work around it by setting
NO_PERL_MAKEMAKER, and suspect I won't have anything further to contribute to
the core on this matter.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
