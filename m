From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 8/7] cat-file: sort and de-dup output of
 --batch-all-objects
Date: Mon, 22 Jun 2015 23:03:50 +0100
Message-ID: <20150622220350.GB18677@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
 <20150622103321.GB12584@peff.net>
 <20150622110632.GA26436@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:03:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79os-0002dD-6l
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbbFVWDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:03:55 -0400
Received: from avasout06.plus.net ([212.159.14.18]:36581 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbFVWDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:03:53 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id ja3q1q0022iA9hg01a3rT3; Mon, 22 Jun 2015 23:03:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=foEhHwMf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=xFIPubV5JKScwtMo3_wA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z79ok-0004vJ-PD; Mon, 22 Jun 2015 23:03:50 +0100
Content-Disposition: inline
In-Reply-To: <20150622110632.GA26436@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272426>

On Mon, Jun 22, 2015 at 07:06:32AM -0400, Jeff King wrote:
> On Mon, Jun 22, 2015 at 06:33:21AM -0400, Jeff King wrote:
> 
> > By the way, in addition to not showing objects in order,
> > list-all-objects (and my cat-file option) may show duplicates. Do we
> > want to "sort -u" for the user? It might be nice for them to always get
> > a de-duped and sorted list. Aside from the CPU cost of sorting, it does
> > mean we'll allocate ~80MB for the kernel to store the sha1s. I guess
> > that's not too much when you are talking about the kernel repo. I took
> > the coward's way out and just mentioned the limitation in the
> > documentation, but I'm happy to be persuaded.
> 
> The patch below does the sort/de-dup. I'd probably just squash it into
> patch 7, though.

Woah, 8 out of 7! Did you get a chance to measure the performance hit of
the sort? If not, I may test it out when I next get the chance.
