X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH/RFC] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 1 Dec 2006 15:17:59 +0000
Message-ID: <200612011518.00575.andyparkins@gmail.com>
References: <200611301259.32387.andyparkins@gmail.com> <200612011052.48784.andyparkins@gmail.com> <81b0412b0612010507r5e6ee226t3a1e61113bf15d43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 15:18:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=chb3tzWZgUntdpodKVtfj3u7kmN5wvHLDj6dkykPdGNCdClA6QmMnY4ZQbqhJW8jQk7LC1Wyz4aOIBXTJLjjoWx9UZPB/sRCfLk/yp8Ne22v60Mfe6huz7PwOz7wlkZf/vRp/FtYbc5edH5LStfCa1vr/eTPZ55xejQ/lCkLHGA=
User-Agent: KMail/1.9.5
In-Reply-To: <81b0412b0612010507r5e6ee226t3a1e61113bf15d43@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32936>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqA9V-0008QU-Oq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936383AbWLAPSK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936452AbWLAPSJ
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:18:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:4567 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936383AbWLAPSI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:18:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2448296uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 07:18:07 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr7444830ugh.1164986284784; Fri, 01
 Dec 2006 07:18:04 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id b35sm21857252ugd.2006.12.01.07.18.03; Fri, 01 Dec 2006 07:18:03
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 13:07, Alex Riesen wrote:

> Of course it is. It's just that the problem is not solved yet,
> and if -a becomes git-commit's default a simple git-commit
> will be a real annoying thing.

There was talk of making git-commit -a; bear in mind that this patch was to 
completely sidestep making that default.  This patch has no effect on 
existing behaviour save for one special case: when commit would otherwise 
have done nothing, it now does "git-commit -a".

If you have a problem with git-commit -a, then presumably you are already 
using git-update-index for all your commit needs; in which case this patch 
has zero impact on you.

> > Wasn't the whole point of this to avoid needing another config option?
>
> was it it the point of breaking existing setups?

Of course it isn't; I have no intention of breaking yours or anybody else's 
setup.  However, as your complaint is that this patch highlights another bug, 
I would think the solution is fix the other bug, instead of botch around it 
in this patch.

Perhaps I was a little terse; what I should have said was - I don't really 
want to solve this executable bit problem with a config option; as that's 
papering over the cracks.  If executable bits are a problem, well why not 
detect when that's the case automatically.  I don't have a cygwin environment 
so I have no way to test what you ask for.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
