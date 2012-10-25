From: Joey Jiao <joey.jiaojg@gmail.com>
Subject: Re: Git push slowly under 1000M/s network
Date: Thu, 25 Oct 2012 13:04:32 +0800
Message-ID: <CAKOmCvruvHPmwz1CDbS1pJPgHZXuUP8p-tdeumxLB=ShAdw4Rg@mail.gmail.com>
References: <CAKOmCvp23fALGsDe4Ck7ZXpMJmOAq+YWCXPe_xb6GfQcjJi_kQ@mail.gmail.com>
 <CAJo=hJuGksy7pzzy7-7eTUxNmtT9qR2xCPxSfYO58_8SohFjxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:05:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRFcy-0001j9-EU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab2JYFEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:04:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38466 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab2JYFEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:04:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1724794pbb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qy8ONRLPYVwQXon7ydp7H09NvPzv9KB0A9jkG2kaT/Q=;
        b=LjjRfhB9dG9m2AeSHHk5jGbbR9JneXwKfizy6qMzL2bixoddgi9OWpJVQFJiMSCSkB
         8fSKJvUBRTnqKuaQ9HtNmVCNeUwmHPY1j1AMeLGIr9whg0EpngqLSTWwxkVPU6AavY/l
         z9gbhg0l4M0pYooilGVCQwB3pswY/WHWk0XYGWuscJgssZl6osX69BSDTmarASb592Jy
         0N8KnTtzV03Q+JYyN13QZhgiGRkIazy2F+Czri+2mflLSuIGqmuZ1jB3aifGWTw+C/yN
         Ra1KHNN7Sb+QR7LhHL/jA7AMz0MSgHprnFmC9tqpquJ3luuLa+eMufVVfOXnPQaHxcGR
         qWug==
Received: by 10.68.235.106 with SMTP id ul10mr57078616pbc.83.1351141492152;
 Wed, 24 Oct 2012 22:04:52 -0700 (PDT)
Received: by 10.66.219.166 with HTTP; Wed, 24 Oct 2012 22:04:32 -0700 (PDT)
In-Reply-To: <CAJo=hJuGksy7pzzy7-7eTUxNmtT9qR2xCPxSfYO58_8SohFjxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208340>

Yes, I believe it's gerrit problem and will discuss there.
During first minutes of restarting gerrit, the pushing becomes quite
faster 13s instead.

2012/10/24 Shawn Pearce <spearce@spearce.org>:
> On Mon, Oct 22, 2012 at 11:27 PM, Joey Jiao <joey.jiaojg@gmail.com> wrote:
>> It looks like the client is waiting the pushing result status from
>> server although by checking server side, the real object has already
>> been upload succeed.
>>
>> Below is the log after adding time info.
>> $ time git push -v ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
>> HEAD:refs/changes/33599 2>&1|tee -a log.txt
> ...
>> remote: Resolving deltas:   0% (0/2)
>> remote: (W) afafdad: no files changed, message updated
> ...
>> real    9m56.928s
>> user    0m0.364s
>> sys     0m0.160s
>
> What version of Gerrit are you using?
> How many changes already exist in this project?
>
> I am fairly certain this is an issue with Gerrit. Which may be better
> discussed at http://groups.google.com/group/repo-discuss



-- 
-Joey Jiao
