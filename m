From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 12:27:18 -0500
Message-ID: <b4087cc50904091027l4656a6adv6a72bad0a747cdc1@mail.gmail.com>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
	 <20090409161756.GA12910@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lry3a-0001oT-VR
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbZDIR1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757051AbZDIR1V
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:27:21 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:63370 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbZDIR1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:27:20 -0400
Received: by qyk16 with SMTP id 16so1521270qyk.33
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ARXYd/PdWgUKYoDFB+jMQrSQLDuk7vmeWaLxAyHNGJ0=;
        b=YqoLUPhA3ccn5QcSnUJTof++SDEW/9x/hKq8P3W6f/6qDTLeq28gUmH61qlUoybvbK
         0HEbFUg6cv/WJ3II9F2tMBvtg1a+0JgjVhDv9+TQlc4FszJeKI2w1pRjK36zCGT0JnlM
         Q/LnPcu41GMS6+sSRW48ncNNvayaQRBGUvJQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ORNKI/YeomR7+1cDI4zW25zPWTU9Os6KYTBbwpcMNHmEVrtccSdl+MQbPJwHNESCHf
         vy8gKrLE+a8xRSeP3komu+PviK8Z505r9LH+8vKcycCyNiHQUvNlTIDd6pWGAtfzBbU+
         K/17QIIEAIZtsFYWzdcocaSnF5w/K8+aZ1fFE=
Received: by 10.224.80.195 with SMTP id u3mr3149100qak.352.1239298038382; Thu, 
	09 Apr 2009 10:27:18 -0700 (PDT)
In-Reply-To: <20090409161756.GA12910@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116184>

On Thu, Apr 9, 2009 at 11:17, Nicolas Sebrecht
<nicolas.s-dev@laposte.net> wrote:
>
> The --delay option may have an undesirable side effect. In case of
> non-chained emails, unrelated mails could be insterted between patches
> where *all* MUA would be affected. It's not only true for very high
> volume message mailing-lists (million monkeys receiving...). FMPOV, it's
> worse than all display issues we already know or have with the current
> behaviour.

But it's already impossible to protect against this scenario. In that
situation, the smallest delay possible is desired, so --delay wouldn't
even be used (that is, its value would be zero). However, the transit
delay could never be small enough to guarantee that no other emails
are inserted into the patch series, so the only solution is to chain
them. At this point, we're back to the problem of arrival time, and
hence --delay becomes useful.

:-D
