X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 16:05:56 +0100
Message-ID: <e7bda7770612160705l61d1f350n70a8ba91754491c9@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
	 <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
	 <e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com>
	 <elviac$63t$1@sea.gmane.org>
	 <e7bda7770612160040v1a769153p909a8cd40e5ea991@mail.gmail.com>
	 <em0fpq$45b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 15:06:27 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NgG03yyblY3nX+fncTF3eFKNllzcKvb6ogP1V0v5IeEVIixWjF3yloL7I1zFboWMYF1anxQ1z7MRrEwmpeMEEzak+JFwR81+QG/28fKKuc/2WH6dyVN0Yf+mbqxkBgzXo4FIe2IwOf3oq4KPWcfHx/ZYzt2aWoEameVrVjejr+o=
In-Reply-To: <em0fpq$45b$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34621>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvb7G-0004Vp-NZ for gcvg-git@gmane.org; Sat, 16 Dec
 2006 16:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161024AbWLPPF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 10:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWLPPF7
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 10:05:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:4908 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161024AbWLPPF6 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 10:05:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1430243nfa for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 07:05:57 -0800 (PST)
Received: by 10.49.90.4 with SMTP id s4mr4360058nfl.1166281556736; Sat, 16
 Dec 2006 07:05:56 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 16 Dec 2006 07:05:56 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:
> All fine, but this does not and I think cannot protect us from the
> fact that we can have <sha1 of tree/blob> which doesn't match
> <sha1 of commit>.

True, that will be a real problem. Unless we have a bug in git, do you
see a scenario in which this is likely to happen?


> I think it would be better to have sparse/partial checkout first.
> But that is just my idea. Because with <sha1 of tree/blob> which
> is not sha1 of commit tree you might loose (I think) the ability
> to merge, for example your changes to submodule with upstream.

That's correct. I also want a sparse/partial checkout but I don't want
the full submodule path. I'm also perfectly fine (for my current
use-cases) with not being able to merge upstream unless we're tracking
the commit tree (here, we might not want to specify the tree SHA1).

I'm not trying to impose a technically fragile solution here [I don't
believe it is, but I'm not the most competent to say that either], I'm
trying to find solutions for my use cases and I had problems adapting
them to the current suggestion.


> > 3. Super-module development independent of submodules - If we have the
> > tree/blob-object with all it contents in the database many
> > git-operations can act as the link (commit) wasn't there since we have
> > access to all relevant data to work with. This makes it easy to clone
> > the super-project and work on it seamlessly without having to care
> > about submodules or mapping up submodule repository's (unless you want
> > to modify the links or the data underneath it of course).
>
> This is I think irrelevant to the fact if we have only <sha1 of commit>,
> or link object and also <sha1 of tree/blob>

