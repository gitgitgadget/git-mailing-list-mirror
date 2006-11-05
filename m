X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Documentation: Two more git-rebase --onto examples
Date: Sun, 5 Nov 2006 11:22:17 +0100
Message-ID: <200611051122.17623.jnareb@gmail.com>
References: <200611042205.58212.jnareb@gmail.com> <7vbqnmwvib.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 5 Nov 2006 10:21:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TnfIPUpvumYIUTK39k3FJH4lGaeu9V7oAMn6E1PJLJ/2EfBw98Z3qsLLTrP8tnNSjdkvHf4ppYzwXrU/meHKtrIEdZLKfg6DPlqguXCdP/JakJSuGJdgTbnPsAdPVdX5OGBSYEbQSxjaBxCts1qaaQ0gy9jPZqidbdoHn01tzMA=
User-Agent: KMail/1.9.3
In-Reply-To: <7vbqnmwvib.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30963>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggf8V-0003eP-1T for gcvg-git@gmane.org; Sun, 05 Nov
 2006 11:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932627AbWKEKVv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 05:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWKEKVv
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 05:21:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:22228 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932627AbWKEKVu
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 05:21:50 -0500
Received: by ug-out-1314.google.com with SMTP id m3so680579ugc for
 <git@vger.kernel.org>; Sun, 05 Nov 2006 02:21:49 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr5470812ugi.1162722109031; Sun, 05
 Nov 2006 02:21:49 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id u6sm3419815uge.2006.11.05.02.21.48; Sun, 05 Nov
 2006 02:21:48 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Thanks for comments.

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> +More useful example of --onto option usage include transplanting feature
>> +branch from one development branch to other, for example change to branch
>> +based off "next" branch:
> 
> By "more" do you mean the following examples are more useful
> than the one before, or having larger number of examples adds to
> the usefulness of the document overall?

I found original example somewhat artifical, but after thinking on that
I guess that the need for rebase onto master~1 might happen when the last
commit in master is for example to be amended or rebased. 

The "transplanting branch" example feels like more natural to me.

> How about:
> 
>         Here is how you would transplant a topic branch based on one
>         branch to another, to pretend that you forked the topic branch
>         from the latter branch, using `rebase --onto`.

Perhaps adding why one might want to transplant topic branch from one
development branch to other: for example when feature being developed
on topic branch relied on functionality which was at the time topic branch
was started available only in 'next' branch, but meanwhile it matured and
was merged into 'master' (more stable) branch. One would want to base
topic branches on 'master' branch if possible.

[...]
> This looks the same as the original example for --onto; I would
> either drop it or replace it something of different flavor.

This example is from latest post by Andy Parkins, which asked how to
do that. But I find your example as being better, because it shows
even more power of core git history manipulation.

> What I find myself doing more is to reorder without using StGIT.
> When I have this:
> 
> 	1---2---3---4 topic
> 
> and 2 is a bit half-baked, and I would want to have:
> 
> 	1---3'--4'--2' topic
[...]

Here I find lack of --interactive option to at least git-am based
rebase; git-rebase could simply pass --interactive option to git-am.

-- 
Jakub Narebski
