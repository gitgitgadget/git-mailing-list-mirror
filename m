From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of  Pthreads API
Date: Fri, 8 Jan 2010 21:40:36 +0100
Message-ID: <201001082140.36717.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org> <20100108033232.GA28263@dpotapov.dyndns.org> <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	msysgit <msysgit@googlegroups.com>, git@vger.kernel.org,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 08 21:41:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLeK-00067D-PM
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab0AHUla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941Ab0AHUl3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:41:29 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51936 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753915Ab0AHUl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 15:41:29 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2B8FCCDF83;
	Fri,  8 Jan 2010 21:41:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C4A7D19F6C6;
	Fri,  8 Jan 2010 21:40:36 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136476>

On Freitag, 8. Januar 2010, Erik Faye-Lund wrote:
> On Fri, Jan 8, 2010 at 4:32 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > AFAIK, Win32 API assumes that reading LONG is always atomic, so
> > the critical section is not really necesary here, but you need
> > to declare 'waiters' as 'volatile':
>
> "Simple reads and writes to properly-aligned 32-bit variables are
> atomic operations."
> http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx
>
> In other words: Yes, you are right.

Quite frankly, I do not want to stretch this statement to apply to the MinGW 
compiler. The code in question is not performance critical anyway. I'd prefer 
to leave it as is - it's undergone 2 months of testing already. Besides, 
IMHO, it is much more readable the way it is written.

-- Hannes
