Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431E6207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbcIZUG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:06:57 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36373 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbcIZUG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:06:56 -0400
Received: by mail-lf0-f47.google.com with SMTP id g62so155851735lfe.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nRd0mMCygZBr/gKyj1dA/hJWVvnWmw5JH/hhaun/Q/k=;
        b=C9StGGTj8HQUhH5dF0RfcXm+W2doweqPzdg6dUYqEU0bYxjnaBENaTHzmZuprCor9Z
         jorxbdknWVQ25OSYMPO8siU4940x79t6iqCyFNv5N4r4eS/fdw4QFXyqQsn7z9m4FX2W
         pMt71dZwZQslvttzpWPQsjdL/HGWVEIw3HgbxvdAgxb0WbHPxwWKchAla1jN5wgiq/HU
         mtIrWz9ohohvgQvdt8xgKuvBQ8dwa4utmdW9N7cS3nmLDwSSLfheRoAv8YJZknQPh8hV
         rQY5foBxIZDIo7F3McpMEYQWU9aP4c2qLDi8Fblt+hJ9vRWXecEASeB84iX3xDXoFOrZ
         7Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nRd0mMCygZBr/gKyj1dA/hJWVvnWmw5JH/hhaun/Q/k=;
        b=ZBCJZHmlZEEdVhEBwqssglMGWLQ8tngvVAj+HiPsrDxUhbocq406mGdHxBEPrA0uUT
         Xm0YXxIRgxqlfyjFBPJexqAtVKKGXnBBuZMAGWWZBCbWgiFX/x961k97fOWI81IQBG0h
         gMjw09LWJSkyg/43/A28suBe9R5Ltbnqa4NSW8N6h6TxrekHEswYyu3DWTNg4C415KIt
         fLIacdWN+Vlvl65OQzHBhd32tWbx654fCKbsGKM7G8C6qapSdu6Ttt6jFSz67l3HHgqz
         qzey4tDVUKrMhCDmYcdA5ao8PLz+RadRaSceVrocb1tUVTODWKbarKvoShLeQXqLY8bX
         7m/w==
X-Gm-Message-State: AA6/9Rl6KAn0rEtOpln9kAmL8piobbXk815y3q645WJnnum0dsfJCTU5GnQk3VT2xl3vzOMUVpVISWdulEn72w==
X-Received: by 10.28.154.142 with SMTP id c136mr17311876wme.102.1474920413563;
 Mon, 26 Sep 2016 13:06:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.148.198 with HTTP; Mon, 26 Sep 2016 13:06:53 -0700 (PDT)
In-Reply-To: <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
 <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com> <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
 <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 26 Sep 2016 23:06:53 +0300
Message-ID: <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4.5 months and counting... :(

- Orgad

On Sun, Jul 10, 2016 at 7:36 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> It's been over 2 months. Can anyone please review and merge it?
>
> Thanks.
> - Orgad
>
> On Wed, May 18, 2016 at 9:12 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>> ping?
>>
>> On Thu, May 5, 2016 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Pat, we haven't heard from you for a long time.  Are you still
>>> around and interested in helping us by maintaining git-gui?
>>>
>>> Otherwise we may have to start recruiting a volunteer or two to take
>>> this over.
>>>
>>> Thanks.
>>>
>>> Orgad Shaneh <orgads@gmail.com> writes:
>>>
>>>> git commit --amend preserves the author details unless --reset-author is
>>>> given.
>>>>
>>>> git-gui discards the author details on amend.
>>>>
>>>> Fix by reading the author details along with the commit message, and
>>>> setting the appropriate environment variables required for preserving
>>>> them.
>>>>
>>>> Reported long ago in the mailing list[1].
>>>>
>>>> [1] http://article.gmane.org/gmane.comp.version-control.git/243921
>>>>
>>>> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>>>> ---
>>>>  git-gui/lib/commit.tcl | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
>>>> index 864b687..60edf99 100644
>>>> --- a/git-gui/lib/commit.tcl
>>>> +++ b/git-gui/lib/commit.tcl
>>>> @@ -1,8 +1,13 @@
>>>>  # git-gui misc. commit reading/writing support
>>>>  # Copyright (C) 2006, 2007 Shawn Pearce
>>>>
>>>> +set author_name ""
>>>> +set author_email ""
>>>> +set author_date ""
>>>> +
>>>>  proc load_last_commit {} {
>>>>       global HEAD PARENT MERGE_HEAD commit_type ui_comm
>>>> +     global author_name author_email author_date
>>>>       global repo_config
>>>>
>>>>       if {[llength $PARENT] == 0} {
>>>> @@ -34,6 +39,10 @@ You are currently in the middle of a merge that has not been fully completed.  Y
>>>>                                       lappend parents [string range $line 7 end]
>>>>                               } elseif {[string match {encoding *} $line]} {
>>>>                                       set enc [string tolower [string range $line 9 end]]
>>>> +                             } elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
>>>> +                                     set author_name $name
>>>> +                                     set author_email $email
>>>> +                                     set author_date $time
>>>>                               }
>>>>                       }
>>>>                       set msg [read $fd]
>>>> @@ -107,8 +116,12 @@ proc do_signoff {} {
>>>>
>>>>  proc create_new_commit {} {
>>>>       global commit_type ui_comm
>>>> +     global author_name author_email author_date
>>>>
>>>>       set commit_type normal
>>>> +     set author_name ""
>>>> +     set author_email ""
>>>> +     set author_date ""
>>>>       $ui_comm delete 0.0 end
>>>>       $ui_comm edit reset
>>>>       $ui_comm edit modified false
>>>> @@ -327,6 +340,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>>>>       global ui_comm selected_commit_type
>>>>       global file_states selected_paths rescan_active
>>>>       global repo_config
>>>> +     global env author_name author_email author_date
>>>>
>>>>       gets $fd_wt tree_id
>>>>       if {[catch {close $fd_wt} err]} {
>>>> @@ -366,6 +380,11 @@ A rescan will be automatically started now.
>>>>               }
>>>>       }
>>>>
>>>> +     if {$author_name ne ""} {
>>>> +             set env(GIT_AUTHOR_NAME) $author_name
>>>> +             set env(GIT_AUTHOR_EMAIL) $author_email
>>>> +             set env(GIT_AUTHOR_DATE) $author_date
>>>> +     }
>>>>       # -- Create the commit.
>>>>       #
>>>>       set cmd [list commit-tree $tree_id]
