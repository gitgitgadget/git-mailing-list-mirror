From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix typo in nedmalloc warning fix
Date: Thu, 11 Jun 2009 23:13:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906112313050.26154@pacific.mpi-cbg.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de>
 <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de> <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
 <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302> <7viqjefxcv.fsf@alter.siame se.dyndns.org> <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> <7vprdl9qon.fsf@alter.siames e.dyndns.org>
 <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302> <7vzlcizn3w.fsf@a! lter.siamese.dyndns.org> <CD46A3E1-A85C-4D03-854C-973B91ACC506@zib.de> <4A2F7C80.1090807@viscovery.net> <4A316EA8.1040203@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 23:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MErZf-0005rG-4c
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 23:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbZFKVM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757088AbZFKVMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 17:12:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:49930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754732AbZFKVMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 17:12:25 -0400
Received: (qmail invoked by alias); 11 Jun 2009 21:12:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 11 Jun 2009 23:12:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rp1AQ4Tfrr2CJ0p/MR5wjhNB992BriqimpXmspk
	Qxr1D1VAc/yjM9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A316EA8.1040203@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121362>

Hi,

On Thu, 11 Jun 2009, Johannes Sixt wrote:

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Johannes Sixt schrieb:
>  > Please don't advance this series to master just yet: I see severe breakage
>  > with the nedmalloc patch on one of my systems, but I ran out of time to
>  > investigate further. (And I'm afraid I can continue only next Monday.)
> 
>  So, I have the failure on my other system as well, and this is the fix ;)
> 
>  -- Hannes
> 
>  compat/nedmalloc/malloc.c.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
> index b5b1495..74c42e3 100644
> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -2543,7 +2543,7 @@ struct malloc_params {
>  static struct malloc_params mparams;
> 
>  /* Ensure mparams initialized */
> -#define ensure_initialization() ((void)(mparams.magic == 0 ||
> init_mparams()))
> +#define ensure_initialization() ((void)(mparams.magic != 0 ||
> init_mparams()))

Aargh!

Thanks for catching this stupid bug,
Dscho
