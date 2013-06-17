From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: GIt error
Date: Mon, 17 Jun 2013 17:47:07 +0400
Message-ID: <20130617174707.0c44a25130ec28baca9f3e61@domain007.com>
References: <E7FBE41B36DC254CB796CE1D6D45B14A0FAE034D@048-CH1MPN1-032.048d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <justin.sathyanathan@accenture.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 15:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZmA-0005VC-7g
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab3FQNrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 09:47:14 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36537 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab3FQNrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 09:47:13 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r5HDl7WF027559;
	Mon, 17 Jun 2013 17:47:08 +0400
In-Reply-To: <E7FBE41B36DC254CB796CE1D6D45B14A0FAE034D@048-CH1MPN1-032.048d.mgd.msft.net>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228069>

On Mon, 17 Jun 2013 13:28:30 +0000
<justin.sathyanathan@accenture.com> wrote:

> For Below issue , O/S is Windows7.
[...]
> 1.Iam getting error attached when cloning of repository is done:

What error?

> 2.Also, when file is tried to be added,it gives error below:
> 
> $ git add *
> fatal: unable to stat
> 'src/development_architecture/integration_application_proj
> ect_template/provider_archetype/provider_archetype/src/main/resources/archetype-
> resources/__rootArtifactId__-data/src/main/java/com/accenture/afpj/sample/skelet
> on/visitor/data/VisitorRepositoryJpaImpl.java': Filename too long
[...]

This is a limitation of Git for Windows: the standard Windows API which
works with unmangled filenames limits their length to 260 characters
while your particular entry is 262 characters long.

AFAIK, there's no clean/easy way to make use of "extended" Windows API
which requires mangling filenames by adding the "\\?\" to them.

You could read [1] for more details.

So it seems you have two options for now:

* Restructure the project.
* Use Git under Cygwin [2] which might not have this limitation
  (personally, I do not know whether it does).

P.S.

Please next time you ask consider doing two things:
* If you post your message to several groups, take care to mention this
  fact in each of them.
* Do not require anyone to do anything "ASAP" unless this claim is
  backed by your or your employer's wallet.

1. http://msdn.microsoft.com/en-us/library/aa365247#maxpath
2. http://cygwin.com/packages/git/
