From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH/RFC 2/2 v3] Makefile: lazily compute header dependencies
Date: Sat, 28 Nov 2009 10:26:27 +0100
Message-ID: <m2bpint2yk.fsf@igel.home>
References: <4B0F8825.3040107@viscovery.net>
	<alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
	<20091127174558.GA3461@progeny.tock>
	<20091127175043.GC3461@progeny.tock>
	<20091128092948.GA8515@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 10:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEJZl-0005Ha-1q
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 10:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbZK1J01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 04:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbZK1J01
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 04:26:27 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:52058 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbZK1J00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 04:26:26 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 07DA81C0006F;
	Sat, 28 Nov 2009 10:26:29 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id EFE0E90525;
	Sat, 28 Nov 2009 10:26:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id NhfYvv0uKza4; Sat, 28 Nov 2009 10:26:27 +0100 (CET)
Received: from igel.home (DSL01.83.171.160.178.ip-pool.NEFkom.net [83.171.160.178])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 28 Nov 2009 10:26:27 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 735A3CA28F; Sat, 28 Nov 2009 10:26:27 +0100 (CET)
X-Yow: We place two copies of PEOPLE magazine in a DARK, HUMID mobile home.
 45 minutes later CYNDI LAUPER emerges wearing a BIRD CAGE on her head!
In-Reply-To: <20091128092948.GA8515@progeny.tock> (Jonathan Nieder's message
	of "Sat, 28 Nov 2009 03:29:48 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133948>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  GIT-CFLAGS: .FORCE-GIT-CFLAGS
> +	mkdir -p deps block-sha1/deps ppc/deps compat/deps \
> +		compat/regex/deps compat/nedmalloc/deps compat/fnmatch/deps \
> +		xdiff/deps

IMHO the list of directories should be factored out in a variable for
easier maintenance.

> @@ -1873,8 +1898,10 @@ distclean: clean
>  	$(RM) configure
>  
>  clean:
> -	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
> +	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
>  		$(LIB_FILE) $(XDIFF_LIB)
> +	$(RM) -r deps block-sha1/deps ppc/deps compat/deps \
> +		compat/*/deps xdiff/deps

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
