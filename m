X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 1 Dec 2006 10:59:00 +0000
Message-ID: <200612011059.01659.andyparkins@gmail.com>
References: <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com> <200611301501.43436.andyparkins@gmail.com> <ekn0ne$nuk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 10:59:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rttg1wMZFuaaTmamysSnJdBzzUhxflhMCl+OKa1JMJLUUJD5R/TlOCFYmCOtAFzqbdkSlFD58xzdPoNJZ1o6qgKbvTqzcghzRRvBnKE3Mj1EKIogm+xQWyfEyMKHslOwSt8tUqgSBGgdkLpqycRyB8GFFaWo2T04bLyeedq+05M=
User-Agent: KMail/1.9.5
In-Reply-To: <ekn0ne$nuk$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32890>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq671-00019n-Ji for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030712AbWLAK7L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030715AbWLAK7L
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:59:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54693 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030712AbWLAK7G
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:59:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2387390uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 02:59:05 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr7058229ugh.1164970745341; Fri, 01
 Dec 2006 02:59:05 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id l40sm23801402ugc.2006.12.01.02.59.04; Fri, 01 Dec 2006 02:59:04
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 16:28, Jakub Narebski wrote:

> Insount on #git pointed out fragility of this solution with respect
> to adding/removing/moving files, which dirties index (which might not be
> understood by newbie user: "git commit" used to work, but doesn't work the
> same when I added some files).

It does, provided they only added files and didn't change anything else.  If 
they did then we're out of it for this patch anyway.

Anyway, this is only meant to help ease people into the index.  As discussed 
elsewhere, hiding the index is a silly policy.

This patch isn't /just/ for the newbies by the way (who are already confused, 
so that hasn't changed), I know about the index, but I still like it.  
Remember, all it's really saying is "when commit would do nothing, do 
something".  So it only takes away an option that you can't have been using 
anyway because it didn't do anything.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
