From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 12:12:06 +0200
Message-ID: <48E1FB76.1040500@op5.se>
References: <20080930080355.GA19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:13:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkcER-0001KC-8w
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbYI3KMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 06:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYI3KMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:12:16 -0400
Received: from mail.op5.se ([193.201.96.20]:47644 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbYI3KMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:12:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 75F8D1B8004E;
	Tue, 30 Sep 2008 12:03:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TA5GYQA8feay; Tue, 30 Sep 2008 12:03:26 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 43CA21B80049;
	Tue, 30 Sep 2008 12:03:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080930080355.GA19605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97089>

Jeff King wrote:
> We try to avoid using the "-q" or "-e" options, as they are
> largely useless, as explained in aadbe44f.
> 
> There is one exception for "-e" here, which is in t7701 used
> to produce an "or" of patterns. This can be rewritten as an
> egrep pattern.
> 
> This patch also removes use of "grep -F" in favor of the
> more widely available "fgrep".
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> 
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 4db4ac4..cb14425 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -32,7 +32,7 @@ test_expect_success 'bad setup: invalid .git file format' '
>  		echo "git rev-parse accepted an invalid .git file"
>  		false
>  	fi &&
> -	if ! grep -qe "Invalid gitfile format" .err
> +	if ! grep "Invalid gitfile format" .err

Doesn't output need to be redirected when you drop '-q'?

Other than that, this looks good after a quick scan.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
