From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t6006 (rev-list-format): quote format strings to avoid
 error on some shells
Date: Wed, 21 May 2014 16:59:33 +0400
Message-ID: <20140521125933.GA4544@dell-note>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
 <7a4473fce2948c31f561c6002ab0b1d5ab0ee841.1400597264.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 14:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn67T-00060x-WE
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 14:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbaEUM7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 08:59:40 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:52282 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaEUM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 08:59:39 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so1525110lan.23
        for <git@vger.kernel.org>; Wed, 21 May 2014 05:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X8HYXSAaJSL3bQMHGljel7YY3aEjfNJZZB7OOd6TYBc=;
        b=F9AhrBTaTJeThcZAE0xf+EmZL2+/fkJSeik9uY6fo76zjbOAIVykqIdov+Mvl/vRny
         tTafJ6pL0MuBCOxNpYuBkCxmW37xTQvwO1mE/4OsC+fR2aNsB67EBvNiX/+k+Qluhjz6
         bmr6GM+F4EWMZXc0nM7MxOeKjPh8/dSpzgz0VQ/t/G20CY0+/eksO2hTmiS6s2sXuDEq
         6ijtmnFr20CwzPTo4IGSPZlvf47MBOT09e0CvnHnB290VsCFrOGWJy8JgT9DHCcm03Ag
         vkXwra8NLH7lHEYxcwnrHvb9pDS+NRPPRzr4+HPCOIzzzivoZp0Re7U/P3g3KVcyYUaB
         5Z6A==
X-Received: by 10.113.3.167 with SMTP id bx7mr7384841lbd.64.1400677177958;
        Wed, 21 May 2014 05:59:37 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id o8sm11891032laj.10.2014.05.21.05.59.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 05:59:37 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <7a4473fce2948c31f561c6002ab0b1d5ab0ee841.1400597264.git.Alex.Crezoff@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249793>

This patch is redundant then.
It will be squashed into next patch series.

On Tue, May 20, 2014 at 06:48:43PM +0400, Alexey Shumkin wrote:
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
