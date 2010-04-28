From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Global .git directory
Date: Wed, 28 Apr 2010 10:01:58 +0200
Message-ID: <l2i81b0412b1004280101ga2335a58z37d97295ab6c88e7@mail.gmail.com>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
	 <201004271159.34071.trast@student.ethz.ch>
	 <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
	 <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>
	 <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 10:02:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O72Dg-00061u-65
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 10:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab0D1ICA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 04:02:00 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:33300 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab0D1IB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 04:01:59 -0400
Received: by ywh32 with SMTP id 32so8289757ywh.33
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XFtJ5If1tRvJXKEhbLMgApwhgxfSEgWHrtX9FxkI8Lo=;
        b=faAm+WH/Czec54lo2up1N10fMgV6GH5mCy2dZERO9f5LBbemxf+iJy9l7vRdKAkx8H
         kaQJksStbbBw/a3gnAulWhia/GjAYume9ePx69C+XIHhmAhhTp/U2z1+FRvO07pYfRHc
         iU5r3Fbd2RCw6wkqpOeLC0Gz5W8ab1GnLRlQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b15agG9UtULiEcEYFhBFUliNUUoDQClBNOkUdBbnIcb6moVKqX0C4GJkwIFjmiMjD9
         XWvMRPQuUrlJOywlOKRRVv7x46BMRLrIQ64T5qvXR9Nc4QH/ppYHyiIo0ZYHGZVpToR6
         2UbnMP3zjJvibRDLSbFdnKllZ0gxBZoHPGKgQ=
Received: by 10.101.136.33 with SMTP id o33mr2402633ann.193.1272441718669; 
	Wed, 28 Apr 2010 01:01:58 -0700 (PDT)
Received: by 10.100.120.9 with HTTP; Wed, 28 Apr 2010 01:01:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145973>

On Wed, Apr 28, 2010 at 07:33, Gerhard Wiesinger <lists@wiesinger.com> wrote:
> On Tue, 27 Apr 2010, Erik Faye-Lund wrote:
>> Please see Documentation/SubmittingPatches. It's difficult to
>> comment on a non-inlined patch.
>
> Patch done on top of HEAD.

The patches "done on top of HEAD" are usually useless for
everyone, including the submitter. HEAD changes over time.
for instance I wont be able to apply your patches on my HEAD,
as I have a lot of changes in my Git repo.

If you about to share your modifications, you better base your
changes on stable points in history, like releases (marked by
release tags, like "v1.7.1").

> BTW2:
> Why is it necessary to do:

It is so you can distinguish between the changes in progress and
the changes ready to be submitted (prepared for commit).

> # Displays only changed files
> git diff

To be exact: the changes not yet staged for commit.

> # Displays only added files
> git diff --cached

No, it displays the changes ready to be committed (staged).

> I would like to have a full diff of my changes:
> git diff -a

You wouldn't use it. It is very useful to separate the phases of workflow.

BTW, try using "git status". It'll show you both lists of changed files.
Also "git gui", and "gitk" make the lists visible ("git gui" is more like
"git status", and you can commit from it).

> (or better "git diff -a" should be the default behaviour, I think that's
> very confusing for new users)

Only to unwilling to learn. You'd be probably the first to suggest
to combine the two stages of change. Usually people understand
(or get a feeling of understanding) the index even before they send
first mail to the mailing list.
