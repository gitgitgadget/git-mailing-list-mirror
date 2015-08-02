From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 0/11] port tag.c to use ref-filter APIs
Date: Sun, 02 Aug 2015 19:32:49 +0200
Message-ID: <vpqoaipbnpa.fsf@anie.imag.fr>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 19:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLxHV-0005Yq-CN
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 19:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbHBRmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 13:42:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39346 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbHBRmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 13:42:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t72HdX6Z019517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 2 Aug 2015 19:40:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t72HX1oH006768;
	Sun, 2 Aug 2015 19:33:16 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 02 Aug 2015 19:40:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t72HdX6Z019517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1439142054.85911@xtwR+TWthhC10zLjni+DFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275145>

Karthik Nayak <karthik.188@gmail.com> writes:

> +test_expect_success 'no padding when `padright` length is smaller than atom length' '
> +    cat >expect <<-\EOF &&
> +    refs/heads/master|
> +    refs/heads/side|
> +    refs/odd/spot|
> +    refs/tags/double-tag|
> +    refs/tags/four|
> +    refs/tags/one|
> +    refs/tags/signed-tag|
> +    refs/tags/three|
> +    refs/tags/two|
> +    EOF
> +    git for-each-ref --format="%(padright:5)%(refname)|" >actual &&
>      test_cmp expect actual
>  '

Nit: I think the test would be better with padright:15 for example, to
show that some lines are aligned and some go beyond the 15 columns.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
