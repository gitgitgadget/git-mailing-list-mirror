From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Verifying recent tags in git.git
Date: Sat, 12 Nov 2011 16:35:31 +0000
Message-ID: <4EBEA053.6040109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 19:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPI07-0007o3-KG
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 19:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab1KLSGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 13:06:22 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:57358 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306Ab1KLSGW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 13:06:22 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RPHy7-0005yL-iA; Sat, 12 Nov 2011 18:06:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185312>

Hi Junio,

I noticed that the v1.7.8-rc1 tag took about 24 hours to appear in the
kernel.org (and repo.or.cz) repository after you announced it and actually
pushed the branch out.

So, unusually, I decided to verify the tag when it did appear. However, it
did not verify! It seems that ever since v1.7.7 (ie v1.7.7.x and v1.7.8-rcx),
you have been signing the release tags with a new key-pair. (I assume that
you generated new keys at the beginning of October for use on kernel.org)
viz:

    ramsay (master)$ git tag -v v1.7.7
    object 703f05ad5835cff92b12c29aecf8d724c8c847e2
    type commit
    tag v1.7.7
    tagger Junio C Hamano <gitster@pobox.com> 1317417666 -0700
    
    Git 1.7.7
    gpg: Signature made Fri Sep 30 22:21:06 2011 GMTDT using DSA key ID F3119B9A
    gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
    gpg:                 aka "Junio C Hamano <junkio@cox.net>"
    gpg:                 aka "[jpeg image of size 1513]"
    gpg:                 aka "Junio C Hamano <jch@google.com>"
    gpg:                 aka "Junio C Hamano <junio@pobox.com>"
    gpg: WARNING: This key is not certified with a trusted signature!
    gpg:          There is no indication that the signature belongs to the owner.
    Primary key fingerprint: 3565 2A26 2040 E066 C9A7  4A7D C0C6 D9A4 F311 9B9A

    ramsay (master)$ git tag -v v1.7.8-rc1
    object 4cb6764227173a6483edbdad09121651bc0b01c3
    type commit
    tag v1.7.8-rc1
    tagger Junio C Hamano <gitster@pobox.com> 1320713324 -0800
    
    Git 1.7.8-rc1
    gpg: Signature made Tue Nov  8 00:48:44 2011 GMTST using RSA key ID 96AFE6CB
    gpg: Can't check signature: public key not found
    error: could not verify the tag 'v1.7.8-rc1'
    
    ramsay (master)$

Note the key ID 96AFE6CB.

Are you planning to create an junio-gpg-pub-v2 tag? (or are you making it
available from a keyserver?)

If I have missed an announcement on this, then sorry for the noise!

ATB,
Ramsay Jones
