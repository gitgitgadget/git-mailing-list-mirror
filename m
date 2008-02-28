From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Thu, 28 Feb 2008 21:49:36 +0100
Message-ID: <200802282149.36748.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-21-git-send-email-johannes.sixt@telecom.at> <47C680A4.6050309@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 21:50:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUphm-00028g-Qk
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYB1Uti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYB1Uti
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:49:38 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:60120 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYB1Uti (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:49:38 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 20EA29751A;
	Thu, 28 Feb 2008 21:49:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DFECB5B9E3;
	Thu, 28 Feb 2008 21:49:36 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <47C680A4.6050309@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75452>

On Thursday 28 February 2008 10:36, Paolo Bonzini wrote:
> Johannes Sixt wrote:
> > This emulation of poll() is by far not general. It assumes that the
> > fds that are to be waited for are connected to pipes. The pipes are
> > polled in a loop until data becomes available in at least one of them.
> > If only a single fd is waited for, the implementation actually does
> > not wait at all, but assumes that a subsequent read() will block.
>
> For the future, would it be better to first use WaitForMultipleObjects,
> and then use PeekNamedPipe to find which handles have data on it?
> That's how the mingw port of GNU Smalltalk does it.

I tried but I failed. If you can show me code where WaitForMultipleObjects
works on handles that MSVCRT.DLL's open() created, I'll gladly accept it!

-- Hannes
