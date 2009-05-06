From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file to sed
Date: Wed, 06 May 2009 14:49:15 -0700
Message-ID: <7vpreluckk.fsf@alter.siamese.dyndns.org>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil>
	<7vhbzyukyi.fsf@alter.siamese.dyndns.org>
	<RsLiW_EIDQ01u5uSMUrIIMzSbMhkfwGJBEGppONH79Im4WyT76bS5A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 00:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1pRq-0000oO-IA
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763531AbZEFWSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763552AbZEFWSY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:18:24 -0400
Received: from fed1rmmtai104.cox.net ([68.230.241.56]:40615 "EHLO
	fed1rmmtai104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761458AbZEFWSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:18:22 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506214916.TBEM2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Wed, 6 May 2009 17:49:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id oMpF1b00C4aMwMQ04MpFZ1; Wed, 06 May 2009 17:49:15 -0400
X-Authority-Analysis: v=1.0 c=1 a=1ZMnSAeqFEcA:10 a=KrguOZ7mv_8A:10
 a=mWJME7gpGU2PeVGGze0A:9 a=qgJ2LRurZjNURVqYaSI88A2lI2EA:4
X-CM-Score: 0.00
In-Reply-To: <RsLiW_EIDQ01u5uSMUrIIMzSbMhkfwGJBEGppONH79Im4WyT76bS5A@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 06 May 2009 16\:12\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118395>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The 'sha1' variable that is set here on line 193 is used on the next line
> to set 'rr', but 'rr' is never used again.  Unless I'm missing something,
> it appears these two lines can be deleted.

Yeah, it looks like this is a mindless cut&paste; I do not see the point
of setting rr there unless it is used to make sure that a corresponding
rerere cache is created, or something.
