From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Wed, 11 Feb 2009 09:08:56 +0900
Message-ID: <20090211090856.6117@nanako3.lavabit.com>
References: <a1b6cb1b0902101558s7df025c7hfe078638452413c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Geoffrey Lee <geoffreyj.lee@gmail.com>
To: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2iV-000318-OL
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 01:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZBKALM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 19:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbZBKALM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 19:11:12 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50313 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbZBKALM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 19:11:12 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 2532211B9D9;
	Tue, 10 Feb 2009 18:11:11 -0600 (CST)
Received: from 1837.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id B23MSYGZ51JF; Tue, 10 Feb 2009 18:11:11 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hdccm2JqmjJX6nhUKMD1AcpARc/E0MQycS6+lFDnCSYs6+13XEetwBYLVc5cp0DBdPrl6p4u1ek9X5a60D+PePrSsCydY6JLgWNlHJjNItxCRP+XzbDMaU8rMYxBJLGeJoFy7kRkt/pV8xqU0o6ARtX+SvAODd5EL7r8fddG2Eg=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <a1b6cb1b0902101558s7df025c7hfe078638452413c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109358>

Quoting Ulrik Sverdrup <ulrik.sverdrup@gmail.com>:

>> On Tue, Feb 10, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Jeff King <peff@peff.net> writes:
>> > How is it different from "git stash create"?
>>
>> Git stash doesn't touch untracked files, whereas git snapshot would.
>> Take another closer look at the table in the original post titled
>> "What are the differences between 'git stash' and 'git snapshot'?"
>>
>> -Geoffrey Lee
>
> I'm understanding this just as I read this, but it seems that implementing a
> git snapshot (I'm myself interested), could be done quickly with a new git.
> (When was git stash create introduced? I don't know it?)

I did the initial git-stash at the end of June 2007; git-stash create was done by Junio about a week later and was released as a part of v1.5.4.

> Something like this:
> cp .git/index .git/tmp-index
> GIT_INDEX_FILE=.git/tmp-index
> git add -N .
> git stash create
>
> So we use add -N to put all files into tracked but unstaged by default, but we
> keep our old index. Now stash is ready to save off the working directory, and
> further logic has to be applied on the returned commit to save it off..

git-add -N came much later, late August 2008, and is available only in v1.6.1 and later.

I think you want to export GIT_INDEX_FILE you set to the temporary file before running these two commands.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
