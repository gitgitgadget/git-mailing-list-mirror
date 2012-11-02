From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 10:48:27 -0400
Message-ID: <20121102144827.GB11170@sigill.intra.peff.net>
References: <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
 <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net>
 <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
 <509149D9.3070606@drmicha.warpmail.net>
 <CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com>
 <CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com>
 <CAMP44s3UHQE69O__EVK29uN_VPdZN=a0-Gczeh-Tbjp1ZAAbJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIY7-0005WR-69
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab2KBOsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:48:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54563 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab2KBOsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 10:48:30 -0400
Received: (qmail 5136 invoked by uid 107); 2 Nov 2012 14:49:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 10:49:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 10:48:27 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3UHQE69O__EVK29uN_VPdZN=a0-Gczeh-Tbjp1ZAAbJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208941>

On Thu, Nov 01, 2012 at 05:08:52AM +0100, Felipe Contreras wrote:

> > Turns out msysgit's remote-hg is not exporting the whole repository,
> > that's why it's faster =/
> 
> It seems the reason is that it would only export to the point where
> the branch is checked out. After updating the to the tip I noticed
> there was a performance difference.
> 
> I investigated and found two reasons:
> 
> 1) msysgit's version doesn't export files twice, I've now implemented the same
> 2) msysgit's version uses a very simple algorithm to find out file changes
> 
> This second point causes msysgit to miss some file changes. Using the
> same algorithm I get the same performance, but the output is not
> correct.

Do you have a test case that demonstrates this? It would be helpful for
reviewers, but also helpful to msysgit people if they want to fix their
implementation.

-Peff
