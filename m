From: Dmitry Marakasov <amdmi3@amdmi3.ru>
Subject: Re: [PATCH] configure.ac: link with -liconv for locale_charset()
Date: Wed, 12 Mar 2014 04:57:02 +0400
Message-ID: <20140312005702.GA81282@hades.panopticon>
References: <20140311183529.GA73693@hades.panopticon>
 <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, git@vger.kernel.org, wxs@FreeBSD.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 01:57:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNXTt-00024o-E7
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 01:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbaCLA5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 20:57:08 -0400
Received: from smtpout3.timeweb.ru ([92.53.117.25]:32760 "EHLO
	smtpout3.timeweb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949AbaCLA5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 20:57:07 -0400
Received: from [213.148.20.85] (helo=hive.panopticon)
	by smtp.timeweb.ru with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.76)
	(envelope-from <amdmi3@amdmi3.ru>)
	id 1WNXTi-0003VY-Tu; Wed, 12 Mar 2014 04:57:02 +0400
Received: from hades.panopticon (hades.panopticon [192.168.0.32])
	by hive.panopticon (Postfix) with ESMTP id 88C75AC1;
	Wed, 12 Mar 2014 04:57:02 +0400 (MSK)
Received: by hades.panopticon (Postfix, from userid 1000)
	id 7F6A1106AC; Wed, 12 Mar 2014 04:57:02 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243915>

* Junio C Hamano (gitster@pobox.com) wrote:

> Looks sensible; Dilyan, any comments?

Another addendum, comment from Tijl Coosemans <tijl@FreeBSD.org> who
just fixed this problem in FreeBSD ports (differently):

---
Please let upstream know they should either use iconv from libc +
nl_langinfo from libc, or iconv from libiconv + locale_charset from
libiconv, but not mix the two.  Actually they could just always use
nl_langinfo when it's available because locale_charset is not much
more than an alias for it.
---

The fix used in ports was to just disable check for libcharset.h:

http://www.freebsd.org/cgi/query-pr.cgi?pr=187326#reply3

-- 
Dmitry Marakasov   .   55B5 0596 FF1E 8D84 5F56  9510 D35A 80DD F9D2 F77D
amdmi3@amdmi3.ru  ..:  jabber: amdmi3@jabber.ru    http://www.amdmi3.ru
