From: Mike Hommey <mh@glandium.org>
Subject: Re: confused about preserved permissions
Date: Tue, 21 Aug 2007 07:34:51 +0200
Organization: glandium.org
Message-ID: <20070821053451.GA11153@glandium.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <853ayeos82.fsf@lola.goethe.zz> <20070820205042.GB10173@glandium.org> <20070821013541.GC27913@spearce.org> <7vejhxproc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 07:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INMPL-00055c-Gu
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 07:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXHUFfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 01:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbXHUFfy
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 01:35:54 -0400
Received: from vawad.err.no ([85.19.200.177]:35615 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305AbXHUFfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 01:35:53 -0400
Received: from aputeaux-153-1-3-249.w82-124.abo.wanadoo.fr ([82.124.49.249] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INMP4-0006z4-ND; Tue, 21 Aug 2007 07:35:47 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INMOB-0002uM-6V; Tue, 21 Aug 2007 07:34:51 +0200
Content-Disposition: inline
In-Reply-To: <7vejhxproc.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56277>

On Mon, Aug 20, 2007 at 07:06:27PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> That is almost true, but there is one factual error I need to
> correct.
> 
> In-tree representation of the mode is not actually "%06o" but
> just "%o".  In very early days of git, we used to have extra
> leading "0" in trees (e.g. "040000"), but that is something
> modern fsck even warns about.  IOW, it is not the norm.
> 
> It is represented as text because we _can_ add any number of
> bits to the data later if we wanted to.  Basic tree objects that
> contain only the kind of data we traditionally used will
> continue to work, while trees that contain (yet to be invented)
> new types that are represented with longer mode bits may of
> course not be read by older tools.
(...)

That makes sense. (BTW, I must have misremembered the %06o thing,
because my script to hash random trees does use %o).

Anyways, that still doesn't say why all these permission bits are kept
while only the executable bit matters, though it must be related to
backwards compatibility of hashes.

I'd also like to head about why git-archive doesn't set permissions like
the manpage says (see my first post in the thread)

Mike
