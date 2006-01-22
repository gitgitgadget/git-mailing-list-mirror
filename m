From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: git cherry unkillable
Date: Sun, 22 Jan 2006 18:01:23 +0300
Message-ID: <200601221801.29769.arvidjaar@mail.ru>
References: <200601221323.33377.arvidjaar@mail.ru> <BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 16:01:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0gj2-000402-Pc
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 16:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWAVPBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 10:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAVPBq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 10:01:46 -0500
Received: from mx3.mail.ru ([194.67.23.149]:45958 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932130AbWAVPBp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 10:01:45 -0500
Received: from [83.237.106.88] (port=7541 helo=cooker.home.net)
	by mx3.mail.ru with asmtp 
	id 1F0gih-0008Q4-00; Sun, 22 Jan 2006 18:01:31 +0300
To: sean <seanlkml@sympatico.ca>
User-Agent: KMail/1.9.1
In-Reply-To: <BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15051>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 22 January 2006 14:39, sean wrote:
>
> The attached patch works for me 

ack at least for git-cherry

> but i'm concerned about it a bit.  With 
> this patch it looks like the signal handler is executed twice; once as
> normal and a second time in response to the added "exit" statement.   By
> adding ";trap - 0;exit" it is only executed once, but i'm not sure how
> universal that is, and letting it run twice shouldn't be a big deal anyway.
>

why not

trap "rm -rf $tmp-*" 0
trap "exit" 1 2 3 15

?

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD055JR6LMutpd94wRAn06AJ0RrLXwND67hvhRrSeaQvUjgrfGrACeK1cs
JA0jLNs5/8FPwpZqzKRd3eo=
=8QbF
-----END PGP SIGNATURE-----
