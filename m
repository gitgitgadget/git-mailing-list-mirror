From: John Keeping <john@keeping.me.uk>
Subject: Re: git-send-email doesn't deal with quoted names
Date: Tue, 28 May 2013 09:25:17 +0100
Message-ID: <20130528082517.GP27005@serenity.lan>
References: <CAHmME9p19eysjEVk+6FmAb2FQb7dq_e3k_KLQLRZqhx2Bs6O3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-From: git-owner@vger.kernel.org Tue May 28 10:25:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhFDq-0003T0-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 10:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933505Ab3E1IZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 04:25:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60011 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab3E1IZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 04:25:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2AE11CDA595;
	Tue, 28 May 2013 09:25:24 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T+Upcz2llcVA; Tue, 28 May 2013 09:25:22 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A2BBCCDA5DD;
	Tue, 28 May 2013 09:25:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAHmME9p19eysjEVk+6FmAb2FQb7dq_e3k_KLQLRZqhx2Bs6O3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225622>

On Tue, May 28, 2013 at 01:40:20AM +0200, Jason A. Donenfeld wrote:
> My commit author name is "Jason A. Donenfeld". Because this has a dot,
> SMTP handling likes to put it in quotes.
> 
> git-send-email has this line:
>             if (defined $author and $author ne $sender) {
> 
> With my name, this always winds up false, because it's comparing
> '"Jason A. Donenfeld" <Jason@zx2c4.com>' with 'Jason A. Donenfeld
> <Jason@zx2c4.com>'.
> 
> So, the logic needs to be fixed somehow.

There was a patch for this recently, although it appears to be still
under discussion:

    http://article.gmane.org/gmane.comp.version-control.git/225247
