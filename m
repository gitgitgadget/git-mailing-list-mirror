X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sun, 26 Nov 2006 00:34:23 +0100
Message-ID: <200611260034.23974.jnareb@gmail.com>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org> <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 23:32:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ri2FBCW169J9ClChEKmk/iZP5SQyDIgw1eMPA4fvmIH9HpkWXpmRXhyS5StIkpYh0zp7xk6SinSnB7wlF9WoDxTyOwDZNXA4r5RllGq2AIY11u7ykttmpOnRG3I781ey7OcPZJb7T76HekPlVbOq3jov2u1SwbEXYoYYcuoQw+s=
User-Agent: KMail/1.9.3
In-Reply-To: <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32308>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go70y-0005b4-4P for gcvg-git@gmane.org; Sun, 26 Nov
 2006 00:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935211AbWKYXcm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 18:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935212AbWKYXcm
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 18:32:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:60209 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935211AbWKYXcl
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 18:32:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so891241uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 15:32:40 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr9594686ugj.1164497560403; Sat, 25
 Nov 2006 15:32:40 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id o24sm12948736ugd.2006.11.25.15.32.39; Sat, 25 Nov
 2006 15:32:39 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>
>>> Now separate-remote layout is the default for newly cloned
>>> repositories, I think it is a good time to make further effort
>>> to make things easier to use.  Here are some of the ideas off
>>> the top of my head.
>> [...]
>>> * Change the default contents of $GIT_DIR/remotes/origin
>>
>> The question is: do we continue to use remotes/ file, or do we
>> save remotes info in the config file: remote.<name>.url,
>> remote.<name>.fetch, remote.<name>.push and branch.<name>.merge
>> (in our case '[remote "origin"]' section)?
> 
> It is not "the question"; it is irrelevant because
> $GIT_DIR/remotes/origin and [remote "origin"] are pretty much
> interchangeable, and will hopefully continue to be.
> 
>         [remote "origin"]
>                 url = master.kernel.org:/pub/scm/git/git.git/
>                 fetch = +refs/heads/master:refs/remotes/origin/master
>                 fetch = +refs/heads/*:refs/remotes/origin/*
> 
> would be the way to express the equilvalent of the example in
> the previous message.

Well, the question is if git-clone would generate appropriate config 
entries in addition to or instead of $GIT_DIR/remotes/origin file...

By the way, what do you think about extended refspec syntax, namely
in addition to <remote name>:<local name> it would allow to say
<remote name>:<local name>:<local branch to merge into>?
-- 
Jakub Narebski
