From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects.
Date: Mon, 29 Aug 2005 12:59:03 -0600
Message-ID: <43135AF7.6070705@tuxrocks.com>
References: <43102727.2050206@tuxrocks.com>	<7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>	<4312BC27.9010604@tuxrocks.com>	<7vvf1obsfc.fsf@assigned-by-dhcp.cox.net> <7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 21:03:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9orA-0006fp-32
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVH2S71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVH2S71
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:59:27 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:4358 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751301AbVH2S7I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:59:08 -0400
Received: from [128.187.171.102] (obelix.cs.byu.edu [128.187.171.102])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j7TIx4uZ009455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Aug 2005 12:59:05 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7920>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> This originally came from Frank Sorenson but with a bit of
> rework to allow future enhancement to the command without
> changing the external interface for removal part.
> 
> With the '-a' option, all objects in the current repository are
> packed into a single pack.  When the '-d' option is given at the
> same time, existing packs that were made redundant by this round
> of repacking are deleted.
> 
> Since we currently have only two repacking strategies, one '-a'
> (everything into one) and the other not '-a' (incrementally pack
> only the unpacked ones), '-d' is meaningful only used with '-a'
> and removes all the existing packs before repacking for now.

Thank you for explaining the reasoning, and reworking the patch.  This
does make more sense, and I can see the logic for leaving around the
packs.  Coming from the perspective of the end user, I would probably
want to repack quite a bit more often to take advantage of the size and
speed advantages, while large public repositories will probably want to
repack at much longer periods.  Thanks for seeing both perspectives.  I
like your updated patch.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDE1r3aI0dwg4A47wRAldNAJ9J7wmyQMsMm5G0FgvOggc+QDtg/QCg0T+w
y6A/46LYEr1zhFgxK6uKX0I=
=z8uM
-----END PGP SIGNATURE-----
