From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/2] Highlight keyboard shortcuts in git-add--interactive
Date: Sat, 1 Dec 2007 15:15:33 +0100
Message-ID: <697AB37F-784D-4374-A290-0E6290712B29@wincent.com>
References: <7vy7cf87jz.fsf@gitster.siamese.dyndns.org> <1196518040-85584-1-git-send-email-win@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, dzwell@gmail.com,
	peff@peff.net, Matthieu.Moy@imag.fr
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 15:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyT8m-0007s5-H6
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 15:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbXLAOQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 09:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbXLAOQA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 09:16:00 -0500
Received: from wincent.com ([72.3.236.74]:55175 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbXLAOP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 09:15:59 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB1EFYo9029886;
	Sat, 1 Dec 2007 08:15:35 -0600
In-Reply-To: <1196518040-85584-1-git-send-email-win@wincent.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66722>

El 1/12/2007, a las 15:07, Wincent Colaiuta escribi=F3:

> +# filters out prefixes which have special meaning to =20
> list_and_choose()
> +sub is_valid_prefix {
> +	my $prefix =3D shift;
> +	my $valid =3D (defined $prefix) &&
> +	    !($prefix =3D~ /[\s,]/) && # separators
> +	    !($prefix =3D~ /^-/) &&    # deselection
> +	    !($prefix =3D~ /^\d+/) &&  # selection
> +	    ($prefix ne '*');        # "all" wildcard
> +}

Doh, that's supposed to be:

	return (defined $prefix)...

Not:

	my $valid =3D (defined $prefix)...

It actually works as is, but I had changed the "return" while working =20
on the patch (for debugging) and forgot to change it back afterwards.

And yes, I did proofread the patch before sending it. I just didn't =20
notice the first time around.

Cheers,
Wincent
