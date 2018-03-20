Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7771F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCTWuN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:50:13 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:41834 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbeCTWuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:50:12 -0400
Received: by mail-qt0-f174.google.com with SMTP id j4so3453942qth.8
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Hx0DgsyttGkZ+PGWzSVdmGor1YQgrsHx1mPRZ+I6UEg=;
        b=leQtTOY7iwnAC/GlJHR7ZtXXYRamxK+Je8CuhyU2nUeHb5ALcuv8Kj6vqgsV+fn0mM
         T9x+lBDlNzTcj6NFMP9Jn+XKc1fUDVrYtzryBRtWfDAt4bZTZ8hGxDJTUfo0zk22Djc5
         6PMu3ePniud8rn6fsECB5fV22I7JZRQw8vUuj1W/kANkfxF92/H1V3VSHR2Krl8znLOU
         R3kDTje0l7VfnYOJz4P3eJMRoCLkqer1NtV7hWAyWXAXO6b3VssKyPokiHK6SeK9cJHQ
         nj7blx9COMoGe782EBZgdE8OQk8b6ue/6LcpsjPCwPiG7JWlLDgmeC8PbZ4Gv8N9YlW2
         SQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Hx0DgsyttGkZ+PGWzSVdmGor1YQgrsHx1mPRZ+I6UEg=;
        b=IF5gsip8lPvy/Vy8sFT7FbQJpB46FdBDkiOyWAxk/85HtDAmcOiSzC5e0C/kEohW1j
         Wb5QKAaTIGAsIUXfzEQJhIgsoh4Klt69s9tnbtBrZkkqYrnYLyBKlLLl6whe8rJf9C1i
         AAZi4/sheGUX2YvHZGK83s2byUrJDO6pgvObIeJ8AAiHgPwUW0Krt+eJ26vnU84cVqW0
         sb++XyidnP9FzvsFZ4XWbJICiBPNfrPRDrzYKX92bHahxReyD0nS8g2IctBGW0eBYKX7
         TAv97StvMAbQmozGp2rqqcpQCz4mUw8zt1pv4XXOdw5I++z7K0ZMxLnB+vLME7cPJ0fL
         CAoA==
X-Gm-Message-State: AElRT7Ghwm4VjnXdPnab9apuCqxmAfu0ycfWS+c7Jwg1dkqSAu1dQN1Y
        I253dncBWWHRXr2iP53prz0M7l94WX82nVAqEYs=
X-Google-Smtp-Source: AG47ELtnOKJ/EPcwhhWHG7tJSDZmBik19EvB5Tg6MNU6NzrtMQprbOL1XQPLdbUY+23MjQbGLGQ+Omau4Q9nzzFiEJE=
X-Received: by 10.237.56.136 with SMTP id k8mr27910074qte.154.1521586211831;
 Tue, 20 Mar 2018 15:50:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 15:50:11 -0700 (PDT)
In-Reply-To: <xmqqh8paqt0f.fsf@gitster-ct.c.googlers.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
 <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
 <CAPig+cSxGgG=1k95j+n4DZHBdtN++7F6_U5fu0gOcjwwPQ5GZw@mail.gmail.com> <xmqqh8paqt0f.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 18:50:11 -0400
X-Google-Sender-Auth: YBG1n_vhpPwL_vqt4W3xQ2Miupc
Message-ID: <CAPig+cQ0cq9-cYuw8AJpk6maeT-T25SJDhWpb4TyN8rQJmP=xg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] ref-filter: get_ref_atom_value() error handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 6:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>>     int ret = 0;
>>     void *buf = get_obj(oid, obj, &size, &eaten);
>>     if (!buf)
>>         ret = strbuf_error(_("missing object %s for %s"),
>>             oid_to_hex(oid), ref->refname);
>>     else if (!*obj)
>>         ret = strbuf_error(_("parse_object_buffer failed on %s for %s"),
>>             oid_to_hex(oid), ref->refname);
>>     else
>>         grab_values(ref->value, deref, *obj, buf, size);
>>    if (!eaten)
>>         free(buf);
>>     return ret;
>
> I have no idea what strbuf_error() that does not take any strbuf is
> doing,...

strbuf_error() was a possibility proposed in [1], and it does take a
strbuf. Failure to pass in a strbuf here is just a typo.

> ... but I think you can initialize ret to -1 (i.e. assume the
> worst at the beginning), and then make the "ok, we didn't get any
> errors" case do
>
>         else {
>                 grab_values(...);
>                 ret = 0;
>         }

Yes, that also works.

[1]: https://public-inbox.org/git/CAPig+cT5jh0y9Rmw0E6ns0k5mSwaxAqdaN8oWCayCE8V+jYZow@mail.gmail.com/
