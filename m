From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9824: fix wrong reference value
Date: Fri, 29 Apr 2016 10:34:13 -0700
Message-ID: <xmqqmvocz5d6.fsf@gitster.mtv.corp.google.com>
References: <0102015462bcd1c3-4196e36b-515b-447f-beca-649922456098-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:34:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCJ5-0007s4-5J
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcD2ReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:34:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbcD2ReR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:34:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8107155D2;
	Fri, 29 Apr 2016 13:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+EFHyfcM39RHWCIm2N/FE7U2vbM=; b=XBt0x1
	9b38DXr69hueesmv4XXl6UUlURGx68ZLGzeZ4NTOnnyv+166PRXzXsgNTub89ov4
	y6kLvEaKz+1T7pI5LzjENENNpyBDAVgSdpNuPOBgDsqEJzCV9kGG3aqg5RpYsbqZ
	zYHMXv5jz9IaT0pr76yuGVlUhnlVO6XLKnBSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a+k2xlJtEy4WrLRLY0BtnvYAdyD+HsSU
	pnqbgK4b4ynWsrBFokCek/4EwSv4dM0whyscuSBEYLV03CYZqJHswvyEfGROS+jP
	F/UyHx5HaMTZWiX6dY+Fm2mYC0hr8lbdK+QCR3AHkOUddNSvy6ny5Y9twbckc596
	B9wYjCiYweo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FB08155D1;
	Fri, 29 Apr 2016 13:34:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 065EB155D0;
	Fri, 29 Apr 2016 13:34:14 -0400 (EDT)
In-Reply-To: <0102015462bcd1c3-4196e36b-515b-447f-beca-649922456098-000000@eu-west-1.amazonses.com>
	(Lars Schneider's message of "Fri, 29 Apr 2016 15:57:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97DBF336-0E30-11E6-98F0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293032>

Lars Schneider <larsxschneider@gmail.com> writes:

> 0492eb4 fixed a broken &&-chain in this test which broke the test as it
> checked for a wrong size. The expected size of the file under test is
> 39 bytes. The test checked that the size is 13 bytes. Fix the reference
> value to make the test pass, again.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

That breaking "fix" seems to have been acked by you.

It was sort of clear that SZEDER didn't actually ran the test from
the patch, saying "As far as I can tell after eyeballing the test
script,", but you obviously didn't actually have a chance to test it
until now.

Thanks for fixing it before it hits 'master'; this time I think it
is safe to assume that this was actually tested ;-)


>  t/t9824-git-p4-git-lfs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
> index 64f8d18..3fc6790 100755
> --- a/t/t9824-git-p4-git-lfs.sh
> +++ b/t/t9824-git-p4-git-lfs.sh
> @@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
>  		# We only import HEAD here ("@all" is missing!)
>  		git p4 clone --destination="$git" //depot &&
>  
> -		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" &&
> +		test_file_in_lfs file6.bin 39 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" &&
>  		test_file_count_in_dir ".git/lfs/objects" 1 &&
>  
>  		cat >expect <<-\EOF &&
>
> --
> https://github.com/git/git/pull/235
