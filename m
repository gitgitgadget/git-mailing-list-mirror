From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 10:07:47 +0100
Message-ID: <87747E02-0C25-4330-84F4-1C56C0196BD5@lrde.epita.fr>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711090225110.4362@racer.site> <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr> <473420FE.7010807@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-103--603780441"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:08:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPqf-0002y8-Io
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 10:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbXKIJIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 04:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXKIJIG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 04:08:06 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:44275 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbXKIJIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 04:08:04 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IqPqF-0005Yr-Mq; Fri, 09 Nov 2007 10:07:55 +0100
In-Reply-To: <473420FE.7010807@viscovery.net>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64146>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-103--603780441
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 9, 2007, at 9:57 AM, Johannes Sixt wrote:

> Benoit Sigoure schrieb:
>> Off topic question: why do you guys always do this instead of  
>> doing, say, this:
>> INTERACTIVE=false
>> case $1 in
>>   --interactive|-i)
>>     INTERACTIVE=:
>>     ... ;;
>> esac
>> if $INTERACTIVE; then
>>   git_editor "$TODO" || die ...
>> fi
>
> Because in some shells 'false' is not a built-in.

Can you name such a shell?  (besides Solaris' brain-damaged, b0rken  
and foobared /bin/sh which will most likely not work with Git anyway)

> But then this might do it without the extra process:
>
> 	INTERACTIVE="! :"	# false

`!' is not portable either.  In particular, I highly doubt `!' will  
work on shells that don't have `false' as a builtin (Hello Mr Solaris).

>
> 	case $1 in
> 	--interactive|-i)
> 	    INTERACTIVE=:
> 	    ... ;;
> 	esac
> 	if $INTERACTIVE; then
> 	  git_editor "$TODO" || die ...
> 	fi

Correct me if I'm wrong but I think that some shells don't have  
`test' as a builtin either.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-103--603780441
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHNCNjwwE67wC8PUkRAmtpAJ9+K280o20zKGyR57n70jimykb6WwCgwvn3
u/IS3c8GWDEOjHrDHbyWWYw=
=7CZv
-----END PGP SIGNATURE-----

--Apple-Mail-103--603780441--
