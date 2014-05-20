From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t6006 (rev-list-format): quote format strings to avoid
 error on some shells
Date: Tue, 20 May 2014 16:03:07 +0100
Message-ID: <537B6EAB.2070301@ramsay1.demon.co.uk>
References: <537B5E8C.3070803@ramsay1.demon.co.uk> <7a4473fce2948c31f561c6002ab0b1d5ab0ee841.1400597264.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 17:03:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmlZT-00072k-4F
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 17:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbaETPDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 11:03:11 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:48626 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750745AbaETPDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 11:03:11 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 62018AC4093;
	Tue, 20 May 2014 16:03:14 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 14F20AC4071;
	Tue, 20 May 2014 16:03:14 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Tue, 20 May 2014 16:03:13 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <7a4473fce2948c31f561c6002ab0b1d5ab0ee841.1400597264.git.Alex.Crezoff@gmail.com>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249691>

On 20/05/14 15:48, Alexey Shumkin wrote:
> Added in 0a144b3 (t4205, t6006: add failing tests for the case when
> i18n.logOutputEncoding is set, 2014-05-19) tests give no error
> (somehow) with Bash as /bin/sh but fail for some other shells.
> 
> Quote format strings to avoid errors.
> 
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> Suggested-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  t/t6006-rev-list-format.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index c6e9a73..19434ad 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -149,7 +149,7 @@ commit $head1
>  $added
>  EOF
>  
> -test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
> +test_format subject-truncated "%<($truncate_count,trunc)%s" <<EOF
>  commit $head2
>  changed (ge${changed_utf8_part}ndert)..
>  commit $head1
> @@ -259,7 +259,7 @@ commit $head1
>  $added_iso88591
>  EOF
>  
> -test_format complex-subject-trunc %<($truncate_count,trunc)%s <<EOF
> +test_format complex-subject-trunc "%<($truncate_count,trunc)%s" <<EOF
>  commit $head3
>  Test printing of c..
>  commit $head2
> @@ -268,7 +268,7 @@ commit $head1
>  added (hinzugef${added_utf8_part_iso88591}gt..
>  EOF
>  
> -test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s <<EOF
> +test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
>  commit $head3
>  Test prin..ex bodies
>  commit $head2
> @@ -277,7 +277,7 @@ commit $head1
>  added (hi..f${added_utf8_part_iso88591}gt) foo
>  EOF
>  
> -test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s <<EOF
> +test_format complex-subject-ltrunc "%<($truncate_count,ltrunc)%s" <<EOF
>  commit $head3
>  .. of complex bodies
>  commit $head2
> @@ -314,7 +314,7 @@ commit $head1
>  $added
>  EOF
>  
> -test_format complex-subject-commitencoding-unset-trunc %<($truncate_count,trunc)%s <<EOF
> +test_format complex-subject-commitencoding-unset-trunc "%<($truncate_count,trunc)%s" <<EOF
>  commit $head3
>  Test printing of c..
>  commit $head2
> @@ -323,7 +323,7 @@ commit $head1
>  added (hinzugef${added_utf8_part}gt..
>  EOF
>  
> -test_format complex-subject-commitencoding-unset-mtrunc %<($truncate_count,mtrunc)%s <<EOF
> +test_format complex-subject-commitencoding-unset-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
>  commit $head3
>  Test prin..ex bodies
>  commit $head2
> @@ -332,7 +332,7 @@ commit $head1
>  added (hi..f${added_utf8_part}gt) foo
>  EOF
>  
> -test_format complex-subject-commitencoding-unset-ltrunc %<($truncate_count,ltrunc)%s <<EOF
> +test_format complex-subject-commitencoding-unset-ltrunc "%<($truncate_count,ltrunc)%s" <<EOF
>  commit $head3
>  .. of complex bodies
>  commit $head2
> 

Yep, actually using string quotes works just as well! :-P

Thanks!

ATB,
Ramsay Jones
