X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 1 Dec 2006 08:34:21 +0000
Message-ID: <200612010834.22916.andyparkins@gmail.com>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301521320.9647@xanadu.home> <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:35:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tlCCnSYsBdNpByy9r1oMBXfE/IadCTHlz7JeQhMXGYH71nCzf7/npBbGxuhGcMnnlhAJCgaFkGtRFx2RpI6fOadk5TcXS6b6UjZAdddrzJ2eLQMgGdDzftGReSvFaU+m/xH+Y63wq85rhydeb1cOxGN4XuNor4grKcLx/XFeIpA=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32872>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3rF-0000HG-6W for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967549AbWLAIe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967551AbWLAIe3
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:34:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:2296 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967549AbWLAIe2
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 03:34:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2357889uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 00:34:27 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr5537247ugm.1164962066795; Fri, 01
 Dec 2006 00:34:26 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 13sm23712457ugb.2006.12.01.00.34.26; Fri, 01 Dec 2006 00:34:26 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 21:03, Linus Torvalds wrote:

> Yeah, I think it would probably make sense. I also think it would make
> sense to rename "update-index" entirely, or at least offer other names for

How about this:

git-update-index becomes plumbing only - never expect a user to run it.

Hence,

git-add becomes git-prepare and does
 a) update-index --add
    when the file being "prepared" is not tracked
 b) update-index
    when the file is already tracked

git-rm takes on "git-update-index --remove" (and --force-remove) with 
appropriate switches.

git-mv does what it does - it's already pretty perfect

git-cp gets added; even though it's simply "cp a b; git-prepare b"

Obviously with all the details that I've left out filled in.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
