From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 22:18:03 +0200
Message-ID: <20090402201803.GA5397@pvv.org>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com> <20090402134414.GB26699@coredump.intra.peff.net> <7vab6zexq7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:19:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpTO5-0002m8-70
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbZDBUSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762713AbZDBUSM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:18:12 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:52577 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760111AbZDBUSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 16:18:11 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LpTMR-0004P2-Fd; Thu, 02 Apr 2009 22:18:03 +0200
Content-Disposition: inline
In-Reply-To: <7vab6zexq7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115495>

On Thu, Apr 02, 2009 at 11:06:56AM -0700, Junio C Hamano wrote:
> [...]
> 
> I gave the patch an only cursory look, so I wouldn't comment on the
> implementation; two things I would look at in the code would be if it
> makes two connections to the remote to learn the same information (which
> would be bad)

How bad? git remote update execs "git fetch <remote>" to do the
fetching part, and after that the information is lost of course.  It
might be possible to do a --prune option to fetch instead, and just
use that directly.

>  and if it skips the pruning stage if the update stage failed
> (which would probably be a sane precaution).

Yes, this should be fixed.

- Finn Arne
