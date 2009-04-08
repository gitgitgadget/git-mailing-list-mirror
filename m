From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Wed, 8 Apr 2009 09:35:02 -0500
Message-ID: <b4087cc50904080735i6d56212fke3072a22da488fb@mail.gmail.com>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 16:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrYtO-0000cW-2u
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 16:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbZDHOfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 10:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZDHOfF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 10:35:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:8369 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZDHOfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 10:35:04 -0400
Received: by qw-out-2122.google.com with SMTP id 8so131999qwh.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s5JtPrhBZ8oeuP7WyNVh71eqih8h4wItwWKGpEQ2bsg=;
        b=PY/W1Fzm1keGIwohVqMMeA3CTurjY2RyxDvSqUJLeBwRQZMIts9veHF85RNmZ5aYHC
         LutmzFngJewaHSd62xHdoldRUVaOjbc24I+pQ0Ii1KfykVUqliBWTkE/gL/QcOrW1GdQ
         hTh/OVBMf7dQQPBGvgDnHaZ7QDCZcQBRX+vN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NbDQxecQ2JqCV3/PGv/O6KM0OZpTV2uXY2epmb+RB5kOLSYxLYgNFjPXvXKLzXlRAQ
         nfXlYvfxSY15U/rEuke3m3JXT+N6a/uIilCr2HVPlhJls0a3kvmAaUu7kechFO0a8xQ7
         WCWdD40MBe0IPhJVe2B++CA75W7Dpzz67Rl3M=
Received: by 10.224.67.130 with SMTP id r2mr1565119qai.284.1239201302612; Wed, 
	08 Apr 2009 07:35:02 -0700 (PDT)
In-Reply-To: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116084>

On Wed, Apr 8, 2009 at 09:25, Michael Witten <mfwitten@gmail.com> wrote:
> For instance, with
> a 14-patch series, one could set `--delay 60' and then let send-email
> run happily for the next 14 minutes with nary a thought.

As implemented, it would only take 13 minutes.

For a 5-patch series:

* Patch 1/5 sent
* delay 60 seconds
* Patch 2/5 sent
* delay 60 seconds
* Patch 3/5 sent
* delay 60 seconds
* Patch 4/5 sent
* delay 60 seconds
* Patch 5/5 sent
* send email exits immediately
