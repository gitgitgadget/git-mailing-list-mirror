X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 1 Dec 2006 14:07:38 +0100
Message-ID: <81b0412b0612010507r5e6ee226t3a1e61113bf15d43@mail.gmail.com>
References: <200611301259.32387.andyparkins@gmail.com>
	 <81b0412b0611300914u521a5351idde23618c2fbf017@mail.gmail.com>
	 <200612011052.48784.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 13:08:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qWxpcCrwMEjv3t1D70l2EVuHP9rcJNq/khLr7xGmDYgH0W2wKQmAgIbNyim8gcA8/2/35nclC1bQ1fWtcFXQqYhZNPTwDNpszONMos7hxEIJl84JDpGtEHEjDlYVS+DmzjGIMgtp/9JFDQaux82BrBfOEDnE+ZZSeh/89UjjEug=
In-Reply-To: <200612011052.48784.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32918>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq87H-000083-Mz for gcvg-git@gmane.org; Fri, 01 Dec
 2006 14:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936490AbWLANHp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 08:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936491AbWLANHp
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 08:07:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:44577 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936490AbWLANHo
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 08:07:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2416809uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 05:07:43 -0800 (PST)
Received: by 10.78.185.16 with SMTP id i16mr4769238huf.1164978458607; Fri, 01
 Dec 2006 05:07:38 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 1 Dec 2006 05:07:38 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/1/06, Andy Parkins <andyparkins@gmail.com> wrote:
>
> > The is dangerous on filesystems which lie to the programs about file
> > metadata. The "virtual filesystem" of cygwin is one of this kind: exec-bit
> > of the files depend
> > on its contents. Just calling git-commit -a will commit executability
> > at this particular
> > moment. For whatever reason, disabling handling of the exec-mode in gits
> > config does not work.
>
> Surely this is a separate fault?
>

Of course it is. It's just that the problem is not solved yet,
and if -a becomes git-commit's default a simple git-commit
will be a real annoying thing.

> > If you about to change the behavior, provide at least a config option
> > to go back
> > to the old git-commit, which didn't do any magic.
>
> Wasn't the whole point of this to avoid needing another config option?
>

