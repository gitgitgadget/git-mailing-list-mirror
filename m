From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 16:59:00 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1111251656200.22588@shipon.roxen.com>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <Pine.GSO.4.63.1111251629500.22588@shipon.roxen.com>
 <20111125155301.GC10417@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1297389768-1322236740=:22588"
Cc: Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Nov 25 16:59:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTyBH-0006IC-TN
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 16:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1KYP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 10:59:09 -0500
Received: from mail.roxen.com ([212.247.29.220]:47778 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749Ab1KYP7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 10:59:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 7D17E628134;
	Fri, 25 Nov 2011 16:59:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xKryGExgLYUc; Fri, 25 Nov 2011 16:59:00 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id BAD616280F8;
	Fri, 25 Nov 2011 16:59:00 +0100 (CET)
In-Reply-To: <20111125155301.GC10417@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185936>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1297389768-1322236740=:22588
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 25 Nov 2011, Carlos Martín Nieto wrote:

> On Fri, Nov 25, 2011 at 04:43:41PM +0100, Henrik Grubbström wrote:
>>
>> The bug is probably that lf_to_crlf_filter_fn() should return
>> non-zero in this case (ie o and/or i being zero).
>
> non-zero? That would cause the filter to abort, which definitely not
> what we want. Have you seen my other e-mails regarding this? I'm
> trying to figure out which is the best way to go about this. The
> solution is to keep track of the fact that we're missing a LF in the
> output buffer.

True, I misread the code.

Keeping track of the filter state is the way to go.

>   cmn

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB
---559023410-1297389768-1322236740=:22588--
