From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Tue, 9 Mar 2010 10:22:29 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1003081951000.1164@shipon.roxen.com>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
 <7vljeamcpq.fsf@alter.siamese.dyndns.org> <Pine.GSO.4.63.1003031129340.1164@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1594243340-1268126549=:1164"
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:29:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyX6-0001Do-6I
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab0CIJWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 04:22:34 -0500
Received: from mail.roxen.com ([212.247.29.220]:33897 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab0CIJWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 04:22:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 1C07B628111;
	Tue,  9 Mar 2010 10:22:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ptpKx1Mn-vs; Tue,  9 Mar 2010 10:22:29 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 5DC556280F9;
	Tue,  9 Mar 2010 10:22:29 +0100 (CET)
In-Reply-To: <Pine.GSO.4.63.1003031129340.1164@shipon.roxen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141803>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1594243340-1268126549=:1164
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 3 Mar 2010, Henrik Grubbström wrote:

> On Tue, 2 Mar 2010, Junio C Hamano wrote:
>
>> Henrik Grubbström <grubba@grubba.org> writes:
>> 
>>> The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
>>> of source text if the terminating $ was lost. It now refuses to
>>> contract $Id:xxxxx$ strings spanning multiple lines.
>> 
>> Hmm, at least when going from working tree to the index, shouldn't the
>> code refuse _and_ die(), instead of silently pass the garbage through?
>
> It depends; it could be part of some code that scans for the $Id: tag.
> A warning might be appropriate though.

A nonscientific survey of some version control systems gives:

VCS		Id-keyword	Eats linefeed
-------------------------------------------------
bzr		no		-
cvs		yes		no, silent accept
git(1.7.0)	yes		yes, silent
hg		yes(hgext)	no, silent accept
monotone	no		-
rcs		yes		no, silent accept
svn		yes		no, silent accept

So it seems my original patch is in line with what other version control 
systems do.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1594243340-1268126549=:1164--
