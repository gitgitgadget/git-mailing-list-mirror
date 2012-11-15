From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 2/8] t7502: factor out autoident prerequisite
Date: Wed, 14 Nov 2012 23:49:55 -0800
Message-ID: <20121115074955.GB8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003340.GB17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuDH-0003Dh-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 08:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423572Ab2KOHuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 02:50:00 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59060 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab2KOHt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 02:49:59 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so557941dak.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 23:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lRKi91QwH9xrQpIVE5aKuCooyzoJCIJXLodkeCB7URs=;
        b=Om2tHyzOfjbbMD/pQy+J0k//bSDi4ZRBenIxK1vAxRaBFgT3H+RazMo/Q9cazvDgw1
         dLp4gNLJJfo6A14ym7GxMIXEdbc+lytjsf5M7DNjsRwATY3Ay0ay5AbaAtbQwvAN21x3
         vGKgNlVM+KiLZIM903YUl/lgrm/w80aVEOnbJ12sHwZ4yvny5TlC40fCW4ju65IPN8Cl
         NKIoRyLD9oJvGTU0L42fzEBOKCAY8Co3Q/P/NQP7KKplWDvN6ZU9zqU7AtgXKgiWoPml
         DD8aKYe8WK5CTXknkl97cViDbMGIIMIQQ+ydiJdl75ItpSDxHgBBDG3be0YOknvHhiDL
         Pkxg==
Received: by 10.66.87.163 with SMTP id az3mr795463pab.62.1352965799331;
        Wed, 14 Nov 2012 23:49:59 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id l5sm6831223paz.14.2012.11.14.23.49.58
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 23:49:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003340.GB17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209803>

Jeff King wrote:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -738,6 +738,12 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>  	esac
>  '
>  
> +test_lazy_prereq AUTOIDENT '
> +	sane_unset GIT_AUTHOR_NAME &&
> +	sane_unset GIT_AUTHOR_EMAIL &&
> +	git var GIT_AUTHOR_IDENT
> +'

Lazy prereq scripts run in a subshell, so this should be safe.  Ack.

Thanks,
Jonathan
