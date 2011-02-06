From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 6 Feb 2011 18:17:07 +0300
Message-ID: <AANLkTinDmCZH95jidJ1NYFRd8X_xNehyrhA8hBcx5=SR@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102050218.44325.johan@herland.net>
	<20110205214045.GA15668@dpotapov.dyndns.org>
	<201102060104.37146.johan@herland.net>
	<AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
	<alpine.LFD.2.00.1102060900570.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Feb 06 16:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm6MX-0007Dl-5w
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 16:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab1BFPRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 10:17:09 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44459 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab1BFPRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 10:17:08 -0500
Received: by qyj19 with SMTP id 19so953857qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vk1AF+TQe3EWLzq+RRdSX2sCZLiMJo6RkCe9HH6wLts=;
        b=h+2uBI0djKPdrYcF2G6fRhHeXMjjWfaLm2NorNFUm/ntm6l4B/Hd2Y8oBU6Rozejy7
         QoNclzBObIs/7nsllAye8YlXaALYa+kKEI3rOSfDS0B9xuLD09W099bc0XOOOh/uUSsZ
         bdnDt/oCXKy1UG3+Q+U6GyuvbBpevQwLG9A/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=e7NPuBMamJpzVnF822OqKJQjO3M5+BMi4Esbg86pRKqU2Q2gPlO3Qe6w7ngXdzjBWM
         RJM4elzHsGUtyESQQG7Oxp7wIVT8C657EosO1Xg2cChVEQRKp8sj9pYsbicPXpwZVDoV
         t1HP39bUoZiK7MB5sFW3qW0FnzFWnKcwyBfcg=
Received: by 10.229.220.133 with SMTP id hy5mr11966843qcb.269.1297005427296;
 Sun, 06 Feb 2011 07:17:07 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Sun, 6 Feb 2011 07:17:07 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1102060900570.12104@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166149>

On Sun, Feb 06, 2011 at 09:09:26AM -0500, Nicolas Pitre wrote:
> On Sun, 6 Feb 2011, Dmitry Potapov wrote:
>_
> > To me, the proper handling ambiguity means that when I do "git fetch" I
> > immediately see warning about tag clashes.
>_
> Fair enough.
>_
> > So, I agree with you that
> > current behavior is not good, but I disagree with you about having many
> > namespaces, because it postpones detection of the conflict until I try
> > to use.
>_
> No.  The later does not prevent the former.

But what if I really have two semi-related projects that I want to fetch
into the same repository as Johan suggested? In this case, I want to
have separate namespaces and no warning when I fetch.

>_
> Of course there is a reason.  What if your fetch brings in hundreds of_
> tags (this is common for some projects) and then you want to remove that_
> fetched branch from your repository?  How do you determine which tag_
> came from that remote repository and which tags are to be kept?  Without_
> a separate namespace this is practically impossible.

Well, I see your use case now. Maybe the right solution is add an option
that will tell whether to fetch tags into separate namespace or not, and
later based on experiences, we can decide whether we want to change the
default to have separate namespaces for tags.


Dmitry
