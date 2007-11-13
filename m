From: Dan Zwell <dzwell@gmail.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from
 .gitconfig
Date: Mon, 12 Nov 2007 20:55:13 -0600
Message-ID: <47391211.5000606@zwell.net>
References: <47112491.8070309@gmail.com>	<20071015034338.GA4844@coredump.intra.peff.net>	<20071016194709.3c1cb3a8@danzwell.com>	<20071017015152.GN13801@spearce.org>	<20071022164048.71a3dceb@danzwell.com>	<20071023042702.GB28312@coredump.intra.peff.net>	<20071023035221.66ea537f@danzwell.com>	<20071102224100.71665182@paradox.zwell.net>	<20071104045735.GA12359@segfault.peff.net>	<7v640ivagv.fsf@gitster.siamese.dyndns.org>	<20071104054305.GA13929@sigill.intra.peff.net>	<20071110202351.7b4544aa@paradox.zwell.net>	<7vve89f6qy.fsf@gitster.siamese.dyndns.org>	<47390050.1020907@zwell.net> <7v4pfq27tx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@gmail.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 03:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irlwz-000457-0h
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 03:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXKMC4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 21:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbXKMC4N
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 21:56:13 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:9675 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbXKMC4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 21:56:13 -0500
Received: by py-out-1112.google.com with SMTP id u77so1672660pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 18:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=GW73X3Sv2zSPapGWEckg0oCVJEKmnVYkwg9mQAjaaSI=;
        b=Pftu33G0ywHoIHiyP+qK+S9zV9Q8jskIxO9NqB26QNhdSyq8ssJotyf3f6hypmTjVWZYlgsjAuXBvRg5KvGNbT8j+NEqV5ht23wccMFyRpsROKvZ28XzzVzgtaDUPRdcM0A6hw9p4Q2sOXtcPoPGkMiKyMCU3f4+EleK23g1uFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=jboQhfD7PA2wjkzk47sKIB8IbQ2Z2EHxsPujNhjhiDkZVOZbMhs5P3pH5QcBgXcNtnWLuvBhPJZSoOWlnLr1D4khFFU04fWxHDiHEV9FhBjlWPt/Qqo9sOZFFP+sLTBWe90GSU3N+3PT+R5dDOxAehGLOCeXo6lrfLMLAhIayK0=
Received: by 10.35.109.2 with SMTP id l2mr6854589pym.1194922570391;
        Mon, 12 Nov 2007 18:56:10 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id n44sm11598101pyh.2007.11.12.18.56.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Nov 2007 18:56:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <7v4pfq27tx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64744>

Junio C Hamano wrote:
> I suggested the hash approach only because (1) it is easier to
> read than two regexp matches that are split only to keep the
> line less than 80-chars long, and (2) a misconfiguration like
> "color.foo = fred" can be caught more easily.
> 
> I do not quite understand the "after all, we're pattern
> matching" part, though.  Are you talking about "split(/\s+/, $str)" 
> your for-loop iterates over?
> 

I think we're talking about the same thing. I was referring to the split 
regular expression, and the question is, "for the current element of 
split(/\s+/, $str), does it match a color?"

Anyway, I preferred the regex version for readability, though I should 
have used the /x modifier--it would still take two lines, but it would 
not need to attempt two matches. As for misconfigured color 
configurations, should we catch that? I wrote this with the intent that 
it should ignore invalid color names, but it would probably be more 
useful to print a warning.

Dan
