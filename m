Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C3B1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 14:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeCFOfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 09:35:24 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41807 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbeCFOfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 09:35:23 -0500
Received: by mail-lf0-f41.google.com with SMTP id m69so28800744lfe.8
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uPdoZK1Bc2FB55IJavHaXSBwF75oSkHNcoo3G6Y4Xgo=;
        b=sFBAgNrNdVmYhn0AMrjbTCd/6xyTdI4t+j5t0Dyp0vPzl1mCJKu3UUp83+PBzQoK3i
         25CBl48rdueaQGt6Q5XiqrwOBo9HlAFVQI4eigdrKnI9spqP5meyJP/A+XYeDk0ZMHhv
         F3h4vEV+C44QgtfODkzRcivDSDDNvpNV0flD12MAiJxIQW/tcpTUdnIMXYYcnTEP7oqD
         wlTbZshqzjxXFXrSNDbruJbB005bmbQa64KHZULfLqJQioDGV8uyNyxlMzMWGBMECX+j
         03tJvNWraww1hXCtZx4BF0sGgO6gzy+kaayv3S43Qq8E5NmMxiYzYlnAoYHTAtl9X29y
         Ne5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uPdoZK1Bc2FB55IJavHaXSBwF75oSkHNcoo3G6Y4Xgo=;
        b=qqkNFieXeQ+6rWDIJHqH2tHFUPlGx2a8YpMsjBX32ysb6M//siVg5Bsl8zRs5po2Ch
         xKUHmf2yAN9E03mqbzU/7c370Ad+JXtp+aV3qmM7/vUvLpt5Ow6OyEhhP0KSAftwXhf6
         2pdM2fA0DcXSsTcoYHD3g56JhIwEyxXPed2YbfRdduefch3O80P73Andyx/odQIBwwUs
         LlyRaBixnhuhMczL8VZOHGK4aONcl84MNVT8jzu+XQsBLDy9yKMuisBWitcLr7bLdZOw
         8rqs1OMMqyrFExrC1JlfAtavKnEgGtTBWtTSRuECo6HM9ejxylgBpT3CDLMhY5oHqEcl
         Q48A==
X-Gm-Message-State: AElRT7E2L6ugcJ57/+IpGX1Gtju8PiKsX9zqiAegNulNIhBhS1CgNYmq
        gwZdvzRtY4V4bGMX193pj89IdGOboxSJcWOdc1w=
X-Google-Smtp-Source: AG47ELsO04fjSZhb8qf28sH1268gSLrmst9Z9QtKBp02Avnti8hkpHW96qpf3YMqQaPtvEDBFV6RlNZFhIEnHgLJKJo=
X-Received: by 10.46.77.197 with SMTP id c66mr13712497ljd.116.1520346922270;
 Tue, 06 Mar 2018 06:35:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.80.67 with HTTP; Tue, 6 Mar 2018 06:35:21 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1803051749060.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com>
 <20180228121052.10642-1-birgersp@gmail.com> <nycvar.QRO.7.76.6.1803051749060.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Tue, 6 Mar 2018 15:35:21 +0100
X-Google-Sender-Auth: Y5qUG0W0hbBeFtkGvsu62jyMhVo
Message-ID: <CAGr--=+cAbd=8NDu5M8dbeWn=uoevhJjSvN+bgfDPWjA=V0KnQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to change focus between ui widgets
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback.

On Mon, Mar 5, 2018 at 5:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Do you think there is a way to focus on the last-selected path? That would
> make this feature even more convenient, I think.

Yes, good idea. I'll implement it and create a second version.

> I am not sure that this information is still there if switching back from
> another component...

I don't think so. But I can add a variable to hold the last selected
(clicked) path for both widgets.

Thanks (again),
Birger

On Mon, Mar 5, 2018 at 5:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Birger,
>
> On Wed, 28 Feb 2018, Birger Skogeng Pedersen wrote:
>
>> The user cannot change focus between the list of files, the diff view
>> and the commit message widgets without using the mouse (clicking either of
>> the four widgets ).
>>
>> Hotkeys CTRL/CMD+number (1-4) now focuses the first file of either the
>> "Unstaged Changes" or "Staged Changes", the diff view or the
>> commit message dialog widgets, respectively. This enables the user to
>> select/unselect files, view the diff and create a commit in git-gui
>> using keyboard-only.
>
> I like this!
>
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 91c00e648..f96c0a6b8 100755
>>
>> (This is my first patch ever, any feedback is highly appreciated)
>
> I am not an expert in Tcl/Tk, but I'll do my best to comment on this
> patch.
>
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -2664,6 +2664,38 @@ proc show_less_context {} {
>>       }
>>  }
>>
>> +proc select_first_path {w} {
>> +     global file_lists last_clicked selected_paths
>> +     if {[llength $file_lists($w)] > 0} {
>> +             focus $w
>> +             set last_clicked [list $w 1]
>> +             set path [lindex $file_lists($w) 0]
>> +             array unset selected_paths
>> +             set selected_paths($path) 1
>> +             show_diff $path $w
>> +     }
>> +}
>
> Do you think there is a way to focus on the last-selected path? That would
> make this feature even more convenient, I think.
>
> I am not sure that this information is still there if switching back from
> another component...
>
>> +proc select_first_unstaged_changes_path {} {
>> +     global ui_workdir
>> +     select_first_path $ui_workdir
>> +}
>> +
>> +proc select_first_staged_changes_path {} {
>> +     global ui_index
>> +     select_first_path $ui_index
>> +}
>> +
>> +proc focus_diff {} {
>> +     global ui_diff
>> +     focus $ui_diff
>> +}
>> +
>> +proc focus_commit_message {} {
>> +     global ui_comm
>> +     focus $ui_comm
>> +}
>> +
>>  ######################################################################
>>  ##
>>  ## ui construction
>> @@ -3876,6 +3908,11 @@ foreach i [list $ui_index $ui_workdir] {
>>  }
>>  unset i
>>
>> +bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
>> +bind . <$M1B-Key-2> {select_first_staged_changes_path}
>> +bind . <$M1B-Key-3> {focus_diff}
>> +bind . <$M1B-Key-4> {focus_commit_message}
>> +
>>  set file_lists($ui_index) [list]
>>  set file_lists($ui_workdir) [list]
>
> Looks good!
>
> We are currently without an active Git GUI maintainer, so I hope that
> Junio (the Git maintainer) will pick this up.
>
> Ciao,
> Johannes
