From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/5] i18n: keep the last \n even when text is poisoned
Date: Fri, 9 Mar 2012 12:24:36 +0100
Message-ID: <CACBZZX4L+PiFUfre=_Qn+dgZAAanu6ebwjJFZUStu4_Ne7YwFg@mail.gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-2-git-send-email-pclouds@gmail.com> <20120308220131.GA10122@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 12:25:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5xwW-0003Lp-OI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 12:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab2CILY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 06:24:59 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52174 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2CILY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 06:24:58 -0500
Received: by eekc41 with SMTP id c41so427054eek.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 03:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s+dxUPmhIzcoC9qmkqFe/NOrgzDP1QdlPJ1Wt6T7YQE=;
        b=tbregCe/qCyJX8vcbSXkuNqjIRSQwOfBLq4OWGX4QHuZca+hGQ/mB+cnxQ9ML6WtVA
         NpPSEvg8pqLaebyyOHR88wPynWP75C8B9IHngAGBvClQ5LiRVFgJOnRL0F38HoGEmQSy
         w5WJDpDXGI/v3kZEKAjn5+tB5L9UlVnsCnwhbRrXxZH6YZ5tB3nIUG1w72ys5VtVG33E
         jLL1F43V/B7MF9ClALbrEW7B7O0gvqokNe6iHW9dRDiociyviAmgNbwlANP/ri9wcQ9D
         kDEfakN8EsvnHcct3NYJId4aLu86whqjZwlUIkdMwQzUogfKoMscnxEj0HU6gh0GitMz
         ctDQ==
Received: by 10.213.7.80 with SMTP id c16mr242523ebc.7.1331292297281; Fri, 09
 Mar 2012 03:24:57 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Fri, 9 Mar 2012 03:24:36 -0800 (PST)
In-Reply-To: <20120308220131.GA10122@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192709>

2012/3/8 Jonathan Nieder <jrnieder@gmail.com>:
> The latter wins out for me, so I would prefer not to have this patch
> so the test suite can detect important newlines that should be not be
> part of the translatable string.

FWIW that's why I kept it this way. I can't recall the specific cases
but I smoked out some issues with the poison feature that I wouldn't
have smoked out if it had a \n at the end.

Arguably we should make it even less user friendly and have it
randomly output 10-50 bytes of binary garbage to catch more errors.
