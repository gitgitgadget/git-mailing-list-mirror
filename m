From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git diff vs git diff-files
Date: Mon, 13 Aug 2012 17:02:10 +0200
Message-ID: <87fw7qhm31.fsf@thomas.inf.ethz.ch>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Bernd Jendrissek <bernd.jendrissek@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 17:02:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0w9r-0002Ym-AQ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 17:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab2HMPCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 11:02:14 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:24090 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab2HMPCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 11:02:13 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 Aug
 2012 17:02:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 Aug
 2012 17:02:10 +0200
In-Reply-To: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	(Bernd Jendrissek's message of "Mon, 13 Aug 2012 10:55:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203338>

Bernd Jendrissek <bernd.jendrissek@gmail.com> writes:

> $ /usr/local/git/bin/git diff-files -p --color -- TwoStageAmp-output.net
> diff --git a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> index a5ee1e7..a9f3620 100644
> --- a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> +++ b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> @@ -1,47 +1,47 @@
> -Part unknown { Name Cout }
> -Part unknown { Name R5 }
> -Part unknown { Name R4 }
> -Part unknown { Name RE2 }
> -Part unknown { Name Q2 }
> +Part unknown { Name R8 }
>  Part unknown { Name A3 }
> -Part unknown { Name R3 }
>  Part unknown { Name A2 }
> -Part unknown { Name RE1 }
>  Part unknown { Name A1 }
> [snip]
>
> $ /usr/local/git/bin/git diff TwoStageAmp-output.netdiff --git
> a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.n
> index a5ee1e7..a9f3620 100644
> --- a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> +++ b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> @@ -1,47 +1,47 @@
> -Part unknown { Name Cout }
> -Part unknown { Name R5 }
> -Part unknown { Name R4 }
> -Part unknown { Name RE2 }
> -Part unknown { Name Q2 }
> +Part unknown { Name R8 }
>  Part unknown { Name A3 }
> -Part unknown { Name R3 }
>  Part unknown { Name A2 }
> -Part unknown { Name RE1 }
> -Part unknown { Name Q1 }  <--- Not present with diff-files output
>  Part unknown { Name A1 }
> [snip]

Can you share this repository?  Or at least the pre- and post-change
files, transferred in such a way that there won't be any whitespace
damage (your snippets above show obvious damage).  You can use

  git cat-file blob :gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net

to get at the contents of the version in the index.

Do you have any diff config that could be of interest?  A textconv
filter would be an obvious example that could produce the above, but
perhaps you could just look at

  git config --get-regexp '.*diff.*'
  grep diff .gitattributes .git/info/attributes

etc.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
