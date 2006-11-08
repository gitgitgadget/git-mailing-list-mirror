X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: Shallow clone [Was Re: What's in git.git ]
Date: Wed, 08 Nov 2006 23:29:05 +0530
Message-ID: <45521AE9.7050902@gmail.com>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz> <45520872.3090506@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080305010804010403090608"
NNTP-Posting-Date: Wed, 8 Nov 2006 17:59:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=ccoaXFAepJ3SICSBTvqfbcrmAiqmcoAuw79s5XcqV0E4wWbbjOMi8k3CExzLHHDqQLC6WDIRytJq/5IK/i83LaGBwwvSR3kX+afVp/EqIrmArm6hO4Z0aYWSVJ9xV4uSK2ZE/hvRz1Yx4lJxVTjo3y4hPhx5m87cnXURcjHOHEE=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <45520872.3090506@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31148>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhriD-0004GK-PZ for gcvg-git@gmane.org; Wed, 08 Nov
 2006 18:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754630AbWKHR7T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbWKHR7T
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 12:59:19 -0500
Received: from nz-out-0102.google.com ([64.233.162.195]:36909 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1754630AbWKHR7S
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 12:59:18 -0500
Received: by nz-out-0102.google.com with SMTP id z3so1523788nzf for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 09:59:17 -0800 (PST)
Received: by 10.35.41.12 with SMTP id t12mr6042358pyj.1163008757051; Wed, 08
 Nov 2006 09:59:17 -0800 (PST)
Received: from ?192.168.2.47? ( [59.92.130.252]) by mx.google.com with ESMTP
 id f75sm2078004pye.2006.11.08.09.59.14; Wed, 08 Nov 2006 09:59:16 -0800 (PST)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------080305010804010403090608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> David Lang wrote:
>> On Tue, 7 Nov 2006, Junio C Hamano wrote:
>>
>>> [pu]
>>>
>>>  Johannes's shallow clone work now should rebase cleanly on top
>>>  of 'master' although I haven't done so yet.  As he said
>>>  himself the series is waiting for people who have needs for
>>>  such a feature to raise hands.
>>
>> I haven't been watching this recently, but if this is what I 
>> understand it to be (the ability to get a partial repository from 
>> upstream and work normally from there with the result of data-mineing 
>> tools sometimes reporting 'that's part of the truncated history' if 
>> they hit the cutoff) consider my hand raised.
>>
>> there are a number of cases where I would be interested in following a 
>> project as it moves forwards, but do not have the need to have the 
>> full history (even with the good compression that a git pack provides, 
>> it's still a significant amount of disk space and download time for 
>> large projects)
>>
> 
> I am trying to test this feature. Is there a documentation .git/shallow 
> some where. Atleast what those entries
> mean ? I know in the mail johannes mentioned only core git will touch 
> this file. But it should be ok to be descriptive like other files. 
> (FETCH_HEAD)


How about this 

-aneesh 

--------------080305010804010403090608
Content-Type: text/x-patch;
 name="repository-layout.txt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="repository-layout.txt.diff"

diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 275d18b..03a6f77 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -141,3 +141,9 @@ logs/refs/heads/`name`::
 
 logs/refs/tags/`name`::
 	Records all changes made to the tag named `name`.
+
+shallow::
+	Records the sha1 of the commits which is marked to have no
+	parents to represent a shallow repository.The commit object
+	will have the parent information present. It carry one
+	record per line.

