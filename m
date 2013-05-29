From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [RFC/PATCH v2 4/8] rebase: cherry-pick: fix abort of cherry mode
Date: Wed, 29 May 2013 13:13:59 +0200
Message-ID: <51A5E2F7.4090505@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com> <1369801000-3705-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:14:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheKX-0001tm-W9
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965654Ab3E2LOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:14:05 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48694 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965579Ab3E2LOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:14:04 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so5186546eek.19
        for <git@vger.kernel.org>; Wed, 29 May 2013 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GtsnT2DJrlqTPd2sZBDeP7B94Pi56fuRCwfnNgKDpxc=;
        b=H/Io4tdc3t2LtVnsC5tFKCBi7F3CZPVUglUodtJuvlNei4h8mdDXgNI3U8YU3EFiY5
         fs+y1fFc6Dj5BodlyBWE2BsGkz4mwr9nlxq4/s/8InJzMWXyOv92WNz0R3DXapNOjXBp
         PAASv1iR8ZCpP+W6u9xUyGwWtao+EyhbAbxBF9jq6L7U6z326n+cdqDZB070X+4q6rzi
         4tCnJUb0Zl9c148KinA4BSfgQIxExFlLe1PvQ7KltW2wyWMIea9xMWF2ESbvfYFFn0so
         I7+LCb1EIeld1F+SgeFUCraQyfthMCLz3Xy6ojC2T2+FFto1fB5gIBCS9HogE8TSg2tP
         uMjA==
X-Received: by 10.14.194.73 with SMTP id l49mr2314759een.99.1369826042499;
        Wed, 29 May 2013 04:14:02 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id t6sm17160348eev.14.2013.05.29.04.14.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 04:14:01 -0700 (PDT)
In-Reply-To: <1369801000-3705-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225787>

On 05/29/2013 06:16 AM, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 76900a0..9b5d78b 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -335,6 +335,7 @@ skip)
>  	run_specific_rebase
>  	;;
>  abort)
> +	test "$type" == "cherrypick" && git cherry-pick --abort
>
Bashism; please use "=", not "==".

>  	git rerere clear
>  	read_basic_state
>  	case "$head_name" in

Regards,
  Stefano
