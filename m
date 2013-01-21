From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Mon, 21 Jan 2013 07:43:40 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130121124340.GA32219@thyrsus.com>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
 <20130121093658.GD7498@serenity.lan>
 <20130121112853.GA31693@thyrsus.com>
 <20130121120010.GE7498@serenity.lan>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 21 13:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxGjq-0004cp-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 13:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3AUMoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 07:44:13 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37210
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab3AUMoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 07:44:12 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id DF5B444130; Mon, 21 Jan 2013 07:43:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130121120010.GE7498@serenity.lan>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214114>

John Keeping <john@keeping.me.uk>:
> I also disagree that cvsps outputs commits *newer* than T since it will
> also output commits *at* T, which is what I changed with the patch in my
> previous message.

Ah.  OK, that is yet another bug inherited from 2.x - the code doesn't
match the documented (and correct) behavior.  Please send me a patch
against the cvsps repo, I'll merge it.

> Perhaps it is simplest to just save a CVS_LAST_IMPORT_TIME file in
> $GIT_DIR and not worry about it any more.

Yes, I think you're right. Trying to carry that information in-band would
probably doom us to all sorts of bug-prone complications.

Thanks for the good analysis.  I wish everybody I had to chase bugs with
could explain them with such clarity and concision.

Sigh. Now I have to figure out if cvsps's behavior can be rescued in Chris
Rorvick's recently-discovered failure case. I'm not optimistic.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
