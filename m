From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH] clean: respect pathspecs with "-d"
Date: Mon, 10 Mar 2014 21:02:35 +0100
Message-ID: <20140310200235.GA14112@ruderich.org>
References: <CABN9-fcpyDogh45WPwuS1qgkE1jLuOAtejuW=fGCKNNyNm3DEQ@mail.gmail.com>
 <20140310172002.GB29801@sigill.intra.peff.net>
 <20140310172215.GC29801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Robin Pedersen <robinp@snap.tv>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:02:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6PQ-0004VM-Cr
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbaCJUCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:02:41 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:44056 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbaCJUCj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:02:39 -0400
Received: from localhost (pD9E9677D.dip0.t-ipconnect.de [::ffff:217.233.103.125])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Mon, 10 Mar 2014 21:02:37 +0100
  id 0000000000020071.00000000531E1A5E.00006F4A
Content-Disposition: inline
In-Reply-To: <20140310172215.GC29801@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243805>

On Mon, Mar 10, 2014 at 01:22:15PM -0400, Jeff King wrote:
> +test_expect_success 'git clean -d respects pathspecs' '
> +	mkdir foo &&
> +	mkdir foobar &&
> +	git clean -df foobar &&
> +	test_path_is_dir foo &&
> +	test_path_is_missing foobar
> +'
> +
>  test_done

I think we should also test removing foo, which was also in the
original report, to make sure we don't match prefixes, e.g.:

test_expect_success 'git clean -d respects pathspecs' '
	mkdir foo &&
	mkdir foobar &&
	git clean -df foo &&
	test_path_is_missing foo &&
	test_path_is_dir foobar
'

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
