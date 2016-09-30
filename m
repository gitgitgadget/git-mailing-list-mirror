Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D919207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 01:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935348AbcI3BBn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 21:01:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36445 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbcI3BBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 21:01:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id h186so1871516oia.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R0V/ze+5J4jcveYS6sm09A4byIJ3cTNfhySwZBcIMS4=;
        b=SZWk2gRmM4hRa4i7MQwpILeKk99m8Fd/I2NMinWkV3Wzz52XfszYNhuJkX2PYdCiO4
         BlfzK7LqKD1xdnxIYDjrpRi54Tx+E7YBHQvNdj05729AaBLSudFBqWtgK2SB/Ug15L4V
         ykIB651TBU7OeNmxdCYAAJWA0IUfH7iNaLqkzC73FNvfljWlEm4hO6H9rTs/OJuryKxR
         lzYGFEUTNE/uhDOCrxSWlf/IFrqDie88moeGK2Leaw6ENQhQ7RuRc15HR3oeeY5t/b42
         NGFBjYojU7zyhRP9bHTm0mniwk0O1vaRHE1rSlchlUoBV/TlW/Y/VbyYNCn5C/O9QYr0
         z7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=R0V/ze+5J4jcveYS6sm09A4byIJ3cTNfhySwZBcIMS4=;
        b=KFCEttr6+qp5WET/maViQggZ96HZuLj00HHMUcCUkNnRRvR5r/ujQJojFQp7r3BaSm
         k37ShWm/CSk5zSu7WtGo2vCpB00CAGz4p3OdWzzID+J/PX08yNnN1PAP6Yx0YNrH/cef
         JTnNsseVSTcnOxMxGgfxLsTlS3MiWalmma3Z83cn5BEJ2F7XNcOodrHGGfb5fxIs4Xlx
         ToMooi5cBGX2UjIb4pcD2meCP5DkrNCxMPNOzF9tSkmziPeuwr5X4iWJgF1gYOWuLkHi
         iPBjiyVBPcsNzLSdyjZaExnF6gHrQNJxGB1/cQbb+p/5cjfPkdWuxEd8uXNjtfJTc/Yn
         LPTA==
X-Gm-Message-State: AA6/9RlWAt4czqYZ5WgWLpbVwfMLPA1+7++aCC4WJSad/yJFtk+f7Ipd/COFbpRAjohqI4Vdi+PQ0MaDEwGHzg==
X-Received: by 10.202.89.66 with SMTP id n63mr4265874oib.90.1475197301271;
 Thu, 29 Sep 2016 18:01:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 18:01:40 -0700 (PDT)
In-Reply-To: <20160930005638.almd66ralshknoxa@glandium.org>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com> <20160930005638.almd66ralshknoxa@glandium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 18:01:40 -0700
X-Google-Sender-Auth: cl6lsbbFU4YAmn1_MnNZBtOYR3E
Message-ID: <CA+55aFzjTB0peMDPoPA6JyeUy90x=Lh4qdfiYLNf6RQU3ey9Hg@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Mike Hommey <mh@glandium.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 5:56 PM, Mike Hommey <mh@glandium.org> wrote:
>
> OTOH, how often does one refer to trees or blobs with abbreviated sha1s?
> Most of the time, you'd use abbreviated sha1s for commits. And the number
> of commits in git and the kernel repositories are much lower than the
> number of overall objects.

See that whole other discussion about this. I agree. If we only ever
worried about just commits, the abbreviation length wouldn't need to
be grown nearly as aggressively. The current default would still be
wrong for the kernel, but it wouldn't be as noticeably wrong, and
updating it to 8 or 9 would be fine.

That said, people argued against that too. We *do* end up having
abbreviated SHA1's for blobs in the diff index. When I said that _I_
neer use it, somebody piped up to say that they do.

So I'd rather just keep the existing semantics (a hash is a hash is a
hash), and just abbreviate at a sufficient point that we don't have to
worry too much about disambiguating further by object type.

      Linus
