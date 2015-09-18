From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Fri, 18 Sep 2015 11:13:45 +0200
Message-ID: <vpqeghwks3a.fsf@anie.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
	<20150917213619.GI17201@serenity.lan>
	<xmqq37ycitps.fsf@gitster.mtv.corp.google.com>
	<vpqoah0kxtb.fsf@anie.imag.fr> <20150918084208.GJ17201@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 18 11:14:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcrk0-00045z-MW
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 11:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbbIRJNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 05:13:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56244 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbbIRJNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 05:13:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8I9Dil3007160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 11:13:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8I9Dku2007702;
	Fri, 18 Sep 2015 11:13:46 +0200
In-Reply-To: <20150918084208.GJ17201@serenity.lan> (John Keeping's message of
	"Fri, 18 Sep 2015 09:42:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 11:13:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8I9Dil3007160
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443172426.72079@AsO+DwB0RutNHPV3kqdrEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278187>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Sep 18, 2015 at 09:10:08AM +0200, Matthieu Moy wrote:
>
>> The `commit` may be omitted and defaults to HEAD if this is the final
>> argument.
>
> I find that slightly confusing, although that might just be me.  It's
> slightly longer, but I would write:
>
> 	The `commit` may be omitted if this is the final argument, in
> 	which case it defaults to `HEAD`.

Probably clearer indeed.

> I also had a look at git-branch(1), which has similar `--merged` and
> `--no-merged` options and says:
>
> 	Only list branches whose tips are reachable from the specified
> 	commit (HEAD if not specified).  Implies `--list`.

I think this lacks the "may be omitted if this is the final argument",
which is actually the most confusing (see the other thread "git status
-u is mildly astonishing" for an example of similar confusion).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
