From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Sun, 14 May 2006 20:56:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0605142056320.3038@mundungus.clifford.ac>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
 <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605111218380.3866@g5.osdl.org> <7viroav534.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 22:57:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfNed-0002dT-8B
	for gcvg-git@gmane.org; Sun, 14 May 2006 22:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWENU50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 16:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWENU50
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 16:57:26 -0400
Received: from mundungus.clifford.ac ([81.187.211.39]:20999 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751307AbWENU5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 16:57:25 -0400
Received: from mundungus.clifford.ac (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k4EKurIc028637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 May 2006 20:56:53 GMT
Received: from localhost (benc@localhost)
	by mundungus.clifford.ac (8.13.3/8.13.3/Submit) with ESMTP id k4EKuovW028631;
	Sun, 14 May 2006 20:56:50 GMT
X-Authentication-Warning: mundungus.clifford.ac: benc owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viroav534.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19981>


> It takes the uint32_t version but matches another place to use
> that type instead of "int" (which would not matter in next 10
> years perhaps).

This use of uint32_t breaks the build for me on Mac OS X. Including
<stdint.h> seems to make it work again. See following patch.

-- 
