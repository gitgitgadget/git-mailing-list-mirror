From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 20:54:25 +0100
Message-ID: <201012212054.27054.j6t@kdbg.org>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com> <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com> <7vbp4f9gzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Thiago Farina <tfransosi@gmail.com>,
	"Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 20:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8I8-0005cu-9v
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 20:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0LUTyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 14:54:31 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:43392 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752498Ab0LUTya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 14:54:30 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CBD51A7EB6;
	Tue, 21 Dec 2010 20:53:38 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 61DB019F642;
	Tue, 21 Dec 2010 20:54:27 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vbp4f9gzh.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164048>

On Dienstag, 21. Dezember 2010, Junio C Hamano wrote:
> A more interesting topic is why the try-to-free-pack-memory logic needs to
> be disabled in the first place.  3a09425 (Do not call release_pack_memory
> in malloc wrappers when GIT_TRACE is used, 2010-05-08) explains that it is
> to avoid a race on Windows, and it looks like a workaround not a solution
> ("can be called without locking"---"why aren't we locking then?").
>
> Not that it matters in the context of "trace", which is a debugging
> facility, that this is a workaround.

Exactly. A clean implementation is not worth the effort for this debugging 
facility.

BTW, these days it is not just Windows that is affected because we use threads 
in start_async everywhere if possible.

-- Hannes
