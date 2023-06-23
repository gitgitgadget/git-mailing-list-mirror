Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD73EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFWSIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjFWSIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 14:08:50 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F82703
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 11:08:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9c1bfc21aso2240381cf.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687543723; x=1690135723;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1z+RNE+ROcf/e97B74HGuKf15PVtZ1dnMsCUVYP8deA=;
        b=g0LdVDq1GUZrdMgJpFH6oFvlWiu2X93BHfjS75j/J0xEVDWztCf3zPrxYf8JMkhNS9
         a13Sz3y9m28ixD409mQiCT3ERtFhPxliakdtKribWhCbw55xNtCERxH1hS56PzqSQFsD
         qZdW3LFhHIKfgo+I1ooEmTzaWnC9vtyuOW791l4GDTh50vGLKgfttw5juPrAdHiXeujs
         DLc/8TUd6yt4pK161E8UL/gEFjZfT6rITATdQ/csxI0g2MZZiyN4/FygC54ucKXyvhK2
         zNDYof1xf7gGsYuvkUd0D9srt25Ju7pze149LxXCIkvk5xyjO9EhhSEOb7s//5Gk05C/
         Tatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543723; x=1690135723;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1z+RNE+ROcf/e97B74HGuKf15PVtZ1dnMsCUVYP8deA=;
        b=Tfrvyd+sg+ixH3WnfF8MkCyguTJY3lrANA0rey98xm0tjxef5oSOmv2ReDdjdhekKa
         jyTri6nqdCvaSG8tBT/D+GdsLR43aNXSfHpJWQdK59v9OHDjJqu0VU47qENJaZCCsPc6
         SWuq15mxblvmbszFNcL3TzSlESeHt4aaIdF+1SrNebEc1JlKcMxEXMJjn5IEzsXB2nOH
         s7uAUzmdwyzR5n5KpMpiocNnDkUaD0rllol2WsQtflPYmn6MHcbHThArW8KNVtUWwr9U
         6nSZUdH2I+sG0EqfLsNZhX1D7F0jt+GAVYeu4wUHNg62eYSOQ4fl1EH1IPNJAvIAVrUA
         /nUw==
X-Gm-Message-State: AC+VfDw5KxYSTdlQnYUEjvew2uz7m19lV/KqmB3IPb4/rhGrxr8BhFry
        NON7j0peiIDysraNR+s+Ti8=
X-Google-Smtp-Source: ACHHUZ56vAWGMpkIThewKLsfyTmmOaTQ4eEIegjxM+f2VfbvNZ5RlyQPHqCKtGV9xUxWox001UFdnQ==
X-Received: by 2002:a05:622a:cd:b0:400:7965:cfe with SMTP id p13-20020a05622a00cd00b0040079650cfemr7522634qtw.4.1687543723476;
        Fri, 23 Jun 2023 11:08:43 -0700 (PDT)
Received: from [192.168.1.239] (ool-4570b665.dyn.optonline.net. [69.112.182.101])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85350000000b003f6b0562ad7sm5083814qto.16.2023.06.23.11.08.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:08:43 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] docs: add git-hash-object -t option's possible values
Date:   Fri, 23 Jun 2023 14:08:42 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <62B7F5FF-F85D-47C0-B553-F57B991D0BCC@gmail.com>
In-Reply-To: <xmqqfs6jccqb.fsf_-_@gitster.g>
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
 <ZJRAsU6LfSwFIdbw@nand.local> <xmqqfs6jccqb.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 22 Jun 2023, at 19:13, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> On Thu, Jun 22, 2023 at 12:46:34AM +0000, John Cai via GitGitGadget wrote:
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> For newer users of Git, the possible values of -t in git-hash-object may
>>> not be apparent. In fact the current verbiage under NAME could
>>> lead one to conclude that git-hash-object(1) can only be used to create
>>> blobs.
>
> While I do not oppose to the patch text that lists four object types
> explicitly, I am not sure if the above is a reasonable justification
> to do so.
>
> I think the phrase "default:" in front of explicit singling out of
> "blob" in the description is sufficient to hint that "blob" is
> merely one of the types it can create.

I think the default does indicate that there are other types, but at least for
myself it created a bit of uncertainty as to what other types the command
accepted. Of course, a quick test on the command line is sufficient to confirm
the support for commit, tree, and tag--but I still think the current verbiage
leaves enough room for ambiguity, even for users of Git who are aware of all the
object types.

> Also why do we expect thatnewer users of Git would be playing with hash-object
> before even learning there are other three types (or only after reading the
> one-line summary without description)?  It almost smells like asking for
> trouble.

I do agree with this reasoning. "newer users of Git" does not sound like the
right phrase to use.

>
> Verbiage refers to uses of too many words or excessively technical
> expressions.  I do not think a single-line summary of the command
> qualifies for one.
>
> So, I like the patch text, but not the way it is sold with its
> proposed log message.

Will re-roll with updated text. Also, based on Taylor's feedback of
git-hash-object vs git hash-object.

>
> Thanks.

thanks!
John
