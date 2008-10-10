From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Sat, 11 Oct 2008 09:39:49 +1100
Message-ID: <18671.55733.970601.454074@cargo.ozlabs.ibm.com>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com>
	<1223173855-6173-1-git-send-email-dpotapov@gmail.com>
	<1223173855-6173-2-git-send-email-dpotapov@gmail.com>
	<48E9B997.1010006@viscovery.net>
	<20081007001652.GR21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 00:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoQfe-0006qh-KX
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 00:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbYJJWkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYJJWkE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 18:40:04 -0400
Received: from ozlabs.org ([203.10.76.45]:36157 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbYJJWkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 18:40:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7F071DE18A; Sat, 11 Oct 2008 09:39:59 +1100 (EST)
In-Reply-To: <20081007001652.GR21650@dpotapov.dyndns.org>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97956>

Dmitry Potapov writes:

> This allows multiple paths to be specified on stdin.
> 
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
> On Mon, Oct 06, 2008 at 09:09:11AM +0200, Johannes Sixt wrote:
> > 
> > The least that is needed is fflush(stdout) in this loop (after each
> > iteration!)
> 
> Thanks. Somehow, I forgot about it though it is quite obvious.
> I have added maybe_flush_or_die().

Actually, what was done with git diff-tree --stdin was to have it do
fflush(stdout) when it sees a blank line in the input.  That gives the
calling program a way to get the output up to that point without
having to do a flush for every line of output.

Paul.
