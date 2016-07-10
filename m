Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BC51FE4E
	for <e@80x24.org>; Sun, 10 Jul 2016 04:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbcGJEgM (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 00:36:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34298 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcGJEgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 00:36:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id w75so12543599wmd.1
        for <git@vger.kernel.org>; Sat, 09 Jul 2016 21:36:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rp/BRfx5Uwjok+2zvs7i492loh5at6iAQKnM2XbXHWY=;
        b=PlDGaFe86H2W/ecsL5JV83krVUqXQGWJn5N5JF/4aUWJ/KMNnvsxc/Fi6sGoYApXCg
         27YOk4vAAWW1g+kjEqLah9F5Jp/tvbOZ29E6nbm7JbIUVL949m6yXq542yOA0GrTaIa1
         VESemsH5KgHJ4LQ9iyMz1xsWTKJoVzv51D4FFwh+XMd/X4YzZ9QVv6BNRwZdMItC6VZn
         BpDsHg5SGQ0v/92VrxcLH0fcjxEH/b7LRKCEXZHXMl9s45A45ambBqGMXqquBBUu8bVe
         ehVbkam0AyS4h/yOdADnRDSG1ofN/7s6ej4IHnk+H2iDBCXs+P4ZPIVS2Ynf6g5Eg3AE
         iZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rp/BRfx5Uwjok+2zvs7i492loh5at6iAQKnM2XbXHWY=;
        b=A/WBsxBchZbkw+RJ05wNeaOcHS+4KPdjYmlrr50mFEVfdXd75an/d/SrbYfZFfYViz
         9+riP+O3Y72mHL/CWnh4lCqwXLoCHbzjCjLVNeKwkDSZqO+Z4i/xtgOTryFT4bGhvTJ7
         x4MZbd97/9UtWXGqcB+9OgFxERH/mlTsIjUnf+2vFGl9jKhcydU6k+Jn2NKGZfuMzMUP
         MLIdPA8PWYH75Vx0YHK4T6w4lG9kYRCQKXkFhbu49oI/t+YKvUII6txQXE0ftd1F093A
         L0gg8fA/gKJUJ4mGEvrZfwRO2qV3qRmEiuC4zTNxBUUDfgpXUfgFAF7YePZ4v8ui20xG
         V24A==
X-Gm-Message-State: ALyK8tKzOjRhwYEiV6mp2/mWqwVq8d0hHRm8laqpq5PuB7Mf5AbDDdu7qytP4jDjHl/vZ/AQApoVfG65Wd7qXg==
X-Received: by 10.28.104.214 with SMTP id d205mr10530193wmc.102.1468125369193;
 Sat, 09 Jul 2016 21:36:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.210.1 with HTTP; Sat, 9 Jul 2016 21:36:08 -0700 (PDT)
In-Reply-To: <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
 <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com> <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
From:	Orgad Shaneh <orgads@gmail.com>
Date:	Sun, 10 Jul 2016 07:36:08 +0300
Message-ID: <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It's been over 2 months. Can anyone please review and merge it?

Thanks.
- Orgad

On Wed, May 18, 2016 at 9:12 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> ping?
>
> On Thu, May 5, 2016 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pat, we haven't heard from you for a long time.  Are you still
>> around and interested in helping us by maintaining git-gui?
>>
>> Otherwise we may have to start recruiting a volunteer or two to take
>> this over.
>>
>> Thanks.
>>
>> Orgad Shaneh <orgads@gmail.com> writes:
>>
>>> git commit --amend preserves the author details unless --reset-author is
>>> given.
>>>
>>> git-gui discards the author details on amend.
>>>
>>> Fix by reading the author details along with the commit message, and
>>> setting the appropriate environment variables required for preserving
>>> them.
>>>
>>> Reported long ago in the mailing list[1].
>>>
>>> [1] http://article.gmane.org/gmane.comp.version-control.git/243921
>>>
>>> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>>> ---
>>>  git-gui/lib/commit.tcl | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
>>> index 864b687..60edf99 100644
>>> --- a/git-gui/lib/commit.tcl
>>> +++ b/git-gui/lib/commit.tcl
>>> @@ -1,8 +1,13 @@
>>>  # git-gui misc. commit reading/writing support
>>>  # Copyright (C) 2006, 2007 Shawn Pearce
>>>
>>> +set author_name ""
>>> +set author_email ""
>>> +set author_date ""
>>> +
>>>  proc load_last_commit {} {
>>>       global HEAD PARENT MERGE_HEAD commit_type ui_comm
>>> +     global author_name author_email author_date
>>>       global repo_config
>>>
>>>       if {[llength $PARENT] == 0} {
>>> @@ -34,6 +39,10 @@ You are currently in the middle of a merge that has not been fully completed.  Y
>>>                                       lappend parents [string range $line 7 end]
>>>                               } elseif {[string match {encoding *} $line]} {
>>>                                       set enc [string tolower [string range $line 9 end]]
>>> +                             } elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
>>> +                                     set author_name $name
>>> +                                     set author_email $email
>>> +                                     set author_date $time
>>>                               }
>>>                       }
>>>                       set msg [read $fd]
>>> @@ -107,8 +116,12 @@ proc do_signoff {} {
>>>
>>>  proc create_new_commit {} {
>>>       global commit_type ui_comm
>>> +     global author_name author_email author_date
>>>
>>>       set commit_type normal
>>> +     set author_name ""
>>> +     set author_email ""
>>> +     set author_date ""
>>>       $ui_comm delete 0.0 end
>>>       $ui_comm edit reset
>>>       $ui_comm edit modified false
>>> @@ -327,6 +340,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>>>       global ui_comm selected_commit_type
>>>       global file_states selected_paths rescan_active
>>>       global repo_config
>>> +     global env author_name author_email author_date
>>>
>>>       gets $fd_wt tree_id
>>>       if {[catch {close $fd_wt} err]} {
>>> @@ -366,6 +380,11 @@ A rescan will be automatically started now.
>>>               }
>>>       }
>>>
>>> +     if {$author_name ne ""} {
>>> +             set env(GIT_AUTHOR_NAME) $author_name
>>> +             set env(GIT_AUTHOR_EMAIL) $author_email
>>> +             set env(GIT_AUTHOR_DATE) $author_date
>>> +     }
>>>       # -- Create the commit.
>>>       #
>>>       set cmd [list commit-tree $tree_id]
