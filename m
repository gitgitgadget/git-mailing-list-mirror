From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 13:29:32 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212182932.GB16960@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 19:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrB10-0005fB-8z
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 19:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab3LLS3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 13:29:34 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:40959
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3LLS3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 13:29:33 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 8722B380445; Thu, 12 Dec 2013 13:29:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131212171756.GA6954@inner.h.apk.li>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239232>

Andreas Krey <a.krey@gmx.de>:
> But anyway, the replacement question is a) how fast the cvs-fast-export is
> and b) whether its output is stable, that is, if the cvs repo C yields
> a git repo G, will then C with a few extra commits yield G' where every
> commit in G (as identified by its SHA1) is also in G', and G' additionally
> contains the new commits that were made to the CVS repo.
> 
> If that is the case you effectively have an incremental mode, except that
> it's not quite as fast.

I am almost certain the output of cvs-fast-export is stable.  I
believe the output of cvsps-3.x was, too.  Not sure about 2.x.

I wrote the output stages for both cvsps-3.x and cvs-fast-export, and
went to some effort to verify that they write streams in the same
"most natural" way - marks sequential from :1, blobs always witten as
late as possible, fileops in the same sort order the git tools emit,
etc.

I have added writing a regression test test to verify the stability
property to the TODO list. I will have this nailed down before the
next point release, in a few days.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
