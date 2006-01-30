From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 12:58:20 +0100
Message-ID: <43DDFF5C.30803@hogyros.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1A0F9ADB6411D9A661AC2A6A"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 12:58:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3XgF-00055a-58
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 12:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWA3L6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 06:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWA3L6o
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 06:58:44 -0500
Received: from kleinhenz.com ([213.239.205.196]:12502 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S932232AbWA3L6o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 06:58:44 -0500
Received: from [192.168.115.35] (p54995381.dip.t-dialin.net [84.153.83.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id F13324A8045;
	Mon, 30 Jan 2006 12:58:28 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15269>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A0F9ADB6411D9A661AC2A6A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Johannes Schindelin wrote:

>>. Set up `info/grafts` to lie to the local git that Linux kernel
>>  history began at v2.6.14 version.

> Maybe also record this in .git/config, so that you can

I like that "config" thing less and less every day. It appears to become 
a kind of registry, where having dedicated files for specific 
functionality would provide the robustness of tools not having to touch 
things they do not care about; but that's just personal opinion.

> - disallow fetching from this repo, and

Why? It's perfectly acceptable to pull from an incomplete repo, as long 
as you don't care about the old history.

> - easily extend the shallow copy to a larger shallow one, or a full one.

Hrm, I think there should also be a way to shrink a repo and "forget" 
old history occasionally (obviously, use of that feature would be highly 
discouraged).

>>. Run `git fetch git://.../linux-2.6 master`, with a local ref
>>  pointing at v2.6.14 commit, to pretend that we have everything
>>  up to v2.6.14 to `upload-pack` running on the other end.

> How about refs/tags/start_shallow?

No, as that would imply that cloning from such a repo is disallowed.

IMO, it may be a lot more robust to just have a list of "cutoff" object 
ids in .git/shallow instead of messing with grafts here, as adding or 
removing a line from that file is an easier thing to do for porcelain 
(or by hand) than rewriting the grafts file. Whether that list would be 
inclusive or exclusive would need to be decided still.

    Simon

--------------enig1A0F9ADB6411D9A661AC2A6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ93/X1Yr4CN7gCINAQLidgP+I2ZbDU9H2LuGAdh9T2VCaQhE1EYo3oAf
Yexs6YCumfv+Uv2XkTUqBV31BmnddfQYQt/DYA/0PCH6ya9WHonn5QiW8RLSY4kG
8IgEiBMUAP+ncGbIaRDAnzVr2hyCa42JG5NaJlRqWRxRNJcomwttbs/Q2t5yOGyL
gnnS72EUEkc=
=sKUY
-----END PGP SIGNATURE-----

--------------enig1A0F9ADB6411D9A661AC2A6A--
