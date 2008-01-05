From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] t/t7600: avoid GNUism in grep
Date: Sat, 05 Jan 2008 07:14:09 +0000
Message-ID: <477F2E41.60105@hashpling.org>
References: <1199506008-12225-1-git-send-email-vmiklos@frugalware.org> <7v63y8g40u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 08:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB3FS-0003LJ-1l
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 08:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYAEHOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 02:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYAEHOq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 02:14:46 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:51486 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYAEHOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 02:14:45 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1JB3En-00039K-EY; Sat, 05 Jan 2008 07:14:37 +0000
Received: from [192.168.1.29] (heisenberg2.hashpling.org [192.168.1.29])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m057E8e8021017;
	Sat, 5 Jan 2008 07:14:13 GMT
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v63y8g40u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69647>

Junio C Hamano wrote:
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 6424c6e..21862ac 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -371,7 +371,7 @@ test_expect_success 'override config option -n' '
>  	git merge --summary c2 >diffstat.txt &&
>  	verify_merge file result.1-5 msg.1-5 &&
>  	verify_parents $c1 $c2 &&
> -	if ! grep -e "^ file | \+2 +-$" diffstat.txt
> +	if ! grep -e "^ file |  *2 +-$" diffstat.txt
>  	then
>  		echo "[OOPS] diffstat was not generated"
>  	fi
> @@ -386,7 +386,7 @@ test_expect_success 'override config option --summary' '
>  	git merge -n c2 >diffstat.txt &&
>  	verify_merge file result.1-5 msg.1-5 &&
>  	verify_parents $c1 $c2 &&
> -	if grep -e "^ file | \+2 +-$" diffstat.txt
> +	if grep -e "^ file |  +2 +-$" diffstat.txt
>  	then
>  		echo "[OOPS] diffstat was generated"
>  		false

I'm not sure that you quite made the change you meant to change in the 
second chunk ( '  +' vs. '  *' ? ).

Charles.
