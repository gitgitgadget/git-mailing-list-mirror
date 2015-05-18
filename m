From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/8] t5520: test for failure if index has unresolved
 entries
Date: Mon, 18 May 2015 17:13:19 +0200
Organization: gmx
Message-ID: <d3f29ef8736ae4c077b754ec6e410308@www.dscho.org>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:13:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMjQ-0007Id-7V
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbbERPNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:13:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:63283 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbbERPNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:13:22 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LdLw5-1ZcoAT1A25-00iUQs; Mon, 18 May 2015 17:13:20
 +0200
In-Reply-To: <1431955978-17890-4-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:QQwYpbJjFKBZnXjs1k1esuZzDyZS94s9YexvWBw80cNde+bx1hd
 G5OybKU5+fsesJKWN0TUAFvsXgyribgo6xOmQbFY9E7gXAFyPha/86FuAAkPx7AvJE+ADBh
 1ZicbjL/NTu8Nlr1MxzXcXDCklQsdUYonn/wa9vNQfzMqMvLx5bbUxCH5mQzlmDeMePeMIf
 SPg00n0QB7H8MAC9DDUEw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269275>

Hi Paul,

On 2015-05-18 15:32, Paul Tan wrote:

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 4a2c0a1..3bc0594 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -164,6 +164,26 @@ test_expect_success 'fail if upstream branch does
> not exist' '
>  	test "$(cat file)" = file
>  '
>  
> +test_expect_success 'fail if the index has unresolved entries' '
> +	git checkout -b third second^ &&
> +	test_when_finished "git checkout -f copy && git branch -D third" &&

If you agree with my argument in 2/8, it would be nice to drop this line, too.

> +	test "$(cat file)" = file &&
> +	echo modified2 >file &&
> +	git commit -a -m modified2 &&

These two lines could be combined into "test_commit modified2 file".

Ciao,
Dscho
