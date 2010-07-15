From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] revert: refactor code that prints success or failure message
Date: Thu, 15 Jul 2010 11:26:57 +0200
Message-ID: <201007151126.57840.chriscool@tuxfamily.org>
References: <20100712115455.12251.53947.chriscool@tuxfamily.org> <201007132302.59324.chriscool@tuxfamily.org> <20100713221620.GA4763@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 11:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZKij-00085y-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 11:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873Ab0GOJ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 05:27:01 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:13370 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866Ab0GOJ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 05:27:00 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id E69268000055;
	Thu, 15 Jul 2010 11:26:58 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id D6CE980005F7;
	Thu, 15 Jul 2010 11:26:58 +0200 (CEST)
Received: from style.localnet (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id B752D8000055;
	Thu, 15 Jul 2010 11:26:58 +0200 (CEST)
X-ME-UUID: 20100715092658751.B752D8000055@mwinf2f14.orange.fr
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100713221620.GA4763@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151064>

Hi,

On Wednesday 14 July 2010 00:16:20 Jonathan Nieder wrote:
> Christian Couder wrote:
> > I don't know about sh -x but there is this code in test-lib.sh to warn
> > about GIT_TRACE use:
> > 
> > case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
> > 
> > 	1|2|true)
> > 	
> > 		echo "* warning: Some tests will not work if GIT_TRACE" \
> > 		
> > 			"is set as to trace on STDERR ! *"
> > 		
> > 		echo "* warning: Please set GIT_TRACE to something" \
> > 		
> > 			"other than 1, 2 or true ! *"
> > 		
> > 		;;
> > 
> > esac
> 
> Oh!  I just remembered
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/146767
> 
> I guess the answer is we half-support it.  Maybe a test_cmp_err()
> helper to strip out xtrace[1] and GIT_TRACE[2] output is needed.

I don't understand the result of the above thread but when I try "bash -x 
t3508-cherry-pick-many-commits.sh" it works on my machine.
So I didn't change the tests.

> >> Summary: I was misled by the commit message.
> 
> [...]
> 
> > Ok, I will improve it.
> 
> Thanks, and sorry for the unfocused review.

No problem it's still better than no review :-)

Thanks,
Christian.
