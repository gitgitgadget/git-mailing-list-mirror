X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: SEGV when lookup_* returns NULL
Date: Mon, 27 Nov 2006 21:23:47 -0500
Message-ID: <118833cc0611271823t3b1783cem38f031ac26ac0f94@mail.gmail.com>
References: <20061127211315.GC18810@admingilde.org>
	 <7vu00kftbq.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0611280032300.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v3b84e8cg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 02:24:04 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Martin Waitz" <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ju+RgZISu+aSVt9QBV2bNC3tr8b8akYV0GPOcQwwYsGaeNJtMW/Jj/6PLxTbiYiCBAZszFYGTmhAwLt27IIIq2Ynk7YKrsGKLEQoZkQGFR2QS078O2m0jsOdSCDrSWEHGWPuXYD4PsEBreN1QXPo0FD9Cyx/VVZQ5OAS+4KOQDA=
In-Reply-To: <7v3b84e8cg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32481>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GosdT-0001Kt-MO for gcvg-git@gmane.org; Tue, 28 Nov
 2006 03:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934488AbWK1CXt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 21:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934494AbWK1CXs
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 21:23:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:3609 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S934488AbWK1CXs
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 21:23:48 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1861484wxd for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 18:23:47 -0800 (PST)
Received: by 10.70.84.6 with SMTP id h6mr548447wxb.1164680627508; Mon, 27 Nov
 2006 18:23:47 -0800 (PST)
Received: by 10.70.99.4 with HTTP; Mon, 27 Nov 2006 18:23:47 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> Why?  You would certainly install your own die() handler by that
> time I presume?

Likely, but short of exiting or using longjmp/setjmp what can you do
in such a "die"?  Not much.  And most GUI users will be unhappy
with the exit approach.

If there is any chance that the error is not the programmer's fault, a
nice library ought to pass the error back somehow.

