From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 11/18] Add tests for line history browser
Date: Thu, 5 Aug 2010 22:38:36 +0200
Message-ID: <201008052238.36892.trast@student.ethz.ch>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com> <1281024717-7855-12-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7gm-00009I-N8
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078Ab0HEVJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 17:09:06 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14888 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab0HEVJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:09:05 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 5 Aug
 2010 23:09:03 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 5 Aug 2010 23:09:03
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1281024717-7855-12-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152715>

Bo Yang wrote:
> t4301: for simple linear history only
> t4302: for history containing merge
> 
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---

Note that applying this with --whitespace=fix will make the tests
fail, as there are diffs contained which must preserve the SP TAB
sequence of context lines.

> +test_expect_success \
> +    'validate the output.' \
> +    'test_cmp current-path0 expected-path0 &&
> +	 test_cmp current-path1 expected-path1 &&
> +	 test_cmp current-pathall expected-pathall &&
> +	 test_cmp current-linenum expected-linenum &&
> +	 test_cmp current-always expected-always'

Please split these and move them into the tests that generate them.

I also think the style these days is

test_expect_success 'description' '
	line 1 &&
	line 2
'

but please only convert them now if you see an obvious way to do it
automatically.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
