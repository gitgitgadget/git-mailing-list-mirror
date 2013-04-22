From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 22:59:48 +0530
Message-ID: <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 19:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUKZW-00047n-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 19:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab3DVRaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 13:30:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54392 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab3DVRa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 13:30:29 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so5836914iec.23
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1osmFy7lg7M8XrB+zNHP3PnLiIo/8ueaauYvom7v3zQ=;
        b=B8fBKxJ8+WA3keXu7s1t3xK6D2KNRvd6lnd+pp2Ve7lKygP8p/IXh5+4VL8Ym6P6Ti
         SHna5gUXDP4wOQ5b/vPEjxuHiFdj98uLgNtzKRsV+0VxIB5j+nKH+/UXqNnPNxgcj02g
         q0fV/KRWSSu059nlf2kdWoO1g55uL297zFef38Vct5gFzPPE5kEIR0PIJllOyjVuXzpo
         1WieYdWBPQgrApf7mzPOKAuz/eEfA2tZL8RZwjC+RA8T2PkcX45qG/jvcFkbz8ruTrKc
         JyAhnD9mw7MEV0w/KhTDlIbaYjXOSZbLqJuQhjhLUkhJ+rz9ImXtj6JaIp9F4xxNN/aL
         Lu7g==
X-Received: by 10.50.17.166 with SMTP id p6mr8667133igd.12.1366651828841; Mon,
 22 Apr 2013 10:30:28 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 10:29:48 -0700 (PDT)
In-Reply-To: <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222040>

Ramkumar Ramachandra wrote:
> And if you're still not convinced, run 'git log HEAD^2 -- README.md'
> from the toplevel directory.  You'll get the log of README.md from the
> subproject.

On IRC, Thomas explained to me that mixing in changes from various
branches into the pathspec will break this so-called determinism.  To
try it out for yourself, do:

    $ cd /tmp
    $ git clone gh:trast/subtree-mainline-example
    $ cd subtree-mainline-example
    $ git log HEAD^2 -- sub # only lists the side changes
    $ git log -- dir/sub # only lists the mainline changes

What we should really expect is a mix of the two.
