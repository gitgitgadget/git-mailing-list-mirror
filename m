X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Wed, 06 Dec 2006 17:57:43 +0800
Message-ID: <45769417.70601@gmail.com>
References: <4576680B.7030500@gmail.com> <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 09:59:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XfNMgaqtOMUds8J4n/+rMrWsvsjWs+IiRodiYmMdeX9AVRFLYPyPKCIFpGReR1Xs1Y15tv1hpt4fLg5u3Th38esbahqje9TmjQ5CPvMCoZDoz1WI/isowZfQso4KifIIDxM2i6NVAukGHVUXf+UEtHr5gc8X06I5UrZUuPcDitE=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33415>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtYV-0007fd-NM for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760407AbWLFJ7I (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760404AbWLFJ7I
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:59:08 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:43136 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760407AbWLFJ7H (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 04:59:07 -0500
Received: by wx-out-0506.google.com with SMTP id h27so163103wxd for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 01:59:06 -0800 (PST)
Received: by 10.70.39.2 with SMTP id m2mr1050936wxm.1165399146471; Wed, 06
 Dec 2006 01:59:06 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 38sm22598785wrl.2006.12.06.01.59.03; Wed, 06 Dec 2006 01:59:06 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen wrote:
> On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
>> I'm confused how to revert changes in working tree:
>>
>> $ git fetch
>> $ git merge "sync with origin" HEAD origin
>> ....conflict....
> 
> You may want to consider git pull. It'd do exactly the same

It's said somewhere "git pull" has strange behaviour and fetch+pull
is recommended.

> 
>> $ git branch
>> * master
>>   origin
>>
>> $ git status
>> # .....: needs update
>> # .....: needs update

sorry, I made a mistake, that should come from "git merge",
here is the message from "git status":
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
#       modified:   include/linux/netfilter/xt_MARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_CONNMARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_DSCP.h
#       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
#       modified:   include/linux/netfilter_ipv4/ipt_MARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TOS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_MARK.h
#       modified:   net/ipv4/netfilter/ipt_ECN.c
#       modified:   net/ipv4/netfilter/ipt_TOS.c
#       modified:   net/ipv4/netfilter/ipt_TTL.c
#       modified:   net/ipv6/netfilter/ip6t_HL.c
#       modified:   net/netfilter/xt_CONNMARK.c
#       modified:   net/netfilter/xt_DSCP.c
#       modified:   net/netfilter/xt_MARK.c
#
nothing to commit

>> (In fact I never modified anything in this tree, and "git diff"
>> showed many difference indeed, very strange).
> 
> That's windows and cygwin for you. They work together
> and may someday even figure how to commit the changes.

Yes, I am using cygwin :-(

> 
> They problem is the exec-bit which windows does not
> have and cygwin failed to correctly workaround the
> limitation.
> 
> Do a "git repo-config core.filemode false" to almost
> disable the checks for exec bit.
> 

It has been set. I guess the cause is a interrupted merge
operation that leads to textual difference.

>> I tried "git update-index --refresh", "git reset --hard",
>> "git reset --hard master", "git checkout master",
>> "git checkout -f master", but "git status" still said same
>> as above.
> 
> After git update-index --refresh you shouldn't have had
> the diffs (unless you actually had textual changes).
> 
>> At last, I deleted all files that were reported to be updated
>> with "rm -rf", ran "git checkout master" and "git status", then
>> git reported:
>> #       deleted:    ....
>> #       deleted:    ....
> 
> Now do a git reset --hard and you should be set,
> unless you're unlucky enough to work on FAT,
> where probably nothing will save you.
> 

After run "git reset --hard", all deleted files come back, but I reach
the old state:
$ git status
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
...
#       modified:   net/netfilter/xt_MARK.c
#
nothing to commit

> And avoid using any "special" characters (8bit, utf/unicode)
> in filenames, while you're on windows: you'll never be able
> to share the repository (unless others agree to use your
> rules for language and filesystem encoding).
> 
In fact, I'm operating the linux-2.6 tree, so no special characters.


HEAD: commit 088406bcf66d6c7fd8a5c04c00aa410ae9077403
master: commit 088406bcf66d6c7fd8a5c04c00aa410ae9077403
origin: commit ff51a98799931256b555446b2f5675db08de6229
"git diff --cached" shows nothing;
"git diff" shows many diffs:

diff --git a/include/linux/netfilter/xt_CONNMARK.h b/include/linux/netfilter/xt_CONNMARK.h
index 9f74468..c592f6a 100644
--- a/include/linux/netfilter/xt_CONNMARK.h
+++ b/include/linux/netfilter/xt_CONNMARK.h
@@ -1,5 +1,5 @@
-#ifndef _XT_CONNMARK_H_target
-#define _XT_CONNMARK_H_target
+#ifndef _XT_CONNMARK_H
+#define _XT_CONNMARK_H

 /* Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
  * by Henrik Nordstrom <hno@marasystems.com>
@@ -10,16 +10,9 @@
  * (at your option) any later version.
  */

-enum {
-       XT_CONNMARK_SET = 0,
-       XT_CONNMARK_SAVE,
-       XT_CONNMARK_RESTORE
+struct xt_connmark_info {
+       unsigned long mark, mask;
+       u_int8_t invert;
 };
.....

