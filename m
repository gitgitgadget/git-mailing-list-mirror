From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Wed, 11 Feb 2009 18:08:22 +0100
Message-ID: <200902111808.22836.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902110127.18149.robin.rosenberg.lists@dewire.com> <7vwsbxizlg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIcJ-00012s-Au
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbZBKRJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZBKRJe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:09:34 -0500
Received: from mail.dewire.com ([83.140.172.130]:20944 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbZBKRJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:09:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3C06E147E8D3;
	Wed, 11 Feb 2009 18:09:26 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x6GrBWANS-jI; Wed, 11 Feb 2009 18:09:25 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 99A4380267C;
	Wed, 11 Feb 2009 18:09:25 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7vwsbxizlg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109447>

onsdag 11 februari 2009 01:31:07 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > onsdag 11 februari 2009 00:56:49 skrev Junio C Hamano:
> >> We failed to honor what the end user wanted: to repack.  Why should we
> >> exit 0 here?
> >
> > A repack may or may not yield a better packed repo. In this case, not,
> > but for a different reason than failing to find better deltas. Given the
> > circumstances that is most likely to cause the "failure (repacking on
> > windows), this is "normal" behaviour and no reason to scare the user
> > with an error code.
> 
> Up to this point, I felt my earlier misconception corrected, but then ...
> 
> > The unlink error might be enough.
> 
> ... I think we should not even show unlink errors, if "this is not an
> error, nothing to worry about" is the official stance about such failure;
> otherwise the errors will scare people, *and* others then doubly complain
> that even the command detects errors, the whole thing does *not* error
> out.

Hmm, ok drop the error at that point. But maybe we'd need to save it so we
can display it in case the recovery fails, in which case it may actually contain
some useful hint about went wrong.

-- robin
