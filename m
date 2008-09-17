From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Wed, 17 Sep 2008 11:07:32 +0200
Message-ID: <200809171107.35826.jnareb@gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail> <200809152205.15388.jnareb@gmail.com> <fcaeb9bf0809160521o24fd26e4l40f1798228d51712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 11:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kft2Q-0006dx-Hi
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 11:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbYIQJHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 05:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYIQJHt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 05:07:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:59843 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIQJHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 05:07:47 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1387597eyi.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=d7tIKRvsSOTc+7EIcf+P2WUng+6kZYXUT3mERSqJ/OI=;
        b=cgBvIhV+KQjEr/d2W4CRR+qaXXZco5crXzKdjhLJk1Shsw5//LXhwKEEzH8VdPIrF1
         QqFMNExqGG581gKZ7DNkA86Zqv0vJ7Kyl71PiLWuaAwB3sH6aSdMuVtWawJs5Co2vazS
         sbLdGqjrgWqnqVqqvNAlOgr4QHLb3tBpt997o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Hy1dEWTozhhmQdOrRY1o88ijioTmbuhhPfLm9Pi6llI4nO26i4hXHQe6NDZLoGMN7G
         YuOkjge8QqjTmrULoD0YnOR6K28yS5RWHjjkP73osdnut8lmBph9OTKJHNBpGz6oDCMH
         lgjGpxqMRE5sWfkoonLkpXO0IqZeF7Fm7yEVU=
Received: by 10.86.27.9 with SMTP id a9mr1694018fga.57.1221642466018;
        Wed, 17 Sep 2008 02:07:46 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.173])
        by mx.google.com with ESMTPS id 12sm17965225fgg.0.2008.09.17.02.07.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 02:07:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809160521o24fd26e4l40f1798228d51712@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96077>

On Tue, 16 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/16/08, Jakub Narebski <jnareb@gmail.com> wrote:

>>>> Couldn't you simply escape ':', i.e. write for example Git\:\:Tag.3pm,
>>>> or Eichten_PRD21\:313,1980_erratum.tex, or \:0.log, or perhaps
>>>> kmail/jnareb@gmail.com\:@pop.gmail.com\:995, or even something like
>>>> Mail/inbox/cur/1194202360.32296.mprnq\:2,S, in the same way like you
>>>> can escape other special characters, for example wildcard characters
>>>> like '\*' for '*' and '\?' for '?', and of course '\\' for '\'?
>>>
>>> Sure. Somehow I forgot that.
>>
>> Well, if it is possible, it should be stated in documentation.
>>  Even if it is obvious.
> 
> I mean it should be possible, but not yet implemented. Next time
> document will be updated when '\' escape is implemented.

I was thinking about explicitly stating this limitation (that ':' in
paths are not permitted/can be not escaped), or put it in "Bugs" aka
"Known Limitations" ;-) (sub)section.

>>> --<--
>>> Narrow checkout
>>> ---------------
>>>
>>> Normally when you do checkout a branch, your working directory
>>> will be fully populated. In some situations, you just need to
>>> work on certain files, no full checkout is needed. Narrow
>>> checkout is a mode that limits checkout area according to your
>>> needs.
>>
>> You have decided then on the term 'narrow checkout', and not
>>  'partial checkout' or 'sparse checkout', then?
> 
> Not yet. I tend to prefer partial/sparse checkout. Probably should
> have a look at how other SCMs do and what term they use. If Git's
> functionality is so different, a different term might notice people
> about that.

Perhaps whip up a survey? Just kidding (or not).

>>> Because narrow checkout uses new index format, it will be
>>> incompatible with git prior to 1.6.0 regarding worktree operations.
>>> Repository-only operations such as clone, push, pull... should not be
>>
>> s/pull/fetch/. pull affects working repository, and it can affect
>>  narrow checkout unexpectedly by conflicts during merge part of pull.
> 
> Bad writing. I mean pull/fetch from a narrow-checkout-ed repository to
> another fully populated one. Will fix.

Well, I though that you were referring to operations done _inside_
given repository, not on repository from outside. So I would say
something like repository-only operations (operations which do
not affect index and/or working area) such as fetch and pull, and
by definition all remote operations such as fetching from repository,
or cloning this repository... but this also isn't IMHO best way to
say it.

>>> affected by narrow checkout. In order to make your working directory
>>> work again with those versions, you can use `git checkout --full` to
>>> return to normal mode (and compatible index format).
>>
>>
>> By the way, you have made "git checkout <file>" get file and mark
>>  it "wanted", i.e. clear/zero "no-checkout" bit.  Wouldn't then
>>  "git checkout ." be shorter equivalent to "git checkout --full"?
>>  I'm not saying that '--full' option should be abandoned...
> 
> It is not equivalent. "git checkout ." will happily overwrite any
> modified files in your working directory.

True, I fortgot about this. Sorry, my mistake.
 
>>> When you apply new narrow spec to your working directory using either
>>> --path, --add-path or --remove-path, it will update "checkout" status
>>> in index accordingly. Moreover, if a file is marked "no-checkout" and
>>> is present in working directory, it will be removed. If a file is
>>> turned from "no-checkout" to "checkout", then it will be added again
>>> to working directory. Modified and unmerged entries can't bear
>>> "no-checkout" status, if narrow spec applies to them, "git checkout"
>>> will refuse to update working directory.
>>
>>
>> Do I understand correctly, that if one uses --path=<colon separated list>
>>  _only_ filenames matching one of patterns specified would be checked out,
>>  --add-path=<path> would additionally checkout given path and mark "wanted",
>>  and  --remove-path=<path> would additionally mark "no-checkout" and remove
>>  path?
> 
> --add-path/--remove-path also use narrow spec, which could be more
> than one pattern.

What is the difference then between --add-path and --path? The fact
that --add-path can be incremental, and --path starts always from
an empty set?
 
>>  What --add-path starts from, i.e. does
>>
>>   $ git checkout --add-path=.gitignore
>>
>>  starts from empty set if --add-path is first, or from full set as without
>>  --add-path?
> 
> I'm not sure I understand this.

Well, what I wanted to ask is if --remove-path starts from fully
checked out repository, for example if

  $ git checkout --remove-path=some_large_file

would checkout all files _except_ 'some_large_file'.

>>  And is <pathspec> matched against full pathname, or like .gitignore
>>  rules, i.e. as full pathname if it has at least one '/' in it?
> 
> like shell wildcard, full pathname must match. On my way back home, I
> thought I should have removed mention of "pathspec", which behaves a
> little bit different.
> 
> Also those specs are relative to working directory though, so if you
> are in b/c and want to match d, you only need to type --add-path=d
> instead of --add-path=b/c/d. Will add this to doc.

I would have thought that you follow the same rules (perhaps with
exception of !path excluding rule) like for gitignore and gitattributes.

-- 
Jakub Narebski
Poland
