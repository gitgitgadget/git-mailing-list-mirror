From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9600: require cvsps 2.1 to perform tests
Date: Tue, 4 Dec 2007 10:44:54 -0500
Message-ID: <20071204154454.GA2994@coredump.intra.peff.net>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site> <20071203015954.GB8322@coredump.intra.peff.net> <47548CEC.6010701@gmail.com> <7vir3fe54c.fsf@gitster.siamese.dyndns.org> <20071204014145.GA20145@coredump.intra.peff.net> <7v1wa3aukt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZxV-0008Bs-Ki
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbXLDPo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbXLDPo5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:44:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2025 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbXLDPo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:44:56 -0500
Received: (qmail 7881 invoked by uid 111); 4 Dec 2007 15:44:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Dec 2007 10:44:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2007 10:44:54 -0500
Content-Disposition: inline
In-Reply-To: <7v1wa3aukt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67058>

On Mon, Dec 03, 2007 at 09:37:54PM -0800, Junio C Hamano wrote:

> I wonder if it is better to grep for ' [-A] ' instead, like:
> 
> cvsps_supports_A=$(cvsps -h 2>&1 | sed -ne '/\[-A\]/p')
> case "$cvsps_supports_A" in
> '')
> 	say 'skipping cvsimport tests, lacking cvsps that supports -A option'
> 	test_done
>         exit
> esac

I am not too opposed to that, but I felt that checking the version was a
little bit more future proof. I.e., I have no idea if it is only -A that
we need, but I know that 2.1 works and prior to 2.1 doesn't.

-Jeff
