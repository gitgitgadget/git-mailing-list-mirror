From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Thu, 4 Aug 2011 06:05:45 +0200
Message-ID: <201108040605.46420.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 06:06:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopCD-0002zs-RM
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab1HDEF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:05:57 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:35259 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab1HDEF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:05:56 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 14403A619A;
	Thu,  4 Aug 2011 06:05:47 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312222025-28453-12-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178667>

On Monday 01 August 2011 20:06:58 Ramkumar Ramachandra wrote:
> +
> +test_expect_success 'cherry-pick persists opts correctly' '
> +	rm -rf .git/sequencer &&
> +	pristine_detach initial &&

pristine_detach() does a "rm -rf .git/sequencer" already.

> +	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience
> -X ours base..anotherpick && +	test_path_is_dir .git/sequencer &&
> +	test_path_is_file .git/sequencer/head &&
> +	test_path_is_file .git/sequencer/todo &&
> +	test_path_is_file .git/sequencer/opts &&
> +	echo "true" >expect

"&&" is missing at the end of the line.

> +	git config --file=.git/sequencer/opts --get-all options.signoff >actual
> &&
> +	test_cmp expect actual &&
> +	echo "1" >expect

"&&" is missing at the end of the line.

> +	git config --file=.git/sequencer/opts --get-all options.mainline >actual
> &&
> +	test_cmp expect actual &&
> +	echo "recursive" >expect

"&&" is missing at the end of the line.

> +	git config --file=.git/sequencer/opts --get-all options.strategy >actual
> &&
> +	test_cmp expect actual &&
> +	cat >expect <<-\EOF

"&&" is missing at the end of the line.

> +	patience
> +	ours
> +	EOF
> +	git config --file=.git/sequencer/opts --get-all options.strategy-option
> >actual &&
> >+	test_cmp expect actual
>  '

Thanks,
Christian.
