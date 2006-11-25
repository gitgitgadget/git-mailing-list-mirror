X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 12:00:08 +0100
Message-ID: <8c5c35580611250300q521c5723t2d356d73d4c4fdb6@mail.gmail.com>
References: <1164409429445-git-send-email-hjemli@gmail.com>
	 <4c8ef70611250239h4e03b9c7k971b60187aa0f56d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 11:00:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A80lrh7iFWhQ8fOTMYqz4u8bOj6hJhtEvtAStyTjFGEPRz7i3RCsP3u9LjUSfXoB5N37pQKFrYjFVElyYiqlYdve+Yu95MuRi03ovpa9FHspIUwjgRbdEAXnWSC5UA1ri3vwsPMQW4v6u95t3qWYlQv7Q4hfEzMC7BZjJlS9NZw=
In-Reply-To: <4c8ef70611250239h4e03b9c7k971b60187aa0f56d@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32282>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnvGc-0002HG-70 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 12:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934493AbWKYLAL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 06:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934474AbWKYLAL
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 06:00:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:17401 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1757912AbWKYLAK
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 06:00:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1533999nfa for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 03:00:08 -0800 (PST)
Received: by 10.82.175.2 with SMTP id x2mr1712319bue.1164452408113; Sat, 25
 Nov 2006 03:00:08 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Sat, 25 Nov 2006 03:00:08 -0800 (PST)
To: "Fredrik Kuivinen" <frekui@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/25/06, Fredrik Kuivinen <frekui@gmail.com> wrote:
> On 11/25/06, Lars Hjemli <hjemli@gmail.com> wrote:
> > This adds a '--rename' option to git branch. If specified, branch
> > creation becomes branch renaming.
> >
> > With a single branchname, the current branch is renamed and .git/HEAD is
> > updated.
> >
> > With two branchnames, the second name is renamed to the first.
>
> Nice idea. But wouldn't it be more sensible to rename the first branch to the
> second instead of the other way around? That is, the syntax would be
>
>     git branch --rename FROM TO
>
> which is more similar to how "mv" works.
>

Possibly, but then we would have

  git branch newbranch [oldbranch]

when creating a new branch, and

  git branch --rename [oldbranch] newbranch

for rename/move.

I'd prefer to be "internally consistent", but it does look and feel a
little strange...

Another option would be:

  git branch [--rename] [--from <branch>] newbranch

and deprecate the usage of two unnamed argumens for create/rename

-- 
