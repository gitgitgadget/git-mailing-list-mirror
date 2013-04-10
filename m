Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 9214 invoked by uid 107); 10 Apr 2013 23:13:50 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Wed, 10 Apr 2013 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936176Ab3DJXLj (ORCPT <rfc822;peff@peff.net>);
	Wed, 10 Apr 2013 19:11:39 -0400
Received: from plane.gmane.org ([80.91.229.3]:37623 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936111Ab3DJXLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 19:11:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UQ4Az-0005YL-7q
	for git@vger.kernel.org; Thu, 11 Apr 2013 01:11:37 +0200
Received: from ip68-227-87-145.sb.sd.cox.net ([68.227.87.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 01:11:37 +0200
Received: from richard_hubbe11 by ip68-227-87-145.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 01:11:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date:	Wed, 10 Apr 2013 16:13:20 -0700
Organization: " "
Message-ID: <20130410161320.679b68ca07cd1fe32bb25c70@lavabit.com>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-227-87-145.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: encrypt
X-Operating-System: Barebones_6.1
X-Gmane-NNTP-Posting-Host: 192.168.1.1
X-NNTP-Posting-Host: 192.168.1.1
Mail-Copies-To:	never
X-Archive: expiry=17
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A

On Mon,  8 Apr 2013 09:40:04 -0500
Felipe Contreras <felipe.contreras@gmail.com> wrote:

> If a push fails because the remote-helper died (with fast-export), the
> user won't see any error message. So let's add one.
> 
> At the same time lets add tests to ensure this error is reported, and
> while we are at it, check the error from fast-import
> 

....

> +++ b/transport-helper.c
> @@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf
> *buffer) if (strbuf_getline(buffer, helper, '\n') == EOF) {
>  		if (debug)
>  			fprintf(stderr, "Debug: Remote helper quit.
> \n");
> -		exit(128);
> +		die("Reading from remote helper failed");

Do I read this correctly?  If I'm in debug mode the remote helper quit
but if not in debug mode it failed?  Debuggers never fail they only quit!


>  	}
>  
>  	if (debug)

