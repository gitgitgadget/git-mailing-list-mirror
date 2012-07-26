From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 18:41:09 +0200
Message-ID: <vpq8ve6qxui.fsf@bauges.imag.fr>
References: <20120719213225.GA20311@sigill.intra.peff.net>
	<20120719213311.GA20385@sigill.intra.peff.net>
	<50092993.6010203@alum.mit.edu>
	<20120720154403.GB2862@sigill.intra.peff.net>
	<5009892E.9010808@kdbg.org>
	<20120720170913.GA14057@sigill.intra.peff.net>
	<CACsJy8BtcvuW2HKPSki7meyHMsvpLS0b8QG5M_083HEwy=-9EQ@mail.gmail.com>
	<10DD3DE0-E554-4BE3-A20B-FDBC73219646@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuR7z-00042Y-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab2GZQl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:41:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58201 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2GZQl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:41:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6QGd5Pq002330
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2012 18:39:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SuR7e-0000Ej-B4; Thu, 26 Jul 2012 18:41:10 +0200
In-Reply-To: <10DD3DE0-E554-4BE3-A20B-FDBC73219646@gmail.com> (Alexey
	Muranov's message of "Thu, 26 Jul 2012 18:26:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Jul 2012 18:39:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6QGd5Pq002330
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343925547.6397@cF2jEipGlWVfokvF33FdWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202275>

Alexey Muranov <alexey.muranov@gmail.com> writes:

> On 26 Jul 2012, at 14:47, Nguyen Thai Ngoc Duy wrote:
>
>> So we haven't found any way to present both branches "foo" and
>> "foo/bar" on file system at the same time. How about when we a new
>> branch introduces such a conflict, we push the new branch directly to
>> packed-refs? If we need either of them on a separate file, for fast
>> update for example, then we unpack just one and repack all refs that
>> conflict with it. Attempting to update two conflict branches in
>> parallel may impact performance, but I don't think that happens often.
>> -- 
>> Duy
>
> How about simply deprecating "/" in branch name?

Err, it's not like nobody's using this feature (Junio does a heavy use
of it in particular) ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
