From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] revert: simplify insn parsing logic
Date: Tue, 3 Apr 2012 10:20:06 +0530
Message-ID: <CALkWK0nMx84G9_FdqFKp1j30bfV7mjHyD5paSHU5EgcsitGSEA@mail.gmail.com>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
 <1333029495-10034-4-git-send-email-artagnon@gmail.com> <7vr4w5euvg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 06:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEvhv-0006x8-5C
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 06:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab2DCEu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 00:50:28 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53610 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab2DCEu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 00:50:27 -0400
Received: by wejx9 with SMTP id x9so2110026wej.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 21:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nvHxL9Cb7VXAgz4HBrB7NlAh3hDdF1D15qmSV7iHCnM=;
        b=UDFOXs/KzgWhxlekUUkjjcvrCdHko+Go/U2VQMzJZaOyHR2pQsMbKwULq4+UjavAyR
         VjjEXq1AoYbahWAcAGHtVuBYzW9PzwhnzReyFdiSzraQ2+ZUeDTrdErneXrbYbqg4rhQ
         msLCC1X+X6pYZuAM8oY2vGBNo0ScUdZoZyqrxUAvgTZLo/5SeHCjl1S6n2EXVb+nNB9I
         dtSda8o740QBisgfLKO5gA4xbqndsr0M4I51UhWP+j8Ry8IEnnY7gVf//7ikvLPP7iEJ
         u6LpnAjamKQKxicKGt4xAJn2s0FLbc2aoHWvrHa4ABngNdtABrLuLyEzmw3E5QWWSExI
         0kmQ==
Received: by 10.180.102.101 with SMTP id fn5mr32403186wib.6.1333428626567;
 Mon, 02 Apr 2012 21:50:26 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Mon, 2 Apr 2012 21:50:06 -0700 (PDT)
In-Reply-To: <7vr4w5euvg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194592>

Hi Junio,

Junio C Hamano wrote:
> I suspect that this may be a bit over-engineered, but on the other hand,
> if we do not foresee that we would be adding many other verbs, I do not
> think there is much point in your patch to clean up the verb parsing part,
> either, so...

interesting; yes, it does look a little over-engineered for the
moment.  I should have been clearer in the commit message: this patch
exists mainly so that [4/4] can report a sensible error message
instead of a literal "Missing space after valid verb".  So, we have
four options from here:
1. Squash this part into [4/4].  Will this give rise to additional confusion?
2. Use your version of the patch.
3. Append the following to the commit message: "This patch exists so
that the next patch can report a sensible error message when an
invalid verb is encountered".
4. If you don't think [4/4] is valuable yet, just apply the first two
parts of this series.

I'm personally in favor of (1) now.

Thanks.

    Ram
