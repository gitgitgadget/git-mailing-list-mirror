From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 23:25:30 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121128042529.GA3864@thyrsus.com>
References: <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <20121128032337.GB1669@thyrsus.com>
 <20121128033009.GA3931@sigill.intra.peff.net>
 <20121128034700.GD1669@thyrsus.com>
 <20121128040739.GA4115@sigill.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZDf-0002CH-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab2K1EZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:25:40 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59174
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab2K1EZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:25:40 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 4A59340661; Tue, 27 Nov 2012 23:25:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121128040739.GA4115@sigill.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210698>

Jeff King <peff@peff.net>:
> Felipe suggested using git-notes to add the metadata, which I think is a
> reasonable first step. The git side of the code is already written, and
> the concept is nicely modularized away from the core of git. Nobody has
> to care about it but your importer, and anybody who wants to query it[1]
> can do so by requesting the note.
> 
> -Peff
> 
> [1] And you do not have to limit yourself to timestamps, if there is
>     other metadata about each commit you end up wanting to store for a
>     clean bi-directional conversion.

I have actually wanted something like this quite badly.  Not so much
for timestamps (though that would be nice), but it would be useful if
each commit could carry a fossil-ID attribute that points at the
Subversion commit it was derived from.

I've tried to make notes work for this, but couldn't beat it into
doing what I was after.  Shawn, is there a way that the import stream
syntax can declare a note with in-line data attached to the commit where
it's declared?  

I tried just using the mark of the current commit, but git throws an error
because it thinks that mark is not yet declared when the note fileop
is parsed.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
