From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 13:15:13 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212181513.GA16960@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 19:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrAn9-00031f-OX
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 19:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab3LLSPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 13:15:15 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:40857
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3LLSPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 13:15:14 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id DB2B0380445; Thu, 12 Dec 2013 13:15:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239231>

Martin Langhoff <martin.langhoff@gmail.com>:
> On Wed, Dec 11, 2013 at 11:26 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> > You'll have to remind me what you mean by "incremental" here. Possibly
> > it's something cvs-fast-export could support.
> 
> User can
> 
>  - run a cvs to git import at time T, resulting in repo G
>  - make commits to cvs repo
>  - run cvs to git import at time T1, pointed to G, and the import tool
> will only add the new commits found in cvs between T and T1.

No, cvs-fast-export doesn't do that. However, it is fast enough that
you can probably just rebuild the whole repo each time you want to
move content. 

When I did the conversion of groff recently I was getting rates of
about 150 commits a second - and it will be faster now, because I
found an expensive operation in the output stage I could optimize
out.

Now that you have reminded me of this, I remember implementing a -i
option for cvsps-3.0 that could be combined with a time restriction 
to output incremental dumps. It's likely I could do the same
thing for cvs-fast-import.

> The above examples assume that the CVS repos have used "flying fish"
> approach in the "interesting" (i.e.: recent) parts of their history.
> 
> [ Simplifying a bit for non-CVS-geeks -- flying fish is using CVS HEAD
> for your development, plus 'feature branches' that get landed, plus
> long-lived 'stable release' branches. Most CVS projects in modern
> times use flying fish, which is a lot like what the git project uses
> in its own repo, but tuned to CVS's strengths (interesting commits
> linearized in CVS HEAD).
> 
> Other approaches ('dovetail') tend to end up with unworkable messes
> given CVS's weaknesses. ]

That terminology -- "flying fish" and "dovetail" -- is interesting, and
I have not heard it before.  It might be woth putting in the Jargon File.
Can you point me at examples of live usage?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
