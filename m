From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: Help debugging git-svn
Date: Fri, 8 Jan 2016 21:39:09 -0600
Message-ID: <CAOc6etZ5Ne+1SMsZ-7psJTihkHfm2ES1TWBRfjssfiOprQvp_Q@mail.gmail.com>
References: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
	<20151216074158.GB28518@dcvr.yhbt.net>
	<CAOc6eta=ZGyWFuBPAYe_4xWSH79RRmPcP5thCHYd8SsKScwW6g@mail.gmail.com>
	<CAOc6etaUUN_OdQqVJbHZ7XPq70hzEgO2HR1Uq0XxxEtK5CeDEQ@mail.gmail.com>
	<CAOc6etanJZub-rwqT-45WpKsutVe_wkDHbPS_RorxXLGHOE9tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 09 04:39:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHkN1-00030c-DK
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 04:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbcAIDjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 22:39:11 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34904 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcAIDjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 22:39:09 -0500
Received: by mail-pf0-f176.google.com with SMTP id 65so18145873pff.2
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 19:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vZvqEgs1Gh1OI1izUlMM7CUX8vIibZYKRCbW7sRQKqM=;
        b=m4HYWc4EVpWIbzBs8gvAWhuA7pL/cvQ7MXYUZMRl2BdcTJjo/joP+8UGwg04nblWoU
         A5R+kbMj8cSIjCZ7Azt+eqCgGwjD3LE43Up58dQcOJmbLpfjn6dd8airzQ69jC8Cg7Ny
         lBzfVzn/cHmL/IUO957/mEAd5q6FqgK+OWCttanWw+ui3tIozTZPFeDB5KRbL856Cqa0
         ZmbNspH7cUqrvYHYTFrS3BtbhqVd+kTh5XiuSo2mTs9oAJa/ZXvEYRaNcXmH739Aszxm
         GeVrTR5czvyJppeAS9QNR0AT8X1nKfudBeMULCqaEoIcxBBo8zI0maGbLWduPJLc46c4
         WIBQ==
X-Received: by 10.98.9.147 with SMTP id 19mr3956550pfj.163.1452310749127; Fri,
 08 Jan 2016 19:39:09 -0800 (PST)
Received: by 10.66.126.167 with HTTP; Fri, 8 Jan 2016 19:39:09 -0800 (PST)
In-Reply-To: <CAOc6etanJZub-rwqT-45WpKsutVe_wkDHbPS_RorxXLGHOE9tA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283598>

Hi!

On Fri, Dec 18, 2015 at 10:31 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 11:28 AM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>> Ok.... I came up with another idea to avoid having to deal with the
>> old svn history (I'm having no problems fetching/dcommitting with my
>> current repo). I already have the branches I work with, the thing is
>> that the revisions I fetched before I started using the svn authors
>> file have nasty IDs instead of human names. I though that I could
>> create a script to rewrite the whole history of the project adjusting
>> the usernames to real names (I'll take care of the details, no problem
>> there... just found out about filter-branch, could work for what I'm
>> thinking of). My question would be in the direction of rebuilding
>> git-svn metainfo once I'm done so that I can continue fetching from
>> svn as if nothing had happened. I checked the documentation in
>> git-scm.com but didn't find the details about it. Is there a
>> straight-forward document that explains how the git-svn metadata files
>> are built?
>>
>> Thanks in advance.
>
> .rev_map files appear to be simple enough. I'll have fun with them a
> little bit. Will let you know how it goes later (don't hold your
> breath.... it might take a while).


I was able to rewrite git-svn's history and I'm fetching/dcommitting
as usual using the new branches. I posted the tool I developed for the
task in github [1]. The readme explains how to use it.

Cheers!

[1] https://github.com/eantoranz/git_svn_rewrite
