From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] git-send-email: handle email address with quoted comma
Date: Thu, 18 Dec 2008 22:38:06 -0800
Message-ID: <20081219063806.GA5425@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Wu Fengguang <fengguang.wu@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 07:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDZ1M-000375-GQ
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 07:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbYLSGiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 01:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbYLSGiS
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 01:38:18 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:34575 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbYLSGiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 01:38:18 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net
	([71.119.193.199] helo=macbookpro.ftbfs.org ident=Debian-exim)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LDYzx-0008Nd-1j; Thu, 18 Dec 2008 22:38:13 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LDYzu-0001Qp-Hb; Thu, 18 Dec 2008 22:38:06 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103550>

Howdy,

> +sub split_addrs($) {
> +    my ($addrs) = @_;
> +
> +	return &quotewords('\s*,\s*', 1, $addrs);
> +}
> +

According to the documentation of Text::ParseWords,

 The &*quotewords() functions simply call &parse_line(), so if you're
 only splitting one line you can call &parse_line() directly and save
 a function call.

so quotewords could be replaced by parse_line.  I don't know if that's
less readable, though.

-- 
Matt                                                 http://ftbfs.org/
