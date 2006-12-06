X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 21:08:55 +0100
Message-ID: <e5bfff550612061208g6e4003e7ifa7dbd5ed69180c9@mail.gmail.com>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
	 <20061206192800.GC20320@spearce.org>
	 <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
	 <20061206194258.GD20320@spearce.org>
	 <20061206195142.GE20320@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 20:09:13 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C1gBuLi8Yv1ngQjeGWY5YHHhyiaUI232FFv9x1tGVr8ZaX3jyOTbNZ8L4uLO+O9KWe55iAPodf7SNeahYB4Nd7ITs/e9vqMeyTr/L9wJIJQgB6HEYN6k4giGEXnS4JSDB/mu1mDUjn2x5PWKHxVur1On5NlOos/5yabA1wEMi0w=
In-Reply-To: <20061206195142.GE20320@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33516>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs34e-0007P8-DP for gcvg-git@gmane.org; Wed, 06 Dec
 2006 21:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937592AbWLFUI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 15:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937594AbWLFUI5
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 15:08:57 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:55913 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937592AbWLFUI4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 15:08:56 -0500
Received: by py-out-1112.google.com with SMTP id a29so172137pyi for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 12:08:55 -0800 (PST)
Received: by 10.35.76.9 with SMTP id d9mr1975086pyl.1165435735865; Wed, 06
 Dec 2006 12:08:55 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Wed, 6 Dec 2006 12:08:55 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 12/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
>
> Perhaps there is some fast IPC API supported by Qt that you could
> use to run the revision listing outside of the main UI process,
> to eliminate the bottlenecks you are seeing and remove the problems
> noted above?  One that doesn't involve reading from a pipe I mean...
>

Qt it's very fast in reading from files, also git-rev-list is fast in
write to a file...the problem is I would not want the file to be saved
on disk, but stay cached in the OS memory for the few seconds needed
to be written and read back, and then deleted. It's a kind of shared
memory at the end. But I don't know how to realize it.

Also let git-rev-list to write directly in qgit process address space
would be nice, indeed very nice.


