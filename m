From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: more graceful handling of invalid commands
Date: Tue, 27 Oct 2009 16:21:08 +0200
Message-ID: <200910271521.09164.trast@student.ethz.ch>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com> <20091027133932.60b996c3@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <kusmabite@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Jan =?utf-8?q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2mwc-00068F-Qs
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbZJ0OWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 10:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbZJ0OWE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:22:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:13831 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbZJ0OWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 10:22:03 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 27 Oct
 2009 15:22:06 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 27 Oct
 2009 15:21:44 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091027133932.60b996c3@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131342>

Jan Kr=C3=BCger wrote:
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a1879e3..fdd8eb6 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -416,7 +416,12 @@ do_next () {
>  		;;
>  	*)
>  		warn "Unknown command: $command $sha1 $rest"
> -		die_with_patch $sha1 "Please fix this in the file $TODO."
> +		if git rev-parse --verify -q "$sha" >/dev/null

I think you need s/sha/sha1/ here?

> +		then
> +			die_with_patch $sha1 "Please fix this in the file $TODO."
> +		else
> +			die "Please fix this in the file $TODO."
> +		fi

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
