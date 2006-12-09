X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 18:34:18 +1300
Message-ID: <46a038f90612082134x38be9c8dgca6fe60c087bf100@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <200612081438.25493.jnareb@gmail.com>
	 <46a038f90612081728s65d65ccewe64fa1a496de76fa@mail.gmail.com>
	 <457A1962.6000401@zytor.com>
	 <46a038f90612081852u63e05da1qe57504636f3578fd@mail.gmail.com>
	 <457A44ED.4080606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 05:35:08 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Petr Baudis" <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NdwaLS6ft0gOb+6AEGyNR8aXhP50O1QBhC7ySEa6N7VEPNrNZl78fQjowCqZPWqlU3fkDjKhOcFjoZxaJix/r/TW09l9Q9gr9cEMQ+MC0lfeaIoihtaCUn26mu04I7wbVrhUXGfH4hbeO6FZQHnjcxccin5+oYNBEQTJfKUx13I=
In-Reply-To: <457A44ED.4080606@zytor.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33802>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsurX-0000OR-OL for gcvg-git@gmane.org; Sat, 09 Dec
 2006 06:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759007AbWLIFeV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 00:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759021AbWLIFeV
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 00:34:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:31288 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759005AbWLIFeU (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 00:34:20 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1332783nfa for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 21:34:18 -0800 (PST)
Received: by 10.49.41.18 with SMTP id t18mr6452056nfj.1165642458485; Fri, 08
 Dec 2006 21:34:18 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Fri, 8 Dec 2006 21:34:18 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

On 12/9/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Martin Langhoff wrote:
> > I posted separately about those. And I've been mulling about whether
> > the thundering herd is really such a big problem that we need to
> > address it head-on.
>
> Uhm... yes it is.

Got some more info, discussion points or links to stuff I should read
to appreciate why that is? I am trying to articulate why I consider it
is not a high-payoff task, as well as describing how to tackle it.

To recap, the reasons it is not high payoff is that:

 - the main benefit comes from being cacheable and able to revalidate
the cache cheaply (with the ETags-based strategy discussed above)
 - highly distributed caches/proxies means we'll seldom see a true
cold cache situation
 - we have a huge set of URLs which are seldom hit, and will never see
a thundering anything
 - we have a tiny set of very popular URLs that are the key target for
the thundering herd - (projects page, summary page, shortlog, fulllog)
- but those are in the clear as soon as the caches are populated

Why do we have to take it head-on? :-)



