Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05ED61FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 06:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbdBHGkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:40:09 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34454 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbdBHGkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:40:08 -0500
Received: by mail-oi0-f43.google.com with SMTP id s203so76897890oie.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QvXB+cM7ojH6xF0XZhbHkCZCUa1l8m6TZs21VWUav7o=;
        b=iZUq6AsdOrzV024a+PyEeQJlychLyMWowRttN0xHKUlUXo1Qn/S/dm6Bngnvzy/O+5
         BteEpMUAD1IjCbdW4LfcE2uCuZZq6M9WLBzquk0ZU2MO3AYa0lD5TVTItG1y7OboNxGx
         Fq2FdY/MBje9cHAP8r3kXI7iHwbSAro2kL43ZdflUqrtaFb/ELvx669dIU2xSUgYPFRp
         TF0FXPqY35jBekioPO/VjyBwQWEKdCnWOIUR3aUIY7mkUzCxol37nVYn/QO2+QdrkAcK
         FjV6Pmo+KCznLIOVhdUH6GGq3XXZOClCnD2ekr18jRvHWw9n/S/QTARsg4GRY38y12Qq
         GAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QvXB+cM7ojH6xF0XZhbHkCZCUa1l8m6TZs21VWUav7o=;
        b=AlDQXXl+M8O3Jm4pgiLr4REwt514KDCgFz7YlTxprfIKuzV+q8OCFj247nxg0jbZ4P
         Aw48RKpNhdkgM29Eudmv4dCxsNx8qBw0oH58u7vLOJEPDlXhrS5z1SC7wPKwkNuK91fN
         gS+t3fFlvQwmlP/trcJ2r8Q4JfHN6fkOTTiW5hC6Aj2afgPv8eZtPtzCCDlogeoO3lsa
         PDEboL0D4lDfuUN7h0DpNYBloAZR9SPkvj90k/FilwWO7Ts4FZpZX5A9oHuZCeDz9CrN
         0zPp6fz81tRrl4WjKONOSSSzuI1ggtFOabvUOem/6VvpQMQi8fNHdccxeAHpIChWMlwg
         4v2g==
X-Gm-Message-State: AMke39nrsrA8B6MOzsnii8LLW6R9zY/1x+kfcPQ3389/oxvxB0bPZIys/m5z2wui4ygovfmuvIJSd0o57JfO4A==
X-Received: by 10.202.182.7 with SMTP id g7mr9926008oif.175.1486535978699;
 Tue, 07 Feb 2017 22:39:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 22:39:08 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1702072112160.25002@i7.lan>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan> <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
 <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com> <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
 <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1702072112160.25002@i7.lan>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 13:39:08 +0700
Message-ID: <CACsJy8AQmg+oRYATU8_gR6zY-=sPN3m9PKtk-kytkSKGK+GG1g@mail.gmail.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 12:12 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Two-patch series to follow.

glossary-content.txt update for both patches would be nice.
-- 
Duy
