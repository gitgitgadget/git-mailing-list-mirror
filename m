From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record
 base tree info
Date: Tue, 26 Apr 2016 11:43:15 -0700
Message-ID: <CAGZ79kZNV+g3_Rmpynh-WQVc3dW6nuNDsTM=gTxNuJnr3V3Azg@mail.gmail.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
	<xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:43:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7xE-0003XD-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbcDZSnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:43:19 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33342 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbcDZSnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:43:16 -0400
Received: by mail-io0-f176.google.com with SMTP id f89so24848614ioi.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cTW8ejh2UsIeSowRVAnqNSPTZH5SS4VgnL2Jn/KQh+M=;
        b=bHi/jOwBvq0Cgjotk84k/kZdWLodQrOeFfyZwlyBV8YzoHMOuzkPDZRx5RbZTaRPu3
         06tTaZsD5xOeSVyJbXweWY/lb3S0znuzB3iXqOQP9S8HxUXWHR2Ar8SnPM77H4mOPgcX
         Dr8xRlvvpX14t20fbOgjl2nSvzSLG6J1dlMtFdIWUOBkiMTRff07+l7gIYzT9IcbwqoU
         old+kdNAyzfxv7vBh1SUPIqAEEqZVeFSufwxeZqc301WtcO5yauFWt3u288Ccln5xRuQ
         b8qCS789WGLALDSo9Rez5LiIwu+gcRshZOMck8kVXdd4fdihljrOUYzlxwCQnDEdFo8n
         I8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cTW8ejh2UsIeSowRVAnqNSPTZH5SS4VgnL2Jn/KQh+M=;
        b=GjBzdW19IPbmmTQBiHY5PftIThhJ/4J1i160CX3ipHO4y6LvGzsNo+WBZ+Ps3Ul3kE
         PamHj1kLxJiDAfeZVzaONddHyeXu2DaNV5YInIsylsbmbCHBRVU4R2yCLpAv3IIHC9uH
         06K0jx2BE5JNaMgWvSgMXCf2NmfCEh1NL3Xz0AZZFwzW3Tjo8S1j1RuM79OI/Cf9oMA3
         GW631yjEhyhyslUMt4i/cjEzWb7y3vBY56jXaITQcjhxgarHWFOtrW8a9XbufYg+d/yi
         xT+bxFCPVHSqCit8VOwAkJY2C7DB5VYTUd4P0jl65O7BhNRrHKrui8+oLVg0mx4o3TeD
         kCBg==
X-Gm-Message-State: AOPr4FWY9wtbtr12/JIBeSIMxwyRAeSF0TaGAHeAN4+TM1JDS5IbTJ/Ha14ar4Uxdvr337wjkSooqwkLsnqPOjUC
X-Received: by 10.107.53.200 with SMTP id k69mr5239368ioo.174.1461696195459;
 Tue, 26 Apr 2016 11:43:15 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 11:43:15 -0700 (PDT)
In-Reply-To: <xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292645>

On Tue, Apr 26, 2016 at 11:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I can totally do that for longer series which require some back and forth.
>>
>> But one-offs, such as typo fixes or other small things[1], for which I do
>> even have a local branch (i.e. checkout origin/master && fix &&
>> commit && send-email) this is another step that potentially bothers me.
>
> So from where are you proposing Git to grab that information if you
> do not tell it?  "If the HEAD is detached, assume that the base is
> where it was detached from" or something?

That would also work for me. In my first mail I was proposing to take
the information from the format-patch argument, such that a one off fix
would be:

    (1) git checkout origin/master
    (2) EDIT
    (3) git commit -a -m "fix"
    (4) git format-patch origin/master..  # <- This is the information.

However you read it as taking the information from the first line,
which is also fine with me, as then the (4) can become

    (4a) git format-patch HEAD^

Another thought:

  Most workflows do not have different remotes per branch, e.g.
  when `master` maps to  `origin/master` as its upstream it is likely that
  `topic-foo` maps to its equivalent at `origin/..` as well.

  Branches come and go in a topic based workflow, so configuring them
  for each new branch is cumbersome, so let's have a default `remote` for
  repository.

If we have a default remote per repository, the base finding algorithm
in format-patch could check if the base(s) of the patch series is a head
in one of the default remote branches, i.e. check all origin/* branches for
a match?


>
>> From a UI perspective it seems logical to also check if the base
>> can be obtained from the patch range specifier.
>
> If you are doing "format-patch master..my-branch", what do you
> propose to set your base to?  master@{u}, perhaps?

Yes. (I usually use that command with |s|master|origin/master|, so the
argument is the upstream already. A local master branch does not exist for me.)

>
