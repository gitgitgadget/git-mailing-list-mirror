From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 10:08:20 -0800
Message-ID: <863b50snvv.fsf@blue.stonehenge.com>
References: <86sld0sq7c.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 19:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZPd-0003Hm-6O
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbXBTSIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbXBTSIW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:08:22 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:31705 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030338AbXBTSIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:08:21 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id EDD571DE9D2; Tue, 20 Feb 2007 10:08:20 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.9; tzolkin = 5 Muluc; haab = 2 Kayab
In-Reply-To: <86sld0sq7c.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Tue, 20 Feb 2007 09:18:15 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40248>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> If git wants to add local Perl modules, they belong in
Randal> ${prefix}/lib/perl/ or something, with the appropriate "use lib" added
Randal> to the Perl scripts.

>From a bit further research, it looks like git prefers installing git-only
Perl modules using the standard MakeMaker, which of course will try to
install them in site_lib.

Oddly enough, if I define NO_PERL_MAKEMAKER, I get the behavior I want.

I suggest that NO_PERL_MAKEMAKER is the *only* correct behavior in this case,
so I propose that the code be made unconditional, and the Makemaker stuff be
pulled out.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
