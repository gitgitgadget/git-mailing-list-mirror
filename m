From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 14:10:53 +0200
Message-ID: <m2r4uuhnzm.fsf@igel.home>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
	<4FA904C3.7070208@viscovery.net>
	<CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 14:11:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRjFw-0006Py-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 14:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2EHMK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 08:10:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44044 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2EHMK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 08:10:58 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Vn00H2Nvgz4LDdt;
	Tue,  8 May 2012 14:10:55 +0200 (CEST)
Received: from igel.home (ppp-93-104-129-118.dynamic.mnet-online.de [93.104.129.118])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Vn00H1NNpz4KK3B;
	Tue,  8 May 2012 14:10:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5D646CA2A9; Tue,  8 May 2012 14:10:54 +0200 (CEST)
X-Yow: Loni Anderson's hair should be LEGALIZED!!
In-Reply-To: <CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 8 May 2012 13:50:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197355>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> +test_expect_failure 'committing to empty submodule does not create
> (null) branch' '
> +       test_create_repo empty-repo &&
> +       git submodule add ./empty-repo empty-submodule &&
> +       (
> +               cd empty-submodule &&
> +               echo "foo" > bar.txt &&
> +               git add bar.txt &&
> +               git commit -m. &&
> +               ! (git show-ref | grep "(null)")

You don't need the parens, since ! operates on the whole pipeline.  (And
for grouping the shell language uses { } instead of ( ).)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
