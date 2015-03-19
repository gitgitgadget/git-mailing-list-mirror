From: Dmitry Neverov <dmitry.neverov@gmail.com>
Subject: Re: submodule.$name.url is ignored during submodule update
Date: Thu, 19 Mar 2015 22:29:36 +0100
Message-ID: <CAC+L6n0FFtCiVWjS-TSBJRp0f81fmMHPitBeM-M6HiN-LJ_LxQ@mail.gmail.com>
References: <CAC+L6n1RjvzcqX33VDvcM-4CpQPHeaddA7Dhs9S+ma+T+DN28Q@mail.gmail.com>
	<CAEtYS8TM6KWEjpcOLL8qRmN1yEo4JGQLLJCkkQ+GHaX7F-aLJA@mail.gmail.com>
	<CAC+L6n1Qgh+YFfFnbLe0_3JgCMBXdya+pPraU0ZsXn0HJecaeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYi0c-00074C-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbbCSV3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:29:38 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:34137 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbCSV3i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:29:38 -0400
Received: by wegp1 with SMTP id p1so67806631weg.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=79JUYyZglfC5NKYKNOP6d808FSKBs7cyZ/o5YfL6bVE=;
        b=SYzXJgoqT69DFS8iux+thKbM1heyr/pgc3BeRfRfHBQVAaQTMnM0cpdG/WMHNQEwTE
         EfevJeaObpKH5H8XSxE00eoFXLqMaLjB07eHQukLLd5IaBdU0zF2PIRfQ5NyuvoMrk+M
         rVpO1itljzmwsVfoQsqIDoRAKLngJ8TDdX9zbKw04tfbjY1P6g7yPoE12sjK0hF1KTbO
         xrXWjaY1DRk8MtE1nkFBD7VjG3COpWIkDQHQLe7HVj9esbY0n9ct1whxmHv2CVWxPFIj
         ew3S23RYzqeKSP3bY6EN7/7RnUF4RtYo7PLIi4gwaazp+SdVuKT7n96+z0uGcJa3/ln8
         sKjA==
X-Received: by 10.195.13.168 with SMTP id ez8mr153306632wjd.30.1426800576801;
 Thu, 19 Mar 2015 14:29:36 -0700 (PDT)
Received: by 10.194.106.34 with HTTP; Thu, 19 Mar 2015 14:29:36 -0700 (PDT)
In-Reply-To: <CAC+L6n1Qgh+YFfFnbLe0_3JgCMBXdya+pPraU0ZsXn0HJecaeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265838>

Sorry, my bad. I thought 'git submodule sync' changes only
'submodule.$name.url' in main repository config, but it also changes
the 'remote.origin.url' in submodule's config. I indeed ran 'git
submodule sync', that's why the default url was used even though
'submodule.$name.url' had a different value.

On Thu, Mar 19, 2015 at 2:16 PM, Dmitry Neverov
<dmitry.neverov@gmail.com> wrote:
> I want to use a custom url for both initial submodule clone and
> submodule update. Git submodule man page states that if I run 'git
> submodule init' and then change the 'submodule.$name.url' in the main
> repository config, git will use this url instead of url in
> .gitmodules. Git does use the custom url for initial submodule clone,
> but doesn't use it when cloned submodule needs to be updated. Is that
> by design?
>
> On Thu, Mar 19, 2015 at 2:09 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
>> On Thu, Mar 19, 2015 at 4:27 AM, Dmitry Neverov
>> <dmitry.neverov@gmail.com> wrote:
>>> Hi,
>>>
>>> I've noticed that the 'submodule.$name.url' config parameter from the
>>> main repository is ignored when a submodule needs to be updated, the
>>> submodule's 'remote.origin.url' is used instead. Is there any way to
>>> customize the submodule url for both the initial clone and for
>>> updates?
>>
>> That's what "git submodule sync" is for. It will synchronize the url
>> in .gitmodules with
>> to the remote.origin.url for each submodule.  I'm not sure about the second part
>> of your question: are you talking about using different URLs for the
>> initial clone
>> and updates?
