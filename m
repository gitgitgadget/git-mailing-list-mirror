From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t0005: add test for trap handling from deeply nested function calls
Date: Fri, 26 Mar 2010 21:19:45 +0100
Message-ID: <201003262119.45110.j6t@kdbg.org>
References: <vm2zHZjrZOha7LnIM_9fAEAvwVZrJtZlAI9f2XI_VUsdqr51ihAMW68a5BT9tvMdRDSqk6GYlSE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvG2X-0004hs-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab0CZUVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 16:21:53 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:18592 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751217Ab0CZUVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:21:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D9E801002B;
	Fri, 26 Mar 2010 21:21:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3A1BC19F724;
	Fri, 26 Mar 2010 21:19:45 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <vm2zHZjrZOha7LnIM_9fAEAvwVZrJtZlAI9f2XI_VUsdqr51ihAMW68a5BT9tvMdRDSqk6GYlSE@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143280>

On Freitag, 26. M=E4rz 2010, Brandon Casey wrote:
> +test_expect_success 'trap triggered in deeply nested function works
> correctly' ' +	(atrap () { exit 0; }
> +	 func3 () { exit 1; }
> +	 func2 () { func3; }
> +	 func1 () { trap atrap EXIT; func2; }
> +	 func1)
> +'

What do you want to achieve with this test? That /usr/xpg4/bin/sh is no=
t used=20
on Solaris?

If git-bisect triggers this bug in /usr/xpg4/bin/sh and if this is our =
shell=20
of choice on Solaris, wouldn't it be better to work around it in git-bi=
sect?

-- Hannes
