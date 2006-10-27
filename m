X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Fri, 27 Oct 2006 09:19:51 +0100
Message-ID: <200610270920.06064.andyparkins@gmail.com>
References: <200610261138.24761.andyparkins@gmail.com> <4540F16F.4060604@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 08:20:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cYNjZRmaf63wMd9IPB/W1WoHfFxfShrZGqMMQi9eP9RqTAFBnkpBsvIb8SWtK5NDENkznFA07tN5lnrz3J0IHTNeRGmbIxO/gYbI3KzVn/amPM1RbuJaY4i6aHNYpJSVPP32AeTwga4NDL4RxKm4fbjavdl4z2tWaOo6SQ2Cd6o=
User-Agent: KMail/1.9.5
In-Reply-To: <4540F16F.4060604@shadowen.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30308>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMwr-0001cP-B5 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946245AbWJ0IUN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946246AbWJ0IUN
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:20:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34107 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946245AbWJ0IUL
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:20:11 -0400
Received: by ug-out-1314.google.com with SMTP id 32so621423ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 01:20:10 -0700 (PDT)
Received: by 10.66.221.6 with SMTP id t6mr4517434ugg; Fri, 27 Oct 2006
 01:20:09 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id a1sm224496ugf.2006.10.27.01.20.09; Fri, 27 Oct 2006 01:20:09 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 October 26 18:33, Andy Whitcroft wrote:

> If we are changing the format would it not make more sense to be in the
> same order as the tool that lets you use it?
>
> I thought that was git cat-file <type> <commit-ish>

The only problem with that is that the type string is of variable width, while 
the hash is fixed; hence <hash> <type> is more visually appealing than <type> 
<hash>.

Does it really matter anyway?  Some sort of processing would have to happen 
before using git-prune output as git-cat-file parameters...

git-prune -n |
while read hash type
do
 git-cat-file $type $hash
done



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
