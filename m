From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/1] get_sha1_hex(): do not read past a NUL character
Date: Wed, 5 Oct 2011 21:11:52 +0200
Message-ID: <201110052111.52701.trast@student.ethz.ch>
References: <4E7C857D.8000304@alum.mit.edu> <1316785116-21831-1-git-send-email-mhagger@alum.mit.edu> <7vaa9vulsw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 21:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBWss-00019p-Uv
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 21:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934329Ab1JETL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 15:11:58 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:42588 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933236Ab1JETL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 15:11:58 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 5 Oct
 2011 21:11:55 +0200
Received: from thomas.inf.ethz.ch (129.132.208.47) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 5 Oct
 2011 21:11:55 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vaa9vulsw.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.208.47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182877>

Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > Previously, get_sha1_hex() would read one character past the end of a
> > null-terminated string whose strlen was an even number less than 40.
> > Although the function correctly returned -1 in these cases, the extra
> > memory access might have been to uninitialized (or even, conceivably,
> > unallocated) memory.
> >
> > Add a check to avoid reading past the end of a string.
> 
> Makes sense; thanks.

Has this fixed patch ever made it to pu?  I'm still seeing the same
breakage in the automated valgrind runs.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
