From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Porting git to HP NonStop
Date: Sat, 11 Aug 2012 10:20:16 +0200
Message-ID: <502615C0.1050406@kdbg.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 10:21:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T06wS-00037o-Un
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 10:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab2HKIU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 04:20:26 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:64893 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752588Ab2HKIUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 04:20:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 971C6130054;
	Sat, 11 Aug 2012 10:20:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 28AC819F37F;
	Sat, 11 Aug 2012 10:20:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203282>

Am 10.08.2012 18:27, schrieb Shawn Pearce:
> There is no need to define your own mmap(). Define NO_MMAP=1 in the
> Makefile. Git already has its own fake mmap and knows how to write it
> back to disk when making changes.

Or better to say: the fake mmap has functionality that is sufficient for
git. In particular, it does *not* write back changes to disk (it
supports only MAP_PRIVATE), and the mapped area does not change if the
file is changed by a third party.

-- Hannes
