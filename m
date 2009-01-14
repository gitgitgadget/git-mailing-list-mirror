From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] gitweb: recognize six digit abbreviated SHA1
Date: Wed, 14 Jan 2009 13:33:33 +1300
Message-ID: <496D32DD.9010303@vilain.net>
References: <87mydw2hrb.fsf@cup.kalibalik.dk> <87mydw2hkb.fsf@cup.kalibalik.dk> <496BF5D7.2090003@vilain.net> <7vd4erd32a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMtjQ-0000dN-QT
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 01:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760964AbZANAdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 19:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760956AbZANAdl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 19:33:41 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:59923 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760928AbZANAdk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 19:33:40 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id ABC6321C7E1; Wed, 14 Jan 2009 13:33:38 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 4228421C652;
	Wed, 14 Jan 2009 13:33:34 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7vd4erd32a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105567>

Junio C Hamano wrote:
> When people give an abbreviated object name, 99% of the time they mean
> commits (and "index deadbeef..acebead" in a patch is a good place to pick
> blob object names from, which would be what the 99% of the remaining 1%
> would name), so making sure it is a commit or a blob would be a very
> sensible thing to do.
>
> Unfortunately, you fundamentally cannot do this without taking a
> performance hit of actually opening the object.
>   

Yeah. I envisioned this just for those cases where the tool would
otherwise return 'ambiguous argument'; if there was a hint as to the
object type, open *all* the matching objects and return the one that
matched the type only.

Sam.
