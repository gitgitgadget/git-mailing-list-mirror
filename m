X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: n0dalus <n0dalus+redhat@gmail.com>
Subject: Re: Using git-bisect to find more than one breakage
Date: Thu, 14 Dec 2006 01:36:36 +1030
Message-ID: <6280325c0612130706keb86890n1395ec765a140d60@mail.gmail.com>
References: <6280325c0612112034x373c8022q909ca192a866cfcf@mail.gmail.com>
	 <20061213143404.GA24132@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 15:06:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EHI2eKAeSYS6ouzoMUaXSBjAhkpBIGlWO19uE5wlQEDOUbB0CdImYjNwA8ChTCj2PT7nkCeF0T8vP73tpFyFMntfVZ4a2LgSuvCmlF9Giq+7rKTH2jsVu9z2lsI1a14+r4AERC4v1WMDGKJBjFRp/rE2LPBi8Hdh8DWIeIuWfBU=
In-Reply-To: <20061213143404.GA24132@fieldses.org>
Content-Disposition: inline
X-Google-Sender-Auth: dfffe3c243da5336
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34221>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuVgv-0002nk-H4 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 16:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964996AbWLMPGi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 10:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWLMPGi
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 10:06:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:19335 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964996AbWLMPGh (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 10:06:37 -0500
Received: by wx-out-0506.google.com with SMTP id h27so185692wxd for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 07:06:36 -0800 (PST)
Received: by 10.70.113.13 with SMTP id l13mr1690741wxc.1166022396447; Wed, 13
 Dec 2006 07:06:36 -0800 (PST)
Received: by 10.70.129.20 with HTTP; Wed, 13 Dec 2006 07:06:36 -0800 (PST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

On 12/14/06, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Tue, Dec 12, 2006 at 03:04:29PM +1030, n0dalus wrote:
> >
> > I am thinking for now I will just use git-bisect between the bad
> > commit and master, and apply my changes to every bisection.
>
> Yes, that's the way to do it.
>
> The git-rebase command is intended for rebasing small pieces of purely
> linear history; I don't believe it will work well (at all?) to rebase a
> large chunk of kernel history.
>

Yeah, I figured it couldn't deal with all the merges and stuff.

It'd be nice if the man page for git-rebase warned about it's
inability to handle lots of complex merges. Or if the git-bisect man
page mentioned that the easiest way to find more than one problem is
to find and fix the first, then apply that fix to every bisection
between that first problem and a known bad version.

Thanks though, now I can stop worrying about why the rebase wasn't
working and concentrate on finding the bugs.

