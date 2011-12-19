From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH] lf_to_crlf_filter(): tell the caller we added "\n" when
 draining
Date: Mon, 19 Dec 2011 11:19:19 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1112191114010.4136@shipon.roxen.com>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk> <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk> <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
 <20111128104812.GA2386@beez.lab.cmartin.tk> <7viplggoq9.fsf@alter.siamese.dyndns.org>
 <7vaa6sgmt3.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1817792895-1324289959=:4136"
Cc: Git Mailing list <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 11:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcaJh-00044l-B5
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 11:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab1LSKT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 05:19:27 -0500
Received: from mail.roxen.com ([212.247.29.220]:56249 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab1LSKT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 05:19:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 643486280CC;
	Mon, 19 Dec 2011 11:19:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrqbbctXJ9Ja; Mon, 19 Dec 2011 11:19:20 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id EB8496280DE;
	Mon, 19 Dec 2011 11:19:19 +0100 (CET)
In-Reply-To: <7vaa6sgmt3.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187444>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1817792895-1324289959=:4136
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 16 Dec 2011, Junio C Hamano wrote:

> This can only happen when the input size is multiple of the
> buffer size of the cascade filter (16k) and ends with an LF,
> but in such a case, the code forgot to tell the caller that
> it added the "\n" it could not add during the last round.

We probably ought to have a corresponding test in the testsuite.
A blob consisting of a singe 'A' followed by 8192 linefeeds should
be sufficient to trigger the problems.

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB
---559023410-1817792895-1324289959=:4136--
