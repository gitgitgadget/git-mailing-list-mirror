Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411FD1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 23:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbcH2Xes (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 19:34:48 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36176 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbcH2Xes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 19:34:48 -0400
Received: by mail-oi0-f47.google.com with SMTP id f189so4044564oig.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 16:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6fisyLHYNstm7opzh9DRPfoWCiH9R6Cv8n69b4D/wqI=;
        b=gVqpePVQ1G628nlSipHx1NmtVEkSBOaITlFrkwwFs83Qxw6/uv8m94UBoFMwpTPBVg
         iwGTuLDnttYWUNFgg4a66kO886hzpBCct3advnpODC4GQZYVgFfS1Klphg5gakY4Rzqg
         0aksAoiD92GULZwJjQuISURaOD+HQaaOzts/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6fisyLHYNstm7opzh9DRPfoWCiH9R6Cv8n69b4D/wqI=;
        b=iAyibO6Ogq1Tq6FQUepWSI/KpXKd2ydXukkzDNyMGrkOzaAuJOx5e4Yc3IZcTkIDIg
         ldjYf9GQrQd8ENowS9ppoFO3KAYnmfjtorhqopNQWE1pEPMRk9XkqIoVx1sErKy9+wMh
         hISnGude2IzpE3n+nGkR0iVmsoLe6pmosh+qTKOQ9yqfxnsotFA7ZMXM5V53Jeu/rJGk
         3qEJ3RvfrEjppKj/b/8q4M663YmOMqrKAdCdbE6GaaHSV8nHDUV5jbSyI3xmRx2rWw3r
         Z4KGp85knr4sab4PiUquuRKhhwyPIT6xZX25om6zv6lSdlTKrRtbIP2hu0k8axYR2oC6
         bMhw==
X-Gm-Message-State: AE9vXwPZd3jzU9QdkYuYukhzdMWMp3bpdolGJwqDbX2x8cLtwFtdWs7Bp7tOd+PhD4thDhO6Tw0iJITSvePMPLT5
X-Received: by 10.157.55.183 with SMTP id x52mr617664otb.68.1472513681125;
 Mon, 29 Aug 2016 16:34:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Mon, 29 Aug 2016 16:34:40 -0700 (PDT)
In-Reply-To: <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com> <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Mon, 29 Aug 2016 16:34:40 -0700
Message-ID: <CAN5XQfsKNc7t5gEXpXY2uP9-2fZ3CwkS50JXp=AFSZLRrjFP-g@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, is_git_directory() is much better. Thanks for the pointer.

I will submit a patch unless I hear more suggestions from others.

Uma



On Mon, Aug 29, 2016 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Uma Srinivasan <usrinivasan@twitter.com> writes:
>
>> On Mon, Aug 29, 2016 at 2:13 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
>>> Ok that makes sense. Thanks much.
>>>
>>> Uma
>>>
>> With respect to my original problem with a corrupted .git directory
>> under the submodule directory, I am thinking of adding the following 4
>> lines marked with ### to is_submodule_modified() to detect the
>> corrupted dir and die quickly instead of forking several child
>> processes:
>>
>>                strbuf_addf(&buf, "%s/.git", path);
>>                git_dir = read_gitfile(buf.buf);
>>                if (!git_dir) {
>>                  ### strbuf_addf(&head_ref, "%s/HEAD",buf.buf);
>>                  ### if (strbuf_read_file(&temp_ref, head_ref.buf,0) < 0) {
>>                           ### die("Corrupted .git dir in submodule %s", path);
>>                  ###}
>>                          git_dir = buf.buf;
>>               }
>>
>> This fixes my issue but what do you think? Is this the right way to
>> fix it? Is there a better way?
>
> I think we already have a helper function that does a lot better
> than "does it have a file called HEAD" to ask "is this a git
> directory?" and its name I think is "is_git_directory" (I know, we
> are not imaginative when naming our functions).
>
> As to the check makes sense in the context of this function, I am
> not an expert to judge.  I'd expect Jens, Heiko and/or Stefan to
> know better than I do.
