Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA96C1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 17:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfAaRnu (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 12:43:50 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:39203 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfAaRnu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 12:43:50 -0500
Received: by mail-wm1-f46.google.com with SMTP id y8so3476018wmi.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YK0Vr5ko2VTZwT+Wf1XLBg/vdrDUX7NS8NeXmuToGlY=;
        b=NjKvYs55+kAvWQeY6YNIVHADgJ+gcKIpMSHDNGvm1w6b5ms/NwNA/AMdTZ5o9HSQm8
         s9oDALa2U6Gr7WtAm8zwYMGNHJplHQQOlFzcTe21uXi659PUSJLEHWCJHmBSp24ARsm+
         vEG3JveGR0CnCyETVQxCplcDKawS6y1CXQ4n5+b5UCLigpL7OuVo5/i0q78OVs5yLgb6
         tQRqTr+lfNBh5jyx6O6F14VY7Jk5kW1+GFn95icW69VxaHwEqeh7lyUUiRoF5rxiSJls
         bO26bXM/p72/08NAZ0ZO6EkndePT4MC6Yq6cMfHK1yLEQSgbw/JtUt5VSEuwvlehrPCu
         AOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YK0Vr5ko2VTZwT+Wf1XLBg/vdrDUX7NS8NeXmuToGlY=;
        b=GTTapviAFOpoyx2DtWG0h8TbWI2bsEOinjSjSQf3wmgFZSrPQYV1GJJa0BTC/glJr1
         RJZHy34ypXkGH5FKALDxU9iAvq12sUGRwn9SRRkqhZBa323Dfnqkm0sr86r65s1ajnIG
         KJ8hL8ZsuzgWCsrya+k/CU5BfMJ1xJyewza1bSrlGPD+dNyFVeo/u2EwFQO+IN3GNFBI
         UlwFFyOLPm+YFnvmNzn9RwbEOXgsGK1tqcBXUx3QwsnV2wWMADQ4ISvq8PLq5R22adsX
         hv/DW1WG9flw154+XsS10OMLsdx0hKYjjB4WgbDa/NAdyYdW4mU8hr7lVnmrtkmX8WoX
         TXqw==
X-Gm-Message-State: AJcUukcIh6cyLAetS1bxJ/yAFO6rH9jIebsF5fVvVGNmKSl/Va+8iPt/
        D/f9f/jTSW82bPdWwy/NeyE=
X-Google-Smtp-Source: ALg8bN4dAkHFtaCjqra/10/w0xEEAT7FeMFyGKwY7vFsSvLc6IvMF5TkFGlxpzwmpg9KYZeuxeaFcA==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr32214176wmh.76.1548956628187;
        Thu, 31 Jan 2019 09:43:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v8sm6613969wrq.53.2019.01.31.09.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 09:43:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
        <2fcac3f7-22be-71fa-eee9-9cc630711029@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 09:43:45 -0800
In-Reply-To: <2fcac3f7-22be-71fa-eee9-9cc630711029@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 30 Jan 2019 14:07:00 -0500")
Message-ID: <xmqqftt84t9q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>   A more structured way to obtain execution trace has been added.
>>
>>   Ready?
>
> I'm about to send in a V3 that includes an updated design doc
> and addresses most of the clang-format suggestions.
>
> The CI build reports that my V3 collides with a change
> added yesterday in submodule.c in master.  It was added in
> /sb/submodule-recursive-fetch-gets-the-tip.
>
> I'll rebase onto the tip of master and fix it up.
>
> And if there are no comments on my V3, I think it is ready.

Thanks!
