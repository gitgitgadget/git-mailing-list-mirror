Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB0A1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404613AbeHATF0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 15:05:26 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:54081 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403882AbeHATFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:25 -0400
Received: by mail-it0-f53.google.com with SMTP id 72-v6so10716220itw.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EgGwNwKPkxEItgPs4Px73LH9c/QGjY7g8cSClpEg6kE=;
        b=pdKGpPzSz/GHhuffFvDjFmiIHEYCqOsrUQ9OwtIVRkp/gbUqm0PfSz8CnuYE0eSgMW
         bQ5+fPd/TbUFsDGxYHdV/99fqSfflc14QrqWWPUjyaP7aPttaJdXZAJ/o6XjlPXeMP4D
         ArVauqnD50hKrPMC6s+G4lO/UhF3yvkLsuNqG4Potc6t5eDyN/sHheCUnvif35DpUEfq
         WvdZNfJ3d0UsdthfbDv+Kbto88upTmKd79XpTfWxH84exwYudwdVf6B6BV8nOKAWq761
         ifwhok6Ps1pncuQcKUzdQRJ5dXR5X2rCHZ5SUGH4ymz84x2+BREWcFa9QPJwCfsR7K9d
         mHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EgGwNwKPkxEItgPs4Px73LH9c/QGjY7g8cSClpEg6kE=;
        b=unfQB2Ek8HqvWAFJGJ79CRNSQXwHTIDi3SAqt0LBhSRAI9/CHANDsFf7AfwiH5l67I
         4aZrGAme48b8xM/uLU67/7rWOaF64Kfe+Zt+lX7fCbimGjF+5dPAGMK2uT3c3E5Yh5YK
         8kgdHARSMH7ujgiODH29a70eZKvelk9wMgQZIsZ6L4m0aGujBrqmGymU0WfNanV/n0ni
         HfNz5GzQ0ScfEIRk0cnOMgurxiVRdPJijgkQf+fjeF+ksym30LeLhcJR7SdmX3zZzDtX
         1WYGfssONCkfcEgzsh/Oa+pS9YFK7RvyNuwnsIEUsK3zQm+Q7+i6pTnJOHPWn0/Dy+wy
         vmFw==
X-Gm-Message-State: AOUpUlHBzXPD+fH93gbZANCvkYQ16Z/nEKXPMNkUy2c/p/YiwzUhEso7
        Pp0de6PhkOh0/y5onBkXLbD3xdkThASL/VOHFxtet1l3
X-Google-Smtp-Source: AAOMgpdbXtCvG/VoMS2/lMu/9JLHJBVdMUKTqKqexFTd5aH29sXaOeXUOR2bFpLWS6mZtxTHS8LroTzKYDZGxRhE92o=
X-Received: by 2002:a02:891b:: with SMTP id o27-v6mr26101651jaj.23.1533143924438;
 Wed, 01 Aug 2018 10:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com> <xmqqeffi856n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeffi856n.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 1 Aug 2018 19:18:31 +0200
Message-ID: <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunshine@sunshineco.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 5:41 PM Junio C Hamano <gitster@pobox.com> wrote:

> Hmm, do we actually say things like "Error: blah"?  I am not sure if
> I like this strncasecmp all that much.

this is for the remote end, so what we (git-core) says isn't all that
relevant. The reason I put this here is that Gerrit has some messages
that say "ERROR: .. "

> >> +                       strbuf_addstr(dest, p->color);
> >> +                       strbuf_add(dest, src, len);
> >> +                       strbuf_addstr(dest, GIT_COLOR_RESET);
> >> +                       n -=3D len;
> >> +                       src +=3D len;
> >> +                       break;
> >> +               }
> >
> > So, despite the explanation in the commit message, this function isn't
> > _generally_ highlighting keywords in the sideband. Instead, it is
> > highlighting a keyword only if it finds it at the start of string
> > (ignoring whitespace). Perhaps the commit message could be more clear
> > about that.
>
> Sounds good.
>
> I didn't comment on other parts of your review posed as questions
> (that require some digging and thinking), but I think they are all
> worthwhile thing to think about.

Sorry for being dense, but do you want me to send an updated patch or
not based on your and Eric's comments or not?

thanks,
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
