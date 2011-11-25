From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 17:14:17 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1251336619-1322237657=:22588"
Cc: Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Nov 25 17:14:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTyQ5-0004qc-OM
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 17:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab1KYQOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 11:14:25 -0500
Received: from mail.roxen.com ([212.247.29.220]:45893 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab1KYQOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 11:14:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id EE3196280F5;
	Fri, 25 Nov 2011 17:14:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TgRJ1YdEKQmY; Fri, 25 Nov 2011 17:14:17 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 27FB1628125;
	Fri, 25 Nov 2011 17:14:17 +0100 (CET)
In-Reply-To: <20111125153829.GB10417@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185937>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1251336619-1322237657=:22588
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 25 Nov 2011, Carlos Martín Nieto wrote:

> This patch fixes this, but I think it would still break if the LF is
> at the end of the file. Changing the `if (!input)` to put the LF in
> the output buffer may or may not be the right soulution. I feel like
> this should be handled by cascade_filter_fn rather than the actual
> filter somehow, but Junio's comment (4ae66704 'stream filter: add "no
> more input" to the filters') suggests otherwise.
>
> I'm working on a cleaner patch that takes care of a bit of state, but
> this is the general idea.

Looks good to me (and seems to work in my case).
Typo in the commit subject though.

>   cmn
> --- 8< ---
> Subject: [PATCH] convert: don't loop indefintely if at LF-to-CRLF streaming
                                        ^^^^^^^^^^^
This should be either "infinitely", or "indefinitely", but since we know 
that the loop won't terminate "infinitely" is to be preferred.

Thanks,

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB
---559023410-1251336619-1322237657=:22588--
