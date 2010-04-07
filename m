From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 20:49:08 +0200
Message-ID: <201004072049.08819.j6t@kdbg.org>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com> <alpine.LFD.2.00.1004070859540.7232@xanadu.home> <20100407144555.GA23911@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzaLZ-0003VS-31
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049Ab0DGSvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 14:51:24 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:36675 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756503Ab0DGSvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:51:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AE962CDF92;
	Wed,  7 Apr 2010 20:51:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E4F4F19F5BF;
	Wed,  7 Apr 2010 20:49:08 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100407144555.GA23911@fredrik-laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144268>

On Mittwoch, 7. April 2010, Fredrik Kuivinen wrote:
> As I mentioned in another mail in this thread, our mutex
> implementation on WIN32 already is recursive. It is implemented on top
> of the CRITICAL_SECTION type, which is recursive. See
> http://msdn.microsoft.com/en-us/library/ms682530%28VS.85%29.aspx

Very true!

> +	if (pthread_mutexattr_settype(&a, PTHREAD_MUTEX_RECURSIVE))

I wonder how many pthreads implementations there are that do not support 
recursive mutexes...

-- Hannes
