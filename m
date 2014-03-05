From: Jeremy Nickurak <jeremy@nickurak.ca>
Subject: Re: Bad git log behavior with multiple glob path arguments
Date: Wed, 5 Mar 2014 09:21:53 -0700
Message-ID: <CA+eQo_2Gcipe7VA7WMY+etULjmSC=TqGmpZmGSGeWv03c93FDA@mail.gmail.com>
References: <CA+eQo_21j=GzsvWAjxzr+aFYcPcnnyozySOo0m9bO-xJq_6a9A@mail.gmail.com>
	<CACsJy8A28x5m1SLV-R=QrFniPXUbV+x9N27GA-j+Ut_oe_6oGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLEZz-0002Wq-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 17:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbaCEQVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 11:21:55 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33725 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaCEQVy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 11:21:54 -0500
Received: by mail-wg0-f46.google.com with SMTP id z12so1526493wgg.29
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nickurak.ca; s=google-dkim;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LLaXyT3qBsy7bzV6MuGhwbZK97vCL1OQZGwz3izLvkM=;
        b=Lwqh1gkUL4blg/hffoslYn5T/ozDjrgsSgKAJJJWvE0h8iwTyr0/wWqrOXNxMP9ZSe
         w4BM/sKLj0HHAvHGmKWbBzMPOmiaZt0yRzUOTnK59/9LFxdwuV/exnCPh+7nvw1nOvbU
         E9lauLggYMXXH/rf6485wj8duEbOT0qS3q3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LLaXyT3qBsy7bzV6MuGhwbZK97vCL1OQZGwz3izLvkM=;
        b=VxzbLzTaGha3wqDRwgphrjLzOPZOaplgld4I2jey9BQZqRhV5yvP0YtwGJT6nYMpON
         xz4wiW5G5C7fnupd3mSJMO5QIka04zbjdt/31ai4UF8RVMgir3sBXlSEUv+w+iQaUpEh
         K0/FRh+nch/WbhuYy0hWnRidDS8SrBJXQI185MLTNb4p0Q80005ocXX8usTQ1X2B1ueo
         Vui59PrPcOPSuVbOckXyqx15RA1k+eyyIw8Tp9LbQdGLRYoqPYCjl4VPCTUOxpaXFMfa
         z7rGcTwfk/hhhskJZj52GTSJlBqwCNJmCiK5XYwGJ4T95AlIkvyyOU9hqGKeJFhf252E
         z2Nw==
X-Gm-Message-State: ALoCoQmZI1mZ3ixpYn/lGGLdZdhRd1OUPbDW5cO9EofOSVW3EdHTataXYmFVvxkGkWa931XeoARG
X-Received: by 10.194.241.132 with SMTP id wi4mr2549192wjc.14.1394036513138;
 Wed, 05 Mar 2014 08:21:53 -0800 (PST)
Received: by 10.216.122.200 with HTTP; Wed, 5 Mar 2014 08:21:53 -0800 (PST)
X-Originating-IP: [96.52.225.98]
In-Reply-To: <CACsJy8A28x5m1SLV-R=QrFniPXUbV+x9N27GA-j+Ut_oe_6oGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243442>

On Wed, Mar 5, 2014 at 3:01 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 5, 2014 at 12:56 PM, Jeremy Nickurak <jeremy@nickurak.ca> wrote:
>> git log seems to understand globs in the last path argument, and the
>> last path argument only. I didn't see anything in the git log man page
>> expressly saying this was to be expected, but it does seem like it
>> ought to work for all the arguments or none of them.
>
> What version did you use? We have a fix in the same area,
> e4ddb05 (tree_entry_interesting: match against all pathspecs -
> 2014-01-25), and it's in v1.8.5.5 and v1.9.0

So close! :) 1.8.5.3

>> Note that glob matching doesn't seem to occur unless '--' is included.
>
> do you mean "git log" does not run at all and complains about
> disambiguation, or it runs but nothing is filtered?

It complains about disambiguation:

$ mkdir -p ~/tmp; cd ~/tmp; git init; echo hello > hello.txt; git add
hello.txt; git commit -m hello; echo "Without --:"; git log --oneline
'*.txt'; echo "With --:"; git log --oneline -- '*.txt';
Reinitialized existing Git repository in /home/nickuj/tmp/.git/
On branch master
nothing to commit, working directory clean
Without --:
fatal: ambiguous argument '*.txt': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
With --:
78ff378 hello
