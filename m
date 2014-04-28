From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH 1/2] trailer: fix to ignore any line starting with
 '#'
Date: Mon, 28 Apr 2014 07:58:32 +0200
Message-ID: <535DEE08.9090402@alum.mit.edu>
References: <20140427200327.16880.53255.chriscool@tuxfamily.org> <20140427201238.16880.13774.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 07:58:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeeaV-0000FR-0k
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 07:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaD1F6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 01:58:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54447 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200AbaD1F6k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 01:58:40 -0400
X-AuditID: 12074413-f79076d000002d17-06-535dee0fb0dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BB.2B.11543.F0EED535; Mon, 28 Apr 2014 01:58:39 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E29.dip0.t-ipconnect.de [79.201.110.41])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3S5wXTt006263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 28 Apr 2014 01:58:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140427201238.16880.13774.chriscool@tuxfamily.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTQRjN7C7bBbo4LGBHNBhr8K5H0Lgm3pi4HlGUeARDYIWVVtuF7LZE
	NGiJ9Q9SjohcKjbgFROj9ocXamITjxIvjmCooBUPAlKCQcUr6i4Nwr83773vvZl8Q+HMETKW
	MolWQRJ5s54MIxjNmimGcf2pyfPvFupYd3cZzn76U0mwha3HMNbubMXZZ64qwNZ23sbYv65s
	NtB+FrDfHUU421DhItknfQWAvf9wwkotd6umU8M19wyRnO/TMi7wNon7/MFHcB+ddwDX1DyV
	e1f2OISr96/nyl//DeEu+Hs13KA7LkmbEr50N2/NTTZlifOWp4cbS44eJXJuEPsHrr8CduDF
	C0EoheBCdLz4pSaIx6MXr6+QhSCMYmALQP5fg3jw8BxDb5wDmOqi4WzkdT0iVEzAeNR2unqY
	J6EB1RUdUTBFxcCt6PfTKUF7JPJWvx+2R8NdqLK5XKNm4vAkjr4V1JGqEAWTUKf3a4iKGWhD
	1yrahm8UClchR0fPcCaCOlRUsFWlcTgH9Rf78SCejG4ETuGlILJmTF3NGFvNGJsL4JdAHG+2
	WQwW3mSWhQyDnMGLoiAZFs+1mKxzhUybGwTXF3UT3PbGeQCkgF5L7zyVmsyE8LlynsUDJlCY
	Pob2tChUxO7szDwjLxvTJJtZkD0AUbg+mnbdUzQ6k887IEjZI9JEitDr6Glnp29iYBZvFfYJ
	Qo4gjaiTKEqP6L0BZTBSErKE/XtMZuuojFGhanhYbLQsiJmCxNusxjR1wWmysmFV0iq9W9Rx
	Ws7hLQobHG0ECdSXnxccGPXCftGBMYSYLQqxOrqtT7FC1Wq0if+LRv5uL9Ap746i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247234>

On 04/27/2014 10:12 PM, Christian Couder wrote:
> It looks like the commit-msg hook is passed a commit
> message that can contain lines starting with a '#'.
> Those comment lines will be removed from the commit
> message after the hook is run.
> 
> If we want "git interpret-trailers" to be able to
> process commit messages correctly in the commit-msg
> hook we need to ignore those lines.

Shouldn't this take into account the config setting core.commentchar?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
