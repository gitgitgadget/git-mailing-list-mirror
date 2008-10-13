From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Mon, 13 Oct 2008 08:10:38 +0200
Message-ID: <48F2E65E.50506@viscovery.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net> <48EB7D74.40302@viscovery.net> <20081007153543.GA26531@coredump.intra.peff.net> <7vabdaidwj.fsf@gitster.siamese.dyndns.org> <20081013012311.GE3768@coredump.intra.peff.net> <7vk5cddtzh.fsf@gitster.siamese.dyndns.org> <20081013041525.GA32629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 08:12:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpGen-0001PQ-BD
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 08:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYJMGKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 02:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbYJMGKm
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 02:10:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57587 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbYJMGKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 02:10:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KpGda-0004GQ-P5; Mon, 13 Oct 2008 08:10:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 87F9354D; Mon, 13 Oct 2008 08:10:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081013041525.GA32629@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98084>

Jeff King schrieb:
> On Sun, Oct 12, 2008 at 09:00:50PM -0700, Junio C Hamano wrote:
>>  - You teach git-apply to use a reverse transformation of textconv, so
>>    that it does, upon reception of a textconv diff:
>>
>>    (1) pass existing preimage through textconv;
>>    (2) apply the patch;
>>    (3) convert the result back to binary.
> 
> The problem with this approach is that it requires that the textconv be
> a reversible mapping. And the two motivating examples (dumping exif tags
> and converting word processor documents to text) are not; they are lossy
> conversions.
> 
> It's possible that one could, given the binary preimage and the two
> lossy textconv'd versions, produce a custom binary merge that would just
> munge the tags, or just munge the text, or whatever. But that is an
> order of magnitude more work than writing a textconv, which is usually
> as simple as "/path/to/existing/conversion-script".

I fully agree with you. .texconv should only be used for human
consumption. We already have a reversible binary<->text conversion: the
binary diffs.

-- Hannes
