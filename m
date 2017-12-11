Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088171F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdLKX6v (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:58:51 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38616 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKX6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:58:51 -0500
Received: by mail-qt0-f196.google.com with SMTP id d4so43200537qtj.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4fNDE/75PqRtj3PckNQVcUA82SSR8smSc3hj4cv/hCo=;
        b=u+PvtPjtSZUmJo60nM9OMz8h7uuSlUbjH6ZkWg+fRIePIoaPlHX65aQ9GZ9C3ptZar
         1zwuKsyCbyWewc9EnyCROhH3dR3h37Go/MXwM/c2oUrPY21HMgr+xx2somW2AIT/aQbZ
         PgYF73WQWeykFbGe7Y0kvnPjkSidsvbcgLlSy7Wun6P6RxYRr0Jv0gLwrv9OKWUJC2mK
         f51N58MwV0wWdSz9duP+k26ozjvtIgR0+btDAd7vJawsRVxPAynWDGt4Dktz3CUoK140
         DbkDaVRnLEindRguL3NousxlSRvQqNxSDM2TClUCSznul1DGdJdOOR5BdjGDCT4v9NSt
         efkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4fNDE/75PqRtj3PckNQVcUA82SSR8smSc3hj4cv/hCo=;
        b=iY+wJPEQb2AouHXuRDBYGMz24olpMrw07EjxRYC9n1BzdQena4VUePWS6yS+oIta5t
         YtmudM3ZSdNQWciJ56CRyFdyJZEFK/6MZur9vtDZ6KzvrwnvTytVZV6lDadPhRRYHOEY
         8Q3tzF7EigBi0Amxwf3HNWQT8+FWIBQ6P8UEoCuV2Rarp9i8fOrP7SEZOQ3SEIQWOUMe
         1e6TADOBCNERzv8UXb3Y6o44qicgyB8ZulvkfGMJE3IcMucda8GIcT6YyaxjfukFBg81
         J7V7gUTU3qRV+n74j2pQROP+IGlMXfajFcHrFSJo3HwBRZbfwUEpmnTDK7nM+guNuQOt
         wvXQ==
X-Gm-Message-State: AKGB3mJpkRs3tQaHuf9+8JhX8q8tD5N9zKNkTe2RnzppfzTK4sHfIqcu
        2Jq4AQNi639U5wCiQdwj2zKHBzpEMQmf7N4afwk=
X-Google-Smtp-Source: ACJfBotz9yVwGVUzrMoT9ybTQYBhRyEvdzgt0ltLG60ZLOxmguSB0Yt8KBVO3kre0Vt01/yLj1faetSURV5P5vgJEgw=
X-Received: by 10.55.126.7 with SMTP id z7mr3009745qkc.306.1513036730285; Mon,
 11 Dec 2017 15:58:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 11 Dec 2017 15:58:49 -0800 (PST)
In-Reply-To: <09713FC5-9D71-4B39-BFA3-0CB9C63321A2@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <CAPig+cQ6VSXXSYJOiZeTqUpwijVhvvUYzXF8U3KCBsOQ91HPZQ@mail.gmail.com> <09713FC5-9D71-4B39-BFA3-0CB9C63321A2@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Dec 2017 18:58:49 -0500
X-Google-Sender-Auth: p5VEkpHeZhFGBh1kMTEP3rBKj-U
Message-ID: <CAPig+cRtsCeWZZcj-jRLsqwb5OSHLBQFyGCvpAXeHRmcbTtT+w@mail.gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, patrick@luehne.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 6:47 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 11 Dec 2017, at 19:39, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Dec 11, 2017 at 10:50 AM,  <lars.schneider@autodesk.com> wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> Git and its tools (e.g. git diff) expect all text files in UTF-8
>>> encoding. Git will happily accept content in all other encodings, too,
>>> but it might not be able to process the text (e.g. viewing diffs or
>>> changing line endings).
>>>
>>> Add an attribute to tell Git what encoding the user has defined for a
>>> given file. If the content is added to the index, then Git converts the
>>> content to a canonical UTF-8 representation. On checkout Git will
>>> reverse the conversion.
>>>
>>> Reviewed-by: Patrick L=C3=BChne <patrick@luehne.de>
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>> +static int encode_to_git(const char *path, const char *src, size_t src=
_len,
>>> +                        struct strbuf *buf, struct encoding *enc)
>>> +{
>>> +       if (enc->to_git =3D=3D invalid_conversion) {
>>> +               enc->to_git =3D iconv_open(default_encoding, encoding->=
name);
>>> +               if (enc->to_git =3D=3D invalid_conversion)
>>> +                       warning(_("unsupported encoding %s"), encoding-=
>name);
>>> +       }
>>> +
>>> +       if (enc->to_worktree =3D=3D invalid_conversion)
>>> +               enc->to_worktree =3D iconv_open(encoding->name, default=
_encoding);
>>
>> Do you need to be calling iconv_close() somewhere on the result of the
>> iconv_open() calls? [Answering myself after reading the rest of the
>> patch: You're caching these opened 'iconv' descriptors, so you don't
>> plan on closing them.]
>
> Should this information go into the commit message to avoid confusing
> future readers? I think, yes.

Maybe. However, the code which does the actual caching is so distant
from these iconv_open() invocations that it might be more helpful to
have an in-code comment here saying that the "missing" iconv_close()
invocations is intentional.
