X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 09:40:53 +0100
Message-ID: <e7bda7770612160040v1a769153p909a8cd40e5ea991@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
	 <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
	 <e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com>
	 <elviac$63t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 08:41:11 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ULJC7tHS27Hfd/U7qOuPnQvEnIBOU0WiZi2+vraT/ixNrjEYVslaACF4wnzEtuynIzZULn3dlVHVZmiteSxEAsBXl9lOwAIgNBw3Q9mrsXoRMDp+vylawf5QvTbafVF76lzuPHoN4gp2/Le6MF4v/3b0AKY3frSovrdZhn7IWos=
In-Reply-To: <elviac$63t$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34594>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvV6M-0006WQ-SA for gcvg-git@gmane.org; Sat, 16 Dec
 2006 09:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030793AbWLPIk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 03:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030792AbWLPIk4
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 03:40:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:42222 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030791AbWLPIkz (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 03:40:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1361527nfa for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 00:40:54 -0800 (PST)
Received: by 10.49.55.18 with SMTP id h18mr1159548nfk.1166258453299; Sat, 16
 Dec 2006 00:40:53 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 16 Dec 2006 00:40:53 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > 100644 blob <sha1 of blob>  >
> >>
> >
> > Sorry, I was sloppy and forgot the names:
> >
> > 100644 blob <sha1 of blob>    README
> > 100644 blob <sha1 of blob>    REPORTING-BUGS
> > 100644 link <sha1 of blob>     <sha1 of commit>   AUTHORS
> > 040000 tree <sha1 of tree>    arch
> > 040000 tree <sha1 of tree>    block
> > 040000 link <sha1 of tree>     <sha1 of commit>   misc
> >
> > Now it doesn't looks like trees/blobs anymore so maybe a link object
> > is handy:
> >  README
> > 100644 blob <sha1 of blob>    REPORTING-BUGS
> > 100644 link <sha1 of link>      AUTHORS
> > 040000 tree <sha1 of tree>    arch
> > 040000 tree <sha1 of tree>    block
> > 040000 link <sha1 of link>     misc
> >
> > link-object:
> > <sha1 of commit>
> > <sha1 of tree/blob>
>
> What do you need <sha1 of tree/blob> for in link-object? Wouldn't you
> use usually the sha1 of top tree of a commit, which is uniquely defined
> by commit object, so you need only <ahs1 of commit>?
>

1. "Sparse" repository's - In my example, I want to cherry-pick
header-files or binary-files from different projects without fetching
all, potentially huge, submodules in their entirety. Imaging having X,
kernel, gcc, gtk and libc6 as sub-projects and you really only care
about some header files.

2. Super-module directory-hierarchy independent from submodules.
Super-project want to have the header-files and binaries it's own way.
This also gives version controlled file-collections, the "release
case" in my example - collecting different binaries and header-files
from different submodules together in a new directory-structure, add
some documentation and configuration files and get the whole thing
under strong version-control down to the beginning of time for each
little component.

3. Super-module development independent of submodules - If we have the
tree/blob-object with all it contents in the database many
git-operations can act as the link (commit) wasn't there since we have
access to all relevant data to work with. This makes it easy to clone
the super-project and work on it seamlessly without having to care
about submodules or mapping up submodule repository's (unless you want
to modify the links or the data underneath it of course).

