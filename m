From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv3 5/8] Teach "-m <msg>" and "-F <file>" to "git notes edit"
Date: Wed, 29 Jul 2009 09:57:34 +0200
Message-ID: <200907290957.36000.trast@student.ethz.ch>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <1248834326-31488-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <git@vger.kernel.org>,
	<johannes.schindelin@gmx.de>, <tavestbo@trolltech.com>,
	<git@drmicha.warpmail.net>, <chriscool@tuxfamily.org>,
	<spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW48D-0004ag-6P
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbZG2IDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbZG2IDP
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:03:15 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:40561 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbZG2IDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:03:12 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 04:03:12 EDT
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 29 Jul
 2009 09:57:43 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 29 Jul
 2009 09:57:44 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <1248834326-31488-6-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124317>

Johan Herland wrote:
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
[...]
> +cat > expect-m-and-F << EOF
> +commit 15023535574ded8b1a89052b32673f84cf9582b8
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:16:13 2005 -0700
> +
> +    4th
> +
> +Notes:
> +    spam
> +    
> +    xyzzy
> +    
> +    foo

There's significant trailing whitespace here (in the lines between
spam, xyzzy and foo) that initially broke the test for me because I
use apply.whitespace=fix.  Can you guard the whitespace if it is
really important, with something like

sed 's/#$//' > expect <<EOF
whitespace:    #
EOF

Thanks!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
