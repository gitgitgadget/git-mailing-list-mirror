From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: looking for suggestions for managing a tree of server configs
Date: Sat, 20 Oct 2012 21:50:19 -0400
Message-ID: <CAM9Z-nmHxyqnyq1fChhv7hP_awgsaO2FT1t29PAwrvZkaA-hgg@mail.gmail.com>
References: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm>
	<7vpq4l1x86.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.02.1210132153040.6253@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Oct 21 03:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPkjZ-0006DK-I4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 03:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab2JUBuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 21:50:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34541 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab2JUBuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 21:50:21 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so631831bkc.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=39JbXKp87npPgtmD21kfy6bpHJmrbPWKo/rZV2LDPOA=;
        b=BATdW4UjVS34V02BL8AiYZlYSIdohmTJ33QhfRm/lICMpCp+b0gAqVBQDEZEsDOfPy
         JCPsugRmvF9H7wsIB+7hBKx8pJu07UhTRvtd4RikaHJwELZqnTF9V1Y5YMR+pvuPmnRB
         YnLpXJqwlWRb/vcnVune8izrsZBllrV8aa2M0GkKgt+cRnd0w9NvfsyeeJAYNtD6rQgr
         7a6ZaMnthQf/ClvPuM6qdB6uWf7REX4ngtgbHRfYql38KC9aQL+CbcLYhYfk8gVxQQ2l
         lqbaVUyNGuH9kKeHZSYQlAZsIGT5A84zIx89ZpG2RYDHiP4N6TVP8tdGqz177huJ68Nj
         3eAQ==
Received: by 10.204.148.21 with SMTP id n21mr1590731bkv.124.1350784219260;
 Sat, 20 Oct 2012 18:50:19 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Sat, 20 Oct 2012 18:50:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1210132153040.6253@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208097>

On Sun, Oct 14, 2012 at 12:57 AM,  <david@lang.hm> wrote:
> On Sat, 13 Oct 2012, Junio C Hamano wrote:
>> david@lang.hm writes:
>>> I've got a directory tree that holds config data for all my
>>> servers. This consists of one directory per server (which is updated
>>> periodically from what is currently configured on that server), plus
>>> higher level summary reports and similar information.
>>>
>>> today I have just a single git tree covering everything, and I make a
>>> commit each time one of the per-server directories is updated, and
>>> again when the top-level stuff is created.
>>
>> It is quite clear to me what you are keeping at the top-level files,
>> but if a large portion of the configuration for these servers are
>> shared, it might not be a bad idea to have a canonical "gold-master"
>> configuration branch, to which the shared updates are applied, with
>> a branch per server that forks from that canonical branch to keep
>> the machine specific tweaks as differences from the canonical stuff,
>> instead of having N subdirectories (one per machine).
>
> In an ideal world yes, but right now these machines are updated by many
> different tools (unforuntantly including 'vi'), so these directories aren't
> the config to be pushed out to the boxes (i.e. what they should be), it's
> instead an archived 'what is', the result of changes from all the tools.
>
> The systems are all built with a standard image, but the automation tools I
> do have tend to push identical files out to many of the systems (or files
> identical except for a couple of lines)

David,
Is there any particular reason you aren't using etckeeper?

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
