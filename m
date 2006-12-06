X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: "stgit clean" has problems with removed generated files
Date: Wed, 6 Dec 2006 13:12:53 +0000
Message-ID: <b0943d9e0612060512w272d656dwa3ef5b6875abf8fa@mail.gmail.com>
References: <20061123161135.GK5443@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0611230833y5ffc14d3q922a821744ad05d@mail.gmail.com>
	 <20061123192831.GL5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 13:13:21 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ljHFuugIfA/SXA0+ObnVNsYrh61yyyNAZj1KI1XB/0wZDscII3gk+WzCeEkLUYaJRtY2uCeigeKxuL7ae4KroYf8rjcdtJ7zpnsqHuns+65ejKWGEaRXgYsS2ucYVo9FQZzDOx4+SNnVIlaTZUE10pFqqPSyhNe1ROeZ29jramg=
In-Reply-To: <20061123192831.GL5443@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33454>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwaH-0007Wj-1N for gcvg-git@gmane.org; Wed, 06 Dec
 2006 14:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760584AbWLFNMy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 08:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760586AbWLFNMy
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 08:12:54 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:33590 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1760584AbWLFNMx (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 08:12:53 -0500
Received: by nz-out-0102.google.com with SMTP id s1so119916nze for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 05:12:53 -0800 (PST)
Received: by 10.64.10.2 with SMTP id 2mr1236869qbj.1165410773034; Wed, 06 Dec
 2006 05:12:53 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Wed, 6 Dec 2006 05:12:52 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 23/11/06, Yann Dirson <ydirson@altern.org> wrote:
> On Thu, Nov 23, 2006 at 04:33:42PM +0000, Catalin Marinas wrote:
> > >First, when cleaning patches, we could first look up which patches are
> > >to be removed, and only pop the necessary ones.

I fixed this.

> > Is there any other place where ranges could be used but aren't?
>
> Hm, let's see...  I'd say "export" (I have missed it already), "files"
> and maybe "commit" and "pick", although the latter would require a syntax
> for ranges in other branch.

I changed the export command to take a range of patches as arguments
(and a --dir option for the export directory).

> While reviewing the various commands for this, I realized that "stg pop
> <patch>" semantics is significantly different from "stg push <patch>" -
> ie. it is an equivalent of "goto".  What about turning it into a
> float+pop, to better match the "push" behaviour ?

Thanks for the suggestion, I fixed pop to take patch ranges now.

> I also realized that "stg help <command>" output does not go through to
> the pager, while eg. the help for "mail" is quite long.

Added this feature as well. I'll try to push the changes tonight.

-- 
