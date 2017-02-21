Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45A3201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbdBUX7y (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:59:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33733 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbdBUX7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:59:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so20575867pgj.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xRIkhPuGF3ujJ4Y6w1cWQvHdqP3ukDMf82c9QBSWROc=;
        b=PpyRDoyh0fLnHoMor7RFEXnDiXbPKdnKGoQt6rFcz8T46JTRXlX8S3W3dUij4hZgoM
         7XEnlNASIu0zfnDyU7H0TwxQ62eXsZrciAs5ygAOVs1lFd1xcXjcSB6i4zYji+Zk/AW2
         xKJFQDYTPK5gIGkVYLBknsfYZyLtdeShO9T3iad3AxRD//jjFrWd25FEidK9AHQrZgIZ
         G+pE9P77Ad7zyXZU3AQfmEUBJjDgdjRmstcSben5Mb30rIvYppmozkXdz594oQN/iQ7C
         YM7HwfP8Jd6eluviN5E7zGXTaV/yY40pFVoM9jmesws35Oq1doIS0Qh53R9c0sbIBZ9N
         yL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xRIkhPuGF3ujJ4Y6w1cWQvHdqP3ukDMf82c9QBSWROc=;
        b=PTqD3mB4cOZwR+KI0UMW3G//JoOuQyZCH/auqpuOZ3X23WjOWX5T6UWLSmmwMH3J1X
         Wa9pfyc9DX4sHw21uK9A5RVbGs83knluXBKbb+krrCE5o0dz8uzERPW7gsCW6Uj2kp1j
         Luf+bVKqcy0qVBeeGJi9n6eGMqztWO5PR4OH2Y1mO8wt5zkdkTLqxsa+XZaBO6ws8U70
         g5NUjEetr4++Qe0Bp/vnsAFfTjQ9FGCTLtyMrDtb0bONPkd4Ilx9doJnho0UkAIGdl9q
         UkUW9NEQdf0AJv6h5Oba1z7d2BYUsszA3A7rrGIOdo0KS8E/R1c2XjysnHQKGkwar2Ng
         JFrg==
X-Gm-Message-State: AMke39kgQkIlbUzdMMxu3VM+lM0ejeRc+yti63cMDEnlP3r6MTO1hjv/MrwmCjm5Q+nI1g==
X-Received: by 10.99.215.5 with SMTP id d5mr38905505pgg.51.1487721591846;
        Tue, 21 Feb 2017 15:59:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id f3sm43211739pga.34.2017.02.21.15.59.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 15:59:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Toolforger <toolforger@durchholz.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
        <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
        <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
        <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
        <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
        <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
        <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
        <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
        <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
        <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 21 Feb 2017 15:59:50 -0800
In-Reply-To: <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 21 Feb 2017 15:37:37 -0800")
Message-ID: <xmqqk28jdrih.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So I would think it is entirely reasonable if "git submodule init
> sub" that is run in the superproject to initialize "sub" writes
> something in "sub/.git" to tell that "sub" is used in the context of
> that particular toplevel superproject and customize its behavour
> accordingly.  Perhaps it may want to add the url.*.insteadOf that is
> useful for updating the submodule repository when it does "submodule
> init", for example.

Of course, "copying" is usually not very desirable, as it invites
one of the copies to go stale.  An actual implementation may just
say "the name of submodule the superproject uses this as is 'foo'".

That way, if such a configuration exists, Git can first do cd-up to
the root of the working tree, go one level up, verify that it is in
a worktree of its superproject, verify that the root of the working
tree it came from was indeed bound to the submodule called 'foo' and
then do the selective/filtered "config-include" Peff outlined.  That
would allow superproject to move submodules around (as opposed to
recording "this submodule is used at this/path of the superproject"
or "the superproject of this submodule is at ../../that/path"), and
does not penalize repositories that are not used as submodules of
any superproject (because the "cd-up, up, verify and include" won't
be done for them).  As opposed to "I am used as a submodule" bit,
recording the name the superproject uses to call the submodule would
also serve as a sanity check measure.

