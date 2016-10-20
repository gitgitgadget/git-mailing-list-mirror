Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2451F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 17:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbcJTRFk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:05:40 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33743 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbcJTRFj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:05:39 -0400
Received: by mail-qk0-f179.google.com with SMTP id n189so106080002qke.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=arD7jHGS7yh1HgVEeLtXfy8Jgmc/F5Y7stL+/xLBW68=;
        b=LlZtwdTKK0Gis0dJ/MbfNKNDdydEVxWFon2WuwWmDTf81zOyQAPQSLuxvj5veHo2gY
         s2OV/VnfkiIqMPmWbGpaGKuneUD+C6mKGN3RZ4864dtaCfxZJ1CoEuzMtyL3c6788I3B
         OnPn2x5dz2MOn8HRCa/4kd2fkcvQBeaKd2N1AHwPDe64aS3SA1nsYk88vY7FV/nlihMl
         kUrwFQku5tC2oE7pquF3IfCCYHIU0/JzdqzRQ1vZ02RVrCreHWEzPfwSBEgduN0Urrtv
         7qTGE0ye4sdyIpH0lbuTkn9FPNhzof2hmDJ1kSyf1WjixFZ2hwQ+9SH2GuS/tQvaay/D
         Z+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=arD7jHGS7yh1HgVEeLtXfy8Jgmc/F5Y7stL+/xLBW68=;
        b=Z6AiExYWzPgLKstfsXjq6iUPXX1xlUQ2dLF24LF8x/Kga0BOKKwu8jiU93F55ePv/z
         KkRgyJsCp51QrER6gA3WfOPo3WcmUb1hNytS5QynNubCnzFRPvOgMXawLKin24myUyJn
         y58af9I2Owqcs3kT0ncpTiUoCR/BB+2XZITa0PzSZGJHAFvKri7W8pGORns983UPNNDO
         vOR5uOZsb+nfF5y0pXhBRUDNDY6jjCj7r53YFQoDeV0CoPxNBWi/OMZra1oZDy3I2QOH
         /gB/tsa+dfj12O4irDlVqzLxa5vbvrFWAGQDiWeziHL05uX7kmQYK3TnwOJ3l6PhFZF4
         i26Q==
X-Gm-Message-State: ABUngvdy9pHRKOOIvuAu65EqahIf1jldQPNZ1dS6+05BoN/+K1MqzKoMuqRgSk5YiPMiSi8HpXaFtPFxJoSysber
X-Received: by 10.55.22.105 with SMTP id g102mr1366888qkh.86.1476983138523;
 Thu, 20 Oct 2016 10:05:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 10:05:38 -0700 (PDT)
In-Reply-To: <580893d5a4736_4ed37b53181837@ss1435.mail>
References: <580893d5a4736_4ed37b53181837@ss1435.mail>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 10:05:38 -0700
Message-ID: <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for git
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure what triggered the new finding of coverity as seen below as the
parse_commit() was not touched. Junios series regarding the merge base
optimization touches a bit of code nearby though.

Do we want to replace the unchecked places of parse_commit with
parse_commit_or_die ?

Thanks,
Stefan
_________________________________________________________
*** CID 1374088:  Error handling issues  (CHECKED_RETURN)
/commit.c: 913 in mark_redundant()
907
908             work = xcalloc(cnt, sizeof(*work));
909             redundant = xcalloc(cnt, 1);
910             ALLOC_ARRAY(filled_index, cnt - 1);
911
912             for (i = 0; i < cnt; i++)
>>>     CID 1374088:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "parse_commit" without checking return value (as is done elsewhere 37 out of 45 times).
913                     parse_commit(array[i]);
914             for (i = 0; i < cnt; i++) {
915                     struct commit_list *common;
916
917                     if (redundant[i])
918                             continue;
