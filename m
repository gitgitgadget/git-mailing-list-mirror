From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 20:54:24 +0200
Message-ID: <87ljtdk9b3.fsf@iki.fi>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de>
	<200901120947.13566.trast@student.ethz.ch>
	<7vprisj26i.fsf@gitster.siamese.dyndns.org>
	<adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
	<alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNAuS-0003tE-J3
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbZANSyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbZANSyq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:54:46 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55197 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbZANSyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:54:45 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8803BCA981; Wed, 14 Jan 2009 20:54:27 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LNAsi-0000gU-Tz; Wed, 14 Jan 2009 20:54:24 +0200
In-Reply-To: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 14 Jan 2009 18\:49\:31 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105680>

Johannes Schindelin (2009-01-14 18:49 +0100) wrote:

> Can anybody think of undesired behavior as a consequence?
>
> Johannes Schindelin (4):
>   Add color_fwrite_lines(), a function coloring each line individually
>   color-words: refactor word splitting and use ALLOC_GROW()
>   color-words: change algorithm to allow for 0-character word
>     boundaries
>   color-words: take an optional regular expression describing words

There is something I don't understand. Maybe it's a bug or maybe it's my
limitation. I'd appreciate if you care to explain the reason of the
following output. Suppose we have two files and the line diff looks like
this:

    --- 1/a
    +++ 2/b
    @@ -1 +1 @@
    -aaa (aaa)
    +aaa (aaa) aaa

With --color-diff=a+ it looks like 

    aaa (aaa)aaa) aaa
         ^^^^~~~~ ~~~

^ = red, ~ = green

Why show changes in the "aaa)" part when it didn't actually change?
