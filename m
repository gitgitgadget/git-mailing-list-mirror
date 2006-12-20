X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit hooks
Date: Wed, 20 Dec 2006 14:40:40 +0000
Message-ID: <200612201440.41784.andyparkins@gmail.com>
References: <200612201309.02119.andyparkins@gmail.com> <200612201347.13805.andyparkins@gmail.com> <458949C4.1020207@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:41:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DCNVembD1Jetxy4AcdMoFbo2lQo5nBnFKc6sIOEuHWVyfLb/a0RL3BnYrqD2hREFnRjH9Ot8YA2Rk6Xd0+rDgRjL7QV6youX1te2nJLRwOwY1xu2IPIYskVrNMcYgRvsCmUNgEosOkMW3fPnccwvG8+hh+G2aVVwhE3ImNI1mvk=
User-Agent: KMail/1.9.5
In-Reply-To: <458949C4.1020207@dawes.za.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34935>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2ck-00055A-Eo for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965111AbWLTOkr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWLTOkr
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:40:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:15818 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965111AbWLTOkq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 09:40:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2248147uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 06:40:45 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr10685493ugh.1166625644889; Wed, 20
 Dec 2006 06:40:44 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id o24sm12827995ugd.2006.12.20.06.40.44; Wed, 20 Dec 2006 06:40:44
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 20 14:33, Rogan Dawes wrote:

> It wouldn't, since the redirection overwrites the file at the same time

Of course you are correct; however it wasn't completely crazy.  Before now, 
I've replaced files in C by doing

 fd_old = open( "someexistingfile" );
 unlink( "someexistingfile" );
 fd_new = open( "someexistingfile" );

So I was really just trying it in case bash did a similar thing internally.

> as trying to read from it. A better way is to redirect to a temp file,
> and rename it if the previous operation was successful.

That's what I ended up doing; as you say it's better anyway because the error 
conditions don't mean that the .gitmodules file ends up half written.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
