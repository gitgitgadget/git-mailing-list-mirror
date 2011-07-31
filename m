From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 3/4] git-p4: one test missing config git-p4.skipSubmitEditCheck
Date: Sun, 31 Jul 2011 11:01:10 +0100
Message-ID: <4E3527E6.8080303@diamand.org>
References: <20110731003557.GA4867@arf.padd.com> <20110731003936.GD4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 12:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnSqF-0000YJ-6e
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 12:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab1GaKBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 06:01:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56354 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1GaKBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 06:01:14 -0400
Received: by wyg8 with SMTP id 8so993507wyg.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 03:01:13 -0700 (PDT)
Received: by 10.227.200.198 with SMTP id ex6mr4618458wbb.73.1312106473138;
        Sun, 31 Jul 2011 03:01:13 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id n21sm2571052wed.43.2011.07.31.03.01.11
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 03:01:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <20110731003936.GD4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178234>

On 31/07/11 01:39, Pete Wyckoff wrote:
> Add this missing line in one of the tests.  Otherwise, on fast
> machines, the following git-p4 commit will complain that nobody
> edited the submission message.

Thanks for fixing this.

Acked.


>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   t/t9800-git-p4.sh |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 04d8413..24a8b79 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -207,6 +207,7 @@ test_expect_success 'refuse to preserve users without perms' '
>   	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	p4_ungrant_admin alice&&
> +	git config git-p4.skipSubmitEditCheck true&&
>   	echo "username-noperms: a change by $bobuser">>  file1&&
>   	git commit --author "$bobuser<$bobemail>" -m "perms: a change by $bobuser" file1&&
>   	! P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user&&
