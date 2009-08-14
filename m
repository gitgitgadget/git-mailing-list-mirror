From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Fri, 14 Aug 2009 15:39:14 -0500
Message-ID: <200908141539.18087.luke@dashjr.org>
References: <200908121726.52121.luke-jr@utopios.org> <200908132306.37947.trast@student.ethz.ch> <7vws56i35q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3Ys-0003tA-1W
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbZHNUje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 16:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbZHNUje
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:39:34 -0400
Received: from unused ([66.216.20.21]:47666 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbZHNUjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:39:33 -0400
Received: from tsuruki.localnet (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id 9FEA0B9C252;
	Fri, 14 Aug 2009 20:39:25 +0000 (UTC)
User-Agent: KMail/1.12.0 (Linux/2.6.27-gentoo-r7; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vws56i35q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125950>

On Friday 14 August 2009 02:52:33 pm Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > Junio C Hamano wrote:
> >> Chould you refresh my memory a bit?
> >>
> >> In what circumstance is "rm --ignore-unmatch" useful to begin with?
> >
> > Not sure about add --ignore-unmatch myself, but there's even an
> > example of rm --ignore-unmatch in man git-filter-branch, along the
> > lines of
> >
> >   git filter-branch --index-filter '
> >     rm --ignore-unmach some_file_that_shouldnt_be_in_history
> >   ' -- --all
>
> Ah, that makes sense.  I am not sure about "add --ignore-unmatch" myself
> either, and an example similar to the above filter-branch would not apply
> very easily (i.e. "add a file that should have been in history" would not
> need --ignore-unmatch).

The purpose of "add --ignore-unmatch" is to ignore race conditions where one 
of the files to be added has been deleted after git is executed, but before 
git scans it.
