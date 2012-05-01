From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line termination mode
Date: Mon, 30 Apr 2012 19:51:51 -0700
Message-ID: <86ehr4r4u0.fsf@red.stonehenge.com>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
	<1335817705-24718-1-git-send-email-jk@jk.gs>
	<7vd36oesjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 04:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP3Cd-0006F4-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 04:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab2EACvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 22:51:55 -0400
Received: from lax-gw18.mailroute.net ([199.89.0.118]:34327 "EHLO
	gw18.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab2EACvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 22:51:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw18.lax01.mailroute.net (Postfix) with ESMTP id AB9D2179A1F7;
	Tue,  1 May 2012 02:51:53 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw18.lax01.mailroute.net ([199.89.0.118])
	by localhost (gw18.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id xyaITa3yBQSp; Tue,  1 May 2012 02:51:52 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw18.lax01.mailroute.net (Postfix) with ESMTP id 8CE3B179A204;
	Tue,  1 May 2012 02:51:52 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 74E6C25B3; Mon, 30 Apr 2012 19:51:52 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.5; tzolkin = 3 Chicchan; haab = 8 Uo
In-Reply-To: <7vd36oesjr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Apr 2012 15:58:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196648>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Having said that, are we sure that

Junio> 	printf "add bar\0initial"


Junio> works per specification, or merely works by accident in some
Junio> implementation?

>From the POSIX spec
(http://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html):

    In addition to the escape sequences shown in XBD File Format Notation (
    '\\' , '\a' , '\b' , '\f' , '\n' , '\r' , '\t' , '\v' ), "\ddd" , where
    ddd is a one, two, or three-digit octal number, shall be written as a
    byte with the numeric value specified by the octal number.

Looks pretty intentional to me.  \0 is a nul.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
