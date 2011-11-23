From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
Subject: Infinite loop in cascade_filter_fn()
Date: Wed, 23 Nov 2011 18:40:47 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1827104807-1322070047=:5099"
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:41:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGof-0000px-64
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab1KWRk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 12:40:56 -0500
Received: from mail.roxen.com ([212.247.29.220]:57934 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab1KWRkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 12:40:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 762D7628112;
	Wed, 23 Nov 2011 18:40:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GpzWmx-kepQ; Wed, 23 Nov 2011 18:40:47 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 8DE256280E9;
	Wed, 23 Nov 2011 18:40:47 +0100 (CET)
X-X-Sender: grubba@shipon.roxen.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185860>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1827104807-1322070047=:5099
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Hi.

My git repository walker just got bitten by what seems to be a reasonably 
new bug in convert.c:cascade_filter_fn() (git 1.7.8.rc3 (gentoo)).

How to reproduce:

   git clone git@github.com:pikelang/Pike.git

   git checkout -f 0e2080f838c6f0bc7d670ac7549676a353451dca^

   git checkout -f 0e2080f838c6f0bc7d670ac7549676a353451dca

The first two commands complete as expected, while the last hangs forever.
Performing the same with git 1.7.6.4 works as expected.

The problematic file seems to be /src/modules/_Crypto/rijndael_ecb_vt.txt 
which has the attributes: text ident eol=crlf

Thanks,

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1827104807-1322070047=:5099--
