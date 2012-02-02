From: Valerie Aurora <valerie.aurora@gmail.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Thu, 2 Feb 2012 10:00:02 -0800
Message-ID: <9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
References: <21056.1328185509@redhat.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt0xF-0000Mm-9k
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab2BBSAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:00:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53993 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab2BBSAJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 13:00:09 -0500
Received: by dadp15 with SMTP id p15so2034920dad.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=YdcV+62STxG8B/euSXrtkqgQ9/zAiQ8d4lWgBZbOaD4=;
        b=TGyvjAEALI2oaa12GG6J2SGkgFzL5ZJHFnttOWo3hPV7tCS+JUxatuRZPootHcNuSN
         a97hvZqgkOoJoB/Ad6pOh949CsVsoTtMZABm+B/1dKIsXkl57afjER4Dg/1LL3YoX5bh
         1MtfGfy4pVpBa3us8rhQeYpzBMPTjbo3VoK3g=
Received: by 10.68.224.9 with SMTP id qy9mr9530726pbc.102.1328205609509;
        Thu, 02 Feb 2012 10:00:09 -0800 (PST)
Received: from [10.242.196.113] (68.sub-174-253-224.myvzw.com. [174.253.224.68])
        by mx.google.com with ESMTPS id x8sm7128547pbr.11.2012.02.02.10.00.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 10:00:08 -0800 (PST)
In-Reply-To: <21056.1328185509@redhat.com>
X-Mailer: iPhone Mail (9A405)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189661>

On Feb 2, 2012, at 4:25, David Howells <dhowells@redhat.com> wrote:

> 
> Hi,
> 
> I've been assigned a stack of patches to maintain and try and get upstream by
> my employer.  Most of the patches currently have the authorship set to Val,
> but since I'll be maintaining them if they go in upstream and I've changed
> them a lot, I feel I should reassign the author field to myself so people
> pester me rather than Val with questions about them.  However, I don't want to
> deny Val or any other contributor credit for their work on the patches.
> 
> I can see a number of ways of doing this, and am wondering which will be best:
> 
> (1) Ascribe multiple authorship directly in the commit.  I suspect this would
>     require a change to GIT and its associated tools.  That way I could put my
>     name in the priority pestering spot, but doing a search on authorship
>     would still credit Val and others.
> 
> (2) Add an extra tag 'Originally-authored-by' (or maybe 'Coauthored-by' as I
>     saw someone recommend) in amongst the 'Signed-off-by' list.  But that
>     doesn't give them credit in a gitweb search without changing gitweb.
> 
> (3) Don't actually modify Val's commits to bring them up to date, but rather
>     create a historical GIT tree with Val's commits committed as-are and then
>     add my changes to the top in a number of large merge commits (there have
>     been multiple major breakages due to different merge windows).
> 
>     I dislike this approach because it doesn't produce a nice set of patches I
>     can give to someone to review (which is a must).  Plus, for the most part,
>     it's actually easier to port Val's patches individually.
> 
> Can GIT be modified to do (1)?  Gitweb's display need only show one of the
> authors in the single-row-per-patch list mode, but should find a patch by any
> of the authors in an author search and should display all the authors in the
> commit display.
> 
> David

Thanks, David!  I had the same trouble with my set: while I entirely rewrote some patches, I still felt Jan Blunck deserved primary credit.  I don't recall my solution, but I'm fine with mentioning my name in the commit message (and I think Jan should get credit too).

In general, this is a big problem for motivating contributors in other cases.  Some maintainers have a habit of trivially rewriting patches so that, technically, no line is the same, then taking authorship and giving the actual author an ambiguous Signed-off-by.  David hasn't done this here, of course - these are major rewrites - but when someone does all the hard work of finding and fixing a problem, the credit shouldn't go to the person who prettied it up.  There is a line in the kernel doc saying how this should be handled, suggested by Rusty, but it's not being followed.

First class support for multiple authorship would be a big way to motivate contributors.

-VAL