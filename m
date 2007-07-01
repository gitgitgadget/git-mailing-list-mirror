From: Sven Verdoolaege <skimo@kotnet.org>
Subject: t7004-tag.sh fails (old gpg?)
Date: Sun, 01 Jul 2007 14:49:53 +0200
Message-ID: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 14:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4yss-0006gj-8M
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 14:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbXGAMt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 08:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbXGAMt5
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 08:49:57 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:63199 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853AbXGAMt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 08:49:56 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKI00IO63N6KX@smtp15.wxs.nl> for git@vger.kernel.org; Sun,
 01 Jul 2007 14:49:54 +0200 (CEST)
Received: (qmail 24756 invoked by uid 500); Sun, 01 Jul 2007 12:49:53 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51291>

t7004-tag.sh fails for me:

* expecting success: 
        git-tag -s -m "A signed tag message" signed-tag &&
        get_tag_msg signed-tag >actual &&
        git-diff expect actual

gpg: Warning: using insecure memory!
gpg: [don't know]: invalid packet (ctb=00)
gpg: read_keyblock: read error: invalid packet
gpg: enum_keyblocks failed: invalid keyring
gpg: skipped `C O Mitter <committer@example.com>': invalid keyring
gpg: signing failed: invalid keyring
failed to sign the tag with GPG.
* FAIL 49: creating a signed tag with -m message should succeed

                git-tag -s -m "A signed tag message" signed-tag &&
                get_tag_msg signed-tag >actual &&
                git-diff expect actual

I see that you alread check for presence of gpg, but maybe
you should also check that it is recent enough.
This is the version I have:

bash-3.00$ gpg --version
gpg (GnuPG) 1.0.6
Copyright (C) 2001 Free Software Foundation, Inc.
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See the file COPYING for details.

Home: ~/.gnupg
Supported algorithms:
Cipher: 3DES, CAST5, BLOWFISH, RIJNDAEL, RIJNDAEL192, RIJNDAEL256, TWOFISH
Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA, ELG
Hash: MD5, SHA1, RIPEMD160

skimo
