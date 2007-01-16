From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Mon, 15 Jan 2007 20:09:36 -0700
Message-ID: <45AC41F0.8090106@byu.net>
References: <17437.1168911089@lotus.CS.Berkeley.EDU> <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 04:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ehm-0006E3-UM
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 04:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbXAPDJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 22:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAPDJo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 22:09:44 -0500
Received: from alnrmhc14.comcast.net ([204.127.225.94]:42087 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbXAPDJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 22:09:43 -0500
Received: from [192.168.0.103] (failure[67.186.254.72])
          by comcast.net (alnrmhc14) with ESMTP
          id <20070116030942b1400rmu8be>; Tue, 16 Jan 2007 03:09:43 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.9) Gecko/20061207 Thunderbird/1.5.0.9 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36916>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Junio C Hamano on 1/15/2007 7:46 PM:
>> -			name=$(echo -n "$f" | tr -c "A-Za-z0-9" ".")
>> +			name=$(printf "$f" | tr -c "A-Za-z0-9" ".")
> 
> This should almost be safe as no sane person would have a remote
> whose name is 'foo%s'...

Why not go all the way, and make it safe, regardless of embedded %,
embedded \, or leading -?

name=$(printf -- %s "$f" | tr -c "A-Za-z0-9" ".")

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrEHw84KuGfSFAYARAlH9AJ9q3atCpSVBTg0SVhZ4DQ9T7qiqEQCfe9D2
bGTfwnvW6uN1ky6ncWYgkgc=
=P9t5
-----END PGP SIGNATURE-----
