X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Wed, 06 Dec 2006 19:14:18 +0800
Message-ID: <4576A60A.3060003@gmail.com>
References: <4576680B.7030500@gmail.com>	 <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>	 <45769417.70601@gmail.com> <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 11:16:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IVFzpp2OaIudpDg8fF/6MA5Od4DboTl/EadgqaFcZaED6oQXVoj1kUVzGeDf6RjinSucTfQuaSIlY7DEppDmMsT5JNv9bPis5lFKifAWVyEOYQyw7qAo9gg496DDxkg7FydNBev6JKyJI2GYqvFK1fLm+m3PlvNA3D65KhkO8cw=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33434>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grul6-0000O6-6i for gcvg-git@gmane.org; Wed, 06 Dec
 2006 12:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760494AbWLFLPk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 06:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760501AbWLFLPk
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 06:15:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:11512 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760494AbWLFLPj (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 06:15:39 -0500
Received: by wx-out-0506.google.com with SMTP id h27so180688wxd for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 03:15:39 -0800 (PST)
Received: by 10.90.93.6 with SMTP id q6mr569986agb.1165403739149; Wed, 06 Dec
 2006 03:15:39 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 7sm10497921aga.2006.12.06.03.15.36; Wed, 06 Dec 2006 03:15:38 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen wrote:
> On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
>> Alex Riesen wrote:
>> > On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
>> >> I'm confused how to revert changes in working tree:
>> >>
>> >> $ git fetch
>> >> $ git merge "sync with origin" HEAD origin
>> >> ....conflict....
>> >
>> > You may want to consider git pull. It'd do exactly the same
>>
>> It's said somewhere "git pull" has strange behaviour and fetch+pull
>> is recommended.
> 
> So why do you use fetch+merge?
> 

Oh, another mistake, I have heard fetch+merge is recommended.

> so, you just have an unresolved merge.
> It was discussed on this mailing list very recently
> (and actually is being discussed), so just look at
> the archives.
> 

Thanks, I will dig it.

>> > They problem is the exec-bit which windows does not
>> > have and cygwin failed to correctly workaround the
>> > limitation.
>> >
>> > Do a "git repo-config core.filemode false" to almost
>> > disable the checks for exec bit.
>> >
>>
>> It has been set. I guess the cause is a interrupted merge
>> operation that leads to textual difference.
> 
> yes, though what I can't understand is why don't you have
> unmerged entries... Maybe it comes from playing with
> all these commands you mentioned in the original mail.
> 
>> After run "git reset --hard", all deleted files come back, but I reach
>> the old state:
>> $ git status
> 
> When? Immediately after git reset --hard? Then you very
> likely have no permission to write (or lost it somehow) into
> the working directory, otherwise I don't see could this be
> possible. git reset --hard rewrites everything.
> 
Yes, immediately after git reset --hard. I'm sure I have write
permission because all deleted files come back and no "permission
denied" like message appears.

I will try to run git in debugger, wish I can get the reason.

>> HEAD: commit 088406bcf66d6c7fd8a5c04c00aa410ae9077403
>> master: commit 088406bcf66d6c7fd8a5c04c00aa410ae9077403
>> origin: commit ff51a98799931256b555446b2f5675db08de6229
>> "git diff --cached" shows nothing;
> 
> which is correct.
> 
>> "git diff" shows many diffs:
> 
> and this is not. You do have changes, which could not be reset.
> I fail to see why. Are you sure you haven't accidentally repeated
> the merge after doing git reset --hard? And what was _exactly_
> git merge told you, when it failed?
> 
I didn't run "git merge" after "git reset --hard" indeed. To get the message
from "git merge", now I run it like this:

$ git merge "sync from origin" HEAD origin
Updating 088406b..ff51a98
include/linux/netfilter/xt_CONNMARK.h: needs update
include/linux/netfilter/xt_DSCP.h: needs update
include/linux/netfilter/xt_MARK.h: needs update
include/linux/netfilter_ipv4/ipt_CONNMARK.h: needs update
include/linux/netfilter_ipv4/ipt_DSCP.h: needs update
include/linux/netfilter_ipv4/ipt_ECN.h: needs update
include/linux/netfilter_ipv4/ipt_MARK.h: needs update
include/linux/netfilter_ipv4/ipt_TCPMSS.h: needs update
include/linux/netfilter_ipv4/ipt_TOS.h: needs update
include/linux/netfilter_ipv4/ipt_TTL.h: needs update
include/linux/netfilter_ipv6/ip6t_HL.h: needs update
include/linux/netfilter_ipv6/ip6t_MARK.h: needs update
net/ipv4/netfilter/ipt_ECN.c: needs update
net/ipv4/netfilter/ipt_TOS.c: needs update
net/ipv4/netfilter/ipt_TTL.c: needs update
net/ipv6/netfilter/ip6t_HL.c: needs update
net/netfilter/xt_CONNMARK.c: needs update
net/netfilter/xt_DSCP.c: needs update
net/netfilter/xt_MARK.c: needs update
fatal: Entry 'net/ipv4/netfilter/ipt_ECN.c' not uptodate. Cannot merge.

