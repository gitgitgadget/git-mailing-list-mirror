From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Brown paper bag fix for MinGW 64-bit stat
Date: Sat, 7 Mar 2009 20:46:23 +0100
Message-ID: <200903072046.23965.j6t@kdbg.org>
References: <cover.1236436185u.git.johannes.schindelin@gmx.de> <03fcab37c921f5728deded11c07bdf32a263b79b.1236436185u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 20:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2V6-0000ZK-5U
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 20:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbZCGTqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 14:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZCGTqc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:46:32 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:11323 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbZCGTqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 14:46:31 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 699C4CDF84;
	Sat,  7 Mar 2009 20:46:25 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 16AEC2814F;
	Sat,  7 Mar 2009 20:46:25 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <03fcab37c921f5728deded11c07bdf32a263b79b.1236436185u.git.johannes.schindelin@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112566>

On Samstag, 7. M=E4rz 2009, Johannes Schindelin wrote:
> 	Actually, it was quite funny that t4200 displayed the bug; I
> 	_guess_ it was due to a time zone issue, as the times were exactly
> 	one hour off (and the machine I tested on is at UTC+0100 right now).
>
> 	And due to that bug, "rerere gc" would not collect the garbage.

U-oh, you are right! I was 100% sure that I ran the test-suite suite wi=
th your=20
earlier patch and it was all OK before I gave my ACK. But appearently I=
 did=20
something wrong because today I see the failure in t4200, too, and this=
 fixes=20
it, and it is the right thing to do.

> -#define stat64(x,y) mingw_lstat(x,y)
> +#define _stati64(x,y) mingw_lstat(x,y)

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
