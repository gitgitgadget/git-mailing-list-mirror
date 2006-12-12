X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 12:26:29 +0000
Message-ID: <200612121226.32772.andyparkins@gmail.com>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com> <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net> <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:26:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uCe6qO2PnAp33V3qJNee4DIlxFfUKLzLKyYgo2DAHodKgQpQIPeXje9snGHEOMLeLiFvVoyplMN5MT35J72OX2u9or4r0R1tuKGQn9U0F5RstosefXCP1dAqodoiea2Xszy/q9nodT/tXjj7q5d3cBA8f+2RzPhKwbhaNy0WOBY=
User-Agent: KMail/1.9.5
In-Reply-To: <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34088>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6iZ-0008GL-9C for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751260AbWLLM0k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWLLM0k
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:26:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:59089 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751260AbWLLM0j (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 07:26:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1646983uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 04:26:37 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr5333374ugm.1165926397631; Tue, 12
 Dec 2006 04:26:37 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 29sm6731511uga.2006.12.12.04.26.37; Tue, 12 Dec 2006 04:26:37 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 11:32, Bahadir Balban wrote:

> If I don't know which files I may be touching in the future for
> implementing some feature, then I am obliged to add all the files even
> if they are irrelevant. I said "performance reasons" assuming all the
> file hashes need checked for every commit -a to see if they're
> changed, but I just tried on a PIII and it seems not so slow.

Here's a handy rule of thumb I've learned in my use of git:

 "git is fast.  Really fast."

That'll hold you in good stead.  In my experience there is no operation in git 
that is slow.  I've got some trees that are for embedded work and hold the 
whole linux kernel, often more than once.  Subversion, which I used 
previously, took literally hours to import the whole tree.  Git takes 
minutes.

As to your direct concern: git doesn't hash every file at every commit.  There 
is no need.  git has an "index" that is used to prepare a commit; at the time 
you do the actual commit, git already knows which files are being checked in.  
Obviously, Linus uses git for managing the linux kernel, he's said before 
that he wanted a version control system that can do multiple commits /per 
second/.  git can do that.

In short - don't worry about making life easy for git - it's a workhorse and 
does a grand job.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
