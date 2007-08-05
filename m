X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: $GIT_DIR usage
Date: Sun, 5 Aug 2007 04:55:55 -0700
Message-ID: <678E8953ECEB4B72A99DEA2137B05823@ntdev.corp.microsoft.com>
References: <46B59F63.8020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 5 Aug 2007 11:56:14 +0000 (UTC)
Cc: <git@vger.kernel.org>
To: "Dan Zwell" <dzwell@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=MbnwX2UM8OquPQD/PCehZowZHmVEmPeocFDKVd++aNeoS0JzaJMioRTSXIKsQKOEllWmhAedfXA8LByB5cEFWC+3Fskw8KfQZMeyNsC5/d5N/ArbFscmElyKprcPIdAUwj0ZNvO108fD2gCcO8I8+Q/9i3KkrGdepsYWN1l6Hxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=NKaC1kiHv1rkzfEFoU2B0/lizSUjy7gGHTkcn2Z9SfYskecWlggzkrFee3yL7LHszMdohAPWp/oFfQJgHo9WT5rtZCT5M/oxIWGJs8EtmC15bNtmDzAftPP+CL533D0bLW+CK5QO8K8yFquf/WTSsfGIS+xf4EmJKjjYY3ZMlF8=
In-Reply-To: <46B59F63.8020707@gmail.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1IHeiP-0007oC-02 for gcvg-git@gmane.org; Sun, 05 Aug 2007
 13:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755480AbXHEL4E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Aug 2007
 07:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbXHEL4D
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:56:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:20795 "EHLO
 wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1754235AbXHEL4A (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Aug
 2007 07:56:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1448020wah for
 <git@vger.kernel.org>; Sun, 05 Aug 2007 04:56:00 -0700 (PDT)
Received: by 10.114.53.1 with SMTP id b1mr4643911waa.1186314959494; Sun, 05
 Aug 2007 04:55:59 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227]) by mx.google.com with ESMTPS id
 l27sm5295632waf.2007.08.05.04.55.57 (version=SSLv3 cipher=OTHER); Sun, 05 Aug
 2007 04:55:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org

I think you also need to set GIT_WORK_TREE.
This way Git will know the root of directories that it controls.

- Dmitry
----- Original Message ----- 
From: "Dan Zwell" <dzwell@gmail.com>
Newsgroups: gmane.comp.version-control.git
To: <git@vger.kernel.org>
Sent: Sunday, 5 August 2007 2:58
Subject: $GIT_DIR usage


> Hi, I had a question about $GIT_DIR. That is to say, it doesn't seem to 
> work. I am using Git 1.5.2.4. See the following: (all the commands I 
> tried besides "git-init" failed).
> 
> $ export GIT_DIR="`pwd`/.git_public"
> $ git init
> warning: templates not found /usr/share//git-core/templates/
> Initialized empty Git repository in /home/user/temp/.git_public/
> $ echo > new_file
> $ git add new_file
> fatal: add must be run in a work tree
> $ git commit -a
> fatal: /usr/bin/git-commit cannot be used without a working tree.
> $ git commit
> fatal: /usr/bin/git-commit cannot be used without a working tree.
> $
> 
> Is $GIT_DIR not meant to be used this way? Does it have a different 
> purpose / use case, or is this just a bug?
> 
> Thanks,
