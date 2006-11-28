X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [RFC] git-branch: add options and tests for branch renaming
Date: Tue, 28 Nov 2006 15:03:42 +0000
Message-ID: <456C4FCE.6090306@shadowen.org>
References: <11647252603530-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 15:03:58 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <11647252603530-git-send-email-hjemli@gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32530>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4Uu-0000Rc-Rx for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935330AbWK1PDq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934539AbWK1PDq
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:03:46 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:43020 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S935330AbWK1PDp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:03:45 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gp4U8-0004DL-40; Tue, 28 Nov 2006 15:03:00 +0000
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

Lars Hjemli wrote:
> Extend git-branch with the following options:
> 
>   git-branch -m|-M [<oldbranch>] newbranch
> 
> The -M variation is required to force renaming over an exsisting
> branchname.
> 
> This also indroduces $GIT_DIR/RENAME_REF which is a "metabranch"
> used when renaming branches. It will always hold the original sha1
> for the latest renamed branch.
> 
> Additionally, if $GIT_DIR/logs/RENAME_REF exists, all branch rename
> events are logged there.
> 
> Finally, some testcases are added to verify the new options.

Ok, I have been feeling uneasy about rename and reflogs for a while now.
 About removing reflogs too for that matter.

In my mind the ref log is about tracking what a ref points to.  So I
want to be able to say "what was next, yesterday".  Do I care if its not
there now?  Perhaps I want a rename to just put a rename from in the top
of the new reflog and leave the old there.

Yep, no idea how we would clean them up with this model.  But ...

