From: Dmitry Oksenchuk <oksenchuk89@gmail.com>
Subject: Re: Joining historical repository using grafts or replace
Date: Thu, 30 Oct 2014 20:56:54 +0300
Message-ID: <CA+POfms4+fPnEv2nBPJx+hPRSMZyR66wpvfDf+SFy3X_8t2H-Q@mail.gmail.com>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
	<20141030154426.GU15443@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjtyB-0008DM-2L
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 18:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760826AbaJ3R45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 13:56:57 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:37196 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759946AbaJ3R4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 13:56:55 -0400
Received: by mail-yh0-f50.google.com with SMTP id b6so1875784yha.37
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IFT7rhCFTmkiY1cJHZuf8TXVjVF2Qvw2rbOuaORLDAc=;
        b=gvlUvGqLi/dHRcvzkRFVxbzgRGoYrjIz8BqD1nuwL3DkOsJ+9imlS1iY9W24D6/U9/
         cPUAUvtJ6odw/j1bSKKCeuuYo239gAJKhehuOtkfjp4sb3Lgjco6Sz8h6qsP8Cgj/ZWP
         QN6q7cKszJmdKuWAC4+tAfuybwh+m96HogZiiBpJ8a3j8VSKImpUNi+M0he2TvKdojWX
         +CrnNJzSPaWVxp1avJfPe+pdC9YhVJM+KE3ON4LS3Q3DZCVKL5cOChIHEJsZD2NU0jVm
         bXVYemY3Q+FdtsT210b6h6mDb8SQLp0CN4quI0kRY50TViYGfyP5XyjKULE9JGKyYevH
         U0kg==
X-Received: by 10.170.217.131 with SMTP id j125mr4816848ykf.128.1414691815004;
 Thu, 30 Oct 2014 10:56:55 -0700 (PDT)
Received: by 10.170.141.194 with HTTP; Thu, 30 Oct 2014 10:56:54 -0700 (PDT)
In-Reply-To: <20141030154426.GU15443@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-10-30 18:44 GMT+03:00 W. Trevor King <wking@tremily.us>:
> On Thu, Oct 30, 2014 at 06:39:56PM +0300, Dmitry Oksenchuk wrote:
>> We're in the middle of conversion of a large CVS repository (20
>> years, 70K commits, 1K branches, 10K tags) to Git and considering
>> two separate Git repositories: "historical" with CVS history and
>> "working" created without history from heads of active branches (10
>> active branches). This allows us to have small fast "working"
>> repository for developers who don't want to have full history
>> locally and ability to rewrite history in "historical" repository
>> (for example, to add parents to merge commits or to fix conversion
>> mistakes) without affecting commit hashes in "working" repository
>> (the hashes can be stored in bug tracker or in the code).
>
> A number of projects have done something like this (e.g. Linux).
> Modern Gits have good support for shallow repositories though, so I'd
> just make one full repository and leave it to developers to decide how
> deep they want their local copy to be.

Good point. Shallow clone allows a developer to have a small fast
repository if history is not needed.
But having new history in one repository with CVS history prevents us
from rewriting it in case of conversion mistakes or desire to restore
parents in merge commits.

Thanks,
Dmitry
