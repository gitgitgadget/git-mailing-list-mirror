X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 23:16:27 +0100
Message-ID: <200611282316.27580.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200611281943.40354.jnareb@gmail.com> <456CB13D.6090407@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 22:15:03 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lVgl8MfGkvLNw0py48UywiGncBc8N1dq6Ox+Epwyrc4oqyXCPTckMvv2cNCG3fmYZnE8Ke8QaLcxLiWxjpaL6VR05nslo7FLyduV67e03pBuvZjHNaNAD/G/XSObvSmDfGuNVfgnLTOWTrTJDcg1qbEIszDk9V2si86lpcmMnng=
User-Agent: KMail/1.9.3
In-Reply-To: <456CB13D.6090407@utoronto.ca>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32594>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBDv-0005Ce-OM for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757545AbWK1WOl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbWK1WOl
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:14:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:18935 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1757545AbWK1WOk
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:14:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1613650uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 14:14:39 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr2437015ugh.1164752078732; Tue, 28
 Nov 2006 14:14:38 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id o1sm19942678uge.2006.11.28.14.14.38; Tue, 28 Nov
 2006 14:14:38 -0800 (PST)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Sender: git-owner@vger.kernel.org

Aaron Bentley wrote:
> Jakub Narebski wrote:
>> Well, I gues that with "annotate friendly" (weave or knit) storage
>> annotate/blame would be faster. But fast annotate was not one of the
>> design goals of git.
>>
>> How fast is "bzr annotate"?
> 
> $ time bzr annotate builtins.py > /dev/null
> 
> real    0m1.479s
> user    0m1.430s
> sys     0m0.030s
> 
> builtins.py has 953 ancestor revisions (i.e. revisions that modified
> it) and 3016 lines.
> 
> That's on a machine with 4141.87 Bogomips.  I did optimize annotate
> slightly, but I'm submitting the optimization for our 0.14.0 release.

Hmmm... git-blame (without contents moving or rename detection) takes 
around 2s user+sys on 2002 BogoMIPS machine, as compared to 1.5s 
user+sys for bzr annotate on 4141.87 BogoMIPS machine.

revision.c has 1208 lines, 62 unique commits in git-blame output, 90 
commits history, 102 commits full history.
-- 
Jakub Narebski
