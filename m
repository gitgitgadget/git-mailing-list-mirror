X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 15:38:39 +0000
Message-ID: <200612121538.41197.andyparkins@gmail.com>
References: <200612121235.09984.andyparkins@gmail.com> <200612121326.24508.andyparkins@gmail.com> <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 15:39:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fGgF/7u8V5wz9otAScbjyG5Dc0FinMsGvCcF3M9DaUix78oyIxfhg+WFFqjOnkeXwyYji2DlW1z+vDkPAS+eG575XlpC+57W6dXTr8A6d+6A1mSb76Pu+Xq89aN3H28PBHzpAPCiVnOhjwLb4s9Pru7ncOzf39spujU0CwVjBx0=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34102>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu9ih-0003uH-CM for gcvg-git@gmane.org; Tue, 12 Dec
 2006 16:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751435AbWLLPir (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWLLPir
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 10:38:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:42976 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751435AbWLLPiq (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 10:38:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1698872uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 07:38:45 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr11915057ugh.1165937924678; Tue,
 12 Dec 2006 07:38:44 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e1sm8906339ugf.2006.12.12.07.38.43; Tue, 12 Dec 2006 07:38:44 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 14:28, Johannes Schindelin wrote:

> You are not by any chance talking about the --remote option to
> git-archive?

I wasn't; but that's certainly a helpful switch.  It's certainly a huge help.

> If you want to reduce the number of objects to be downloaded, by telling
> the other side what you have, you literally end up with something like
> shallow clone: the other side _has_ to support it.

I suppose so; but I was thinking more an automated way of getting the data 
that is supplied for the kernel anyway.  So:

base-v1.0.0.tar.gz
patch-v1.0.1.gz
patch-v1.0.2.gz
etc

Each patch is obviously smaller than "base".  Git could easily make the 
patches, and each of those patches could be fed by hand into a repository 
with git-apply.  It doesn't seem like something that would require support on 
the other side, because it isn't so much a shallow clone (which /would/ 
preserve history, making it available if wanted); it is pulling just, say, 
tagged commits out of an existing repository.

Given a list of tags it is almost:

git-archive <get me base>
ssh remote git-diff v1.0.0..v1.0.1 | git-apply; git commit
ssh remote git-diff v1.0.1..v1.0.2 | git-apply; git commit

If that makes sense?  Obviously though it would be possible to use git rather 
than ssh to do this.

However... please don't waste any more time thinking about this; it's not a 
problem I have that needs a solution - it was more a "because I'm curious" 
sort of question.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
