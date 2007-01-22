From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: GIT 1.5.0-rc2 compiler warning
Date: Mon, 22 Jan 2007 21:44:34 +0100
Organization: Dewire
Message-ID: <200701222144.34934.robin.rosenberg.lists@dewire.com>
References: <45B40E7E.3030706@gmail.com> <7vy7nvyic4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 21:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H961n-00069g-Hw
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbXAVUoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 Jan 2007 15:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbXAVUoQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:44:16 -0500
Received: from [83.140.172.130] ([83.140.172.130]:5738 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932507AbXAVUoP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jan 2007 15:44:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 568C0802E0C;
	Mon, 22 Jan 2007 21:39:41 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08987-09; Mon, 22 Jan 2007 21:39:41 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 04D36802651;
	Mon, 22 Jan 2007 21:39:38 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vy7nvyic4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37448>

m=E5ndag 22 januari 2007 02:13 skrev Junio C Hamano:
> I know.  Imported code.
>
> I do not think we can do much on a platform where wchar_t is too
> narrow and BMP only anyway.

What's wrong is the assumption that wchar_t corresponds to a complete u=
nicode=20
character. On windows, two wchar_t (code units) may me combined to enco=
de a
unicode character outside of the BMP.

Without investigating further, I note that Java adds methods with an 'i=
nt'=20
argument to the Character utility class to handle code points, vs the=20
original 'char' that represents a code unit. (unlike C, an int is alway=
s=20
32-bit in Java).

-- robin
=20
