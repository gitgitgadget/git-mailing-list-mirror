X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commitdiff" views
Date: Wed, 8 Nov 2006 23:35:27 +0100
Message-ID: <200611082335.28296.jnareb@gmail.com>
References: <200611082311.35161.jnareb@gmail.com> <7vvelpr34d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 22:35:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BolJB12zz+mPgx2CfUIc92zMQAPGQaCTNeGHDWOlkqH/XU4QJvfk5EVZvT7aqgK1lKRiq+jisNjo5LaAi2zLvsngSmjtcmg1xUvS0pOydQ0esH3ietiQgUBi2PZSBrsQshqzmL5aTSVGnFoo2zlSuPfA1/SHWoM2KXjqiLvvY2A=
User-Agent: KMail/1.9.3
In-Reply-To: <7vvelpr34d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31165>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghw0K-0003xv-QC for gcvg-git@gmane.org; Wed, 08 Nov
 2006 23:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423815AbWKHWem (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 17:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423816AbWKHWel
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 17:34:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:10975 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423815AbWKHWek
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 17:34:40 -0500
Received: by ug-out-1314.google.com with SMTP id m3so47866ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 14:34:39 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr258961ugl.1163025279345; Wed, 08 Nov
 2006 14:34:39 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id p32sm7636618ugc.2006.11.08.14.34.38; Wed, 08 Nov
 2006 14:34:39 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Set $hash parameter to $hash_base || "HEAD" if it is not set (if it is
>> not true to be more exact). This allows [hand-edited] URLs with 'action'
>> "commit" or "commitdiff" but without 'hash' parameter.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> RFC because I want to ask if we should default to HEAD if hash is not
>> provided for commit and commitdiff views, or should we error out with
>> more reasonable error message.
> 
> Probably the latter; the user might be hand-crafting a URL
> (maybe learned a commit object name from mailing list and
> cutting and pasting) and mispasted the long hexadecimal string.
> Silently giving HEAD may leave the user confused than "oops, we
> do not see that commit object".
 
No, if there is 'h' (hash) parameter provided, then gitweb tries
to use this. HEAD is used _only_ if nether hash, nor hash_base
are provided, i.e. for URL like below

  URL?p=project.git;a=commit

i.e. without neither 'h' nor 'hb'.


But if it is (it being defaulting to HEAD, _like git_) wrong solution,
still it would be better to show 'commit not provided' error instead of
current 'bad commit' error.
-- 
Jakub Narebski
