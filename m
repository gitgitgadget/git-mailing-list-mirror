From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/7] Add -q/--quiet switch to git-ls-files
Date: Fri, 23 Nov 2007 20:25:59 +0100
Message-ID: <CA22AE42-64AD-4633-8671-1901956E7C92@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com> <1195845650-85962-2-git-send-email-win@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 20:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IveAc-0001EY-75
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbXKWT0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 14:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbXKWT0Q
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:26:16 -0500
Received: from wincent.com ([72.3.236.74]:60696 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744AbXKWT0P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 14:26:15 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJPxSx018337;
	Fri, 23 Nov 2007 13:26:00 -0600
In-Reply-To: <1195845650-85962-2-git-send-email-win@wincent.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65917>

El 23/11/2007, a las 20:20, Wincent Colaiuta escribi=F3:

> +test_expect_success \
> +    'git ls-files -q --error-unmatch should be quiet with unmatched =
=20
> path.' \
> +    'git ls-files -q --error-unmatch foo bar-does-not-match 1> out =20
> 2> err ||
> +     test $(cat out | wc -l) -eq 0 &&
> +     test $(cat err | wc -l) -gt 0'
> +
> +test_expect_success \
> +   'git ls-files -q --error-unmatch should be quiet with matched =20
> paths.' \
> +   'git ls-files -q --error-unmatch foo bar 1> out 2> err ||
> +    test $(cat out | wc -l) -eq 0 &&
> +    test $(cat err | wc -l) -eq 0'
> +
> test_done

Doh, in that last test it should be:

+   'git ls-files -q --error-unmatch foo bar 1> out 2> err &&

Instead of:

+   'git ls-files -q --error-unmatch foo bar 1> out 2> err ||

Cheers,
Wincent
