From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use the config file to set repository owner's
	name.
Date: Fri, 8 Feb 2008 14:07:57 -0200
Message-ID: <20080208160757.GA11965@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> <20080208135327.GC30264@c3sl.ufpr.br> <20080208143027.GA707@c3sl.ufpr.br> <200802081633.55934.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 17:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNVmx-0005k1-C1
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbYBHQI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757344AbYBHQI3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:08:29 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:48302 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbYBHQI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:08:28 -0500
Received: from localhost (unknown [189.1.130.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 96983700003CB;
	Fri,  8 Feb 2008 14:08:25 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <200802081633.55934.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73102>

On Fri, Feb 08, 2008 at 04:33:54PM +0100, Jakub Narebski wrote:
> I have joined the two emails to reply only once.
> 
> On Fri, 8 Feb 2008, Bruno Cesar Ribas wrote:
> > On Fri, Feb 08, 2008 at 02:55:33AM -0800, Jakub Narebski wrote:
> >> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> >>> 
> >>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >>> index 8ef2735..e8a43b7 100755
> >>> --- a/gitweb/gitweb.perl
> >>> +++ b/gitweb/gitweb.perl
> >>> @@ -1767,7 +1767,12 @@ sub git_get_project_owner {
> >>>       if (exists $gitweb_project_owner->{$project}) {
> >>>               $owner = $gitweb_project_owner->{$project};
> >>>       }
> >>> -     if (!defined $owner) {
> >>> +
> >>> +     if (!defined $owner){
> >>> +             $owner = git_get_project_config('owner');
> >>> +     }
> >>> +
> >>> +     if (!$owner) {
> >>>               $owner = get_file_owner("$projectroot/$project");
> >>>       }
> 
> Another comment: why did you change from checking of "!defined $owner"
> to checking "!$owner"? git_get_project_config('owner') returns undef
> if gitweb.owner is not defined. With checking for defined we can avoid
> false positives of owner being "0" (in practice I think this does not
> matter) or "" (this could happen if somebody doesn't want for project
> to have owner shown).

When I tested it returned empty, but i found out it was lack of NAME for the
user i was running tests.

> 
> 
> > I'll resend [...] with $git_dir set.
> 
> And with signoff corrected, I assume?

of course.
> 
> Please try to check if the code works with and without gitweb.owner set 
> before sending new version of the patch...

I always do that.
> -- 
> Jakub Narebski
> Poland

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
