From: Dmitry Neverov <dmitry.neverov@gmail.com>
Subject: Re: submodule.$name.url is ignored during submodule update
Date: Thu, 19 Mar 2015 14:16:50 +0100
Message-ID: <CAC+L6n1Qgh+YFfFnbLe0_3JgCMBXdya+pPraU0ZsXn0HJecaeQ@mail.gmail.com>
References: <CAC+L6n1RjvzcqX33VDvcM-4CpQPHeaddA7Dhs9S+ma+T+DN28Q@mail.gmail.com>
	<CAEtYS8TM6KWEjpcOLL8qRmN1yEo4JGQLLJCkkQ+GHaX7F-aLJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 14:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYaJk-0003Qx-H2
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 14:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbbCSNQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 09:16:52 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36031 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbbCSNQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 09:16:51 -0400
Received: by wgra20 with SMTP id a20so62119289wgr.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wGi9UWdnT2hnSeIL+EPuGKiwz5Bi173ndTSYVu+qJAo=;
        b=G+QKxGT6muphYbJ6YGGkPYCtqF4YNXjXVnfGv+nEaZNqO9xs50KNBxQonsV8X9VaGb
         h7BWPFDkaFlT8p4wlVUQ5JV3dWO/ERfd594hctkoi+cSYnAclzmxxKMHck6ZXBo5h8+b
         hqHeGAxZzeg0Lv+x6yYV2L2EXRIymUzg+GvgcDdlH9AOKZu+FGbfe2L2ly6V+pCSaaTR
         rxM/Gvvex5W49RKlup2GVrxrqYP6GsTRnwPTCIsZcR8ymR0Ph2Yv9RJ418FdNfYcRhju
         RslX5/j4uDybRPBh+h9ZCYR0W4SW5fd4D56fiCHbqLHxWsptFbUflYIyZCMRuXHGbdhe
         Flig==
X-Received: by 10.195.13.168 with SMTP id ez8mr149831683wjd.30.1426771010712;
 Thu, 19 Mar 2015 06:16:50 -0700 (PDT)
Received: by 10.194.106.34 with HTTP; Thu, 19 Mar 2015 06:16:50 -0700 (PDT)
In-Reply-To: <CAEtYS8TM6KWEjpcOLL8qRmN1yEo4JGQLLJCkkQ+GHaX7F-aLJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265802>

I want to use a custom url for both initial submodule clone and
submodule update. Git submodule man page states that if I run 'git
submodule init' and then change the 'submodule.$name.url' in the main
repository config, git will use this url instead of url in
.gitmodules. Git does use the custom url for initial submodule clone,
but doesn't use it when cloned submodule needs to be updated. Is that
by design?

On Thu, Mar 19, 2015 at 2:09 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> On Thu, Mar 19, 2015 at 4:27 AM, Dmitry Neverov
> <dmitry.neverov@gmail.com> wrote:
>> Hi,
>>
>> I've noticed that the 'submodule.$name.url' config parameter from the
>> main repository is ignored when a submodule needs to be updated, the
>> submodule's 'remote.origin.url' is used instead. Is there any way to
>> customize the submodule url for both the initial clone and for
>> updates?
>
> That's what "git submodule sync" is for. It will synchronize the url
> in .gitmodules with
> to the remote.origin.url for each submodule.  I'm not sure about the second part
> of your question: are you talking about using different URLs for the
> initial clone
> and updates?
