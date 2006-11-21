X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Tue, 21 Nov 2006 09:26:52 +0000
Message-ID: <b0943d9e0611210126x493848d9xae006af835fc62c7@mail.gmail.com>
References: <200611202201.45521.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 09:28:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nqotNMXdWgNdS0aY3weP7/Hb8m90+ozuphugIDskRG6Vmyw6n00eQDUJrQ/I1PSCtalltJOe6yBa5ivCw+TXwdVwTgWGWp5EI+Ag3XyZLD/0XKvPLmgtW8HXZH71S6xXNaQe353EaJq3kAmaS9evxqdDDzf3XtaR/hZG2SKiLUU=
In-Reply-To: <200611202201.45521.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31979>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmRvJ-0006DV-22 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 10:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966948AbWKUJ1t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 04:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966946AbWKUJ1t
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 04:27:49 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:27080 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S966948AbWKUJ1s
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 04:27:48 -0500
Received: by wx-out-0506.google.com with SMTP id s7so2143027wxc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 01:27:47 -0800 (PST)
Received: by 10.90.86.10 with SMTP id j10mr4872627agb.1164101267319; Tue, 21
 Nov 2006 01:27:47 -0800 (PST)
Received: by 10.35.109.8 with HTTP; Tue, 21 Nov 2006 01:26:52 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 20/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
> I have used StGit (wonderfull tool) to manage patches on git branch
> gitweb/web. Unfortunately, I have named stg branch the same as git
> branch.

Well, there is no such thing as a stg branch. StGIT shares the branch
structure with GIT and the "branch" command works on the whole GIT
branch, with some additional things for handling the patches. Once a
GIT branch is StGIT-initialised (either by being created with "stg
branch" or by "stg init") it will always remain a StGIT branch and get
a reference in refs/bases/.

> When removing stg branch (I wanted to remove
> heads/base/gitweb/web) using "stg branch --delete gitweb/web" it
> deleted also git branch when I wanted to remove only the StGit managed
> indicator. Fortunately I was able to recover the branch from reflog, as
> StGit didn't delete reflog with deletion of git branch.
>
> Perhaps that is correct behavior... but certainly unexpected.

I've never thought anyone would see a different meaing for the
"branch" command. What you wanted to do was the reverse of the "init"
command. Maybe something like "uninit" or a "--uninit" option to
"branch".

-- 
