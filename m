From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Add test for sanitized work-tree behaviour
Date: Thu, 26 Jul 2007 00:15:34 -0700
Message-ID: <7vfy3b8wkp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260732130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:15:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxZV-0005d4-37
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799AbXGZHPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762643AbXGZHPh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:15:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60431 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759799AbXGZHPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:15:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726071534.FGPQ1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 03:15:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U7Fa1X00J1kojtg0000000; Thu, 26 Jul 2007 03:15:35 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53798>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> ...
> @@ -3,90 +3,109 @@
>  test_description='test separate work tree'
>  . ./test-lib.sh
>  
> +i=1
> +
>  test_rev_parse() {
> - ...
> +	name="$1"
> +	for option in --is-bare-repository --is-inside-git-dir \
> +		--is-inside-work-tree --show-prefix
> +	do
> +		shift
> +		test_expect_success "$name: $option" \
> +			"test '$1' = \"\$(git rev-parse $option)\""

> +i=$(($i+1))
> +test $i = $STOPI && gdb --args git rev-parse $option

Eh?
