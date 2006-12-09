X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Easy shell question: how to make a script killing all his childs when killed?
Date: Sat, 9 Dec 2006 18:51:57 +0100
Message-ID: <e5bfff550612090951l43a83a00o7ea2e244ca562c77@mail.gmail.com>
References: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com>
	 <20061209173703.GA12373@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 17:52:19 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L3iZYbcaZkqzDw7CgKPnzDs9eQntoLC87d+15pEn5CwhyO0H0IlSV6AytASvtl46yRY0q/aAgJ3zN8mJDag7fAKVuwTEPAQMBdBmEN4t+zEg1uNELCBDd04jsolaJzFP2Q1d48J0yB3++hEXWnDTRgUH9esawz1h+j5iSRuJfbw=
In-Reply-To: <20061209173703.GA12373@steel.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33824>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt6Mw-0000TD-Nm for gcvg-git@gmane.org; Sat, 09 Dec
 2006 18:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759133AbWLIRwA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759140AbWLIRwA
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 12:52:00 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:42566 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759131AbWLIRv7 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 12:51:59 -0500
Received: by py-out-1112.google.com with SMTP id a29so608328pyi for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 09:51:58 -0800 (PST)
Received: by 10.35.82.16 with SMTP id j16mr5536380pyl.1165686717800; Sat, 09
 Dec 2006 09:51:57 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sat, 9 Dec 2006 09:51:57 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/9/06, Alex Riesen <fork0@t-online.de> wrote:
> Marco Costalba, Sat, Dec 09, 2006 16:16:32 +0100:
>
> > P.S: I have no way to exec the script in fancy ways, I can just start
> > it and get is PID.
>
> Which is "fancy" enough. What do you mean "start"? Starting a new
> process usually and notably involves forking and execing (even if the
> first thing to exec will be your shell).
>
>

By 'start' I mean it is done inside Qt QProcess class back box ;-)

Anyway I have written an homegrown 'wanna be hacker' launching script:

git rev-list --header --boundary --parents --topo-order HEAD >
/tmp/qgit_136224752.txt &
echo $!
wait


With this I can get the pid of git-rev-list from my QProcess interface
so to be able to kill it when needed with another command ('kill'
BTW).

I have googled around and it seems that 'echo $!' and 'wait' _should_
be portable among many shell, please correct me if'm wrong or if the
approach is failing (I already know it's ugly ;-)  )

