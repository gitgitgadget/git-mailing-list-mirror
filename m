Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6BF1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 02:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeDSC3t (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 22:29:49 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:37975 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeDSC3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 22:29:48 -0400
Received: by mail-io0-f174.google.com with SMTP id h9-v6so4852347iob.5
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PPTaXCn7uzIL2iz6f5keOJYaAUNSo0MsjWZ4QkT++yw=;
        b=TOI97YM7hF7g93uePAxqY6ZdP+oISCmGSAKbwqowcMReJCgmXMOlWfVYgeLlc0raWx
         AADV7N7aa2o+S7S+mElBMzVlOmtdmR1TuAcqkRkcFWHKD/GMMbruTfKC0sJ3eQ5st5R5
         6KvztQA/90equMd44JVwERY75HfVKxHOKRCeZmpRR3Det7ge6K90XDsecySfEaNCN1As
         apxsy9bwvAaX8yTrxxwVXeqtMLDYo5fKfYwrrvoxNX0VH4Sx7Of6m1vwChv0etrmowiR
         chGPe/SrvudPLfIawmVQNd4a9EWS+UHea8l1mvQ8eeSXhM2VL6YVNTbrDZ1wWZ7AaVvv
         lFKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PPTaXCn7uzIL2iz6f5keOJYaAUNSo0MsjWZ4QkT++yw=;
        b=EjdV4pVOaEetpw3QB26Qt0EzZeZ0gQ3c/VWYVJwu9fFFHY+DbAvcvtgs7lS0xcW3m7
         h9nwtlsUXdGC7LmkWsHxErNr8MHEuyh4VbeMp9UXaqo4piuECcYbP/q6IMlyqLp8824x
         5lt3/KcbJxryeiCfGsXdLaSvBr3YjeGN81h5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PPTaXCn7uzIL2iz6f5keOJYaAUNSo0MsjWZ4QkT++yw=;
        b=SB4w0rOeIJIU0/a83UhYORqxltSS0QeDTdEvNK6LQURS8qvwpQm+sPJXE4WUB1zRZZ
         wHOWfaO1S38WV4JxSkXirLBo7RU8vHRNDF+Pyf92LlC/ovm7HT6AC58OBcutyY9qLvmr
         BYNwXcuIiXW9XMWNwGK5upfO1XwbcYVJSJXCkMbNZ+n5eqa3ZTAbteojuFUO250kKDUY
         VWsouGGXUiiy+d7P8nXuP2TIWieDY6zblXP41VYL0A5bENz6Vq60fvm53kwVQcFiUlS8
         l78RI040XhRqtNvkcPtyzNX2Xr6OFryUIlgEciGlpsxeSPHkF5oGR7yrQ0m5z7h6RyYU
         gqSQ==
X-Gm-Message-State: ALQs6tCLvS34secA1p8kv+bWYMnADZA6wpVHQ+eYkdKzncpMNwryMYJm
        rpt2YBOVww+asOLLjIK0bXN++xvHySlNUfR0ZNM=
X-Google-Smtp-Source: AB8JxZqU/LzKMgHHOFc015WXpuHtrsbtIChgOpiC8G+U1yTX+esTRXPpJE0qMUchuFrHdd/vCoRW6jfTjSrxTDOA4xg=
X-Received: by 2002:a6b:afdb:: with SMTP id p88-v6mr4379806ioo.257.1524104987831;
 Wed, 18 Apr 2018 19:29:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Wed, 18 Apr 2018 19:29:47 -0700 (PDT)
In-Reply-To: <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
 <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com> <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
 <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Apr 2018 19:29:47 -0700
X-Google-Sender-Auth: yI9LL9VVeLxCodCYaZXNCDDd_qQ
Message-ID: <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
Subject: Re: Silly "git gc" UI issue.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000066bbb5056a2a58e5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000066bbb5056a2a58e5
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 18, 2018 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A few commands that parse --expire=<time> command line option
> behaves silly when given nonsense input.  For example

So this patch definitely improves on the error message.

But look at what happens for the kernel:

    [torvalds@i7 linux]$ time git gc --prune=npw
    Counting objects: 6006319, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (912166/912166), done.
    Writing objects: 100% (6006319/6006319), done.
    Total 6006319 (delta 5050577), reused 6006319 (delta 5050577)
    fatal: malformed expiration date 'npw'
    error: failed to run prune

    real        1m4.376s
    user        0m59.963s
    sys         0m5.182s



Yes, I get that nice "malformed expiration date 'npw'" error, but I
get it after 64 seconds has passed.

So i think builtin/gc.c should use this same parse_expiry_date()
parse_opt_expiry_date_cb() thing for its timestamp parsing.

It does actually seem to do that for the gc_log_expire value that it
loads from the config file.

Maybe something like the attached patch? Then I get:

    [torvalds@i7 linux]$ time git gc --prune=npw
    fatal: Failed to parse prune expiry value npw

    real        0m0.004s
    user        0m0.002s
    sys         0m0.002s

and you could smush it into your commit (if you want my sign-off, take it)

              Linus

--00000000000066bbb5056a2a58e5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg5wqg8f0

IGJ1aWx0aW4vZ2MuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2J1aWx0aW4vZ2MuYyBiL2J1aWx0aW4vZ2MuYwppbmRleCAzZTY3MTI0ZWEu
LmE0YjIwYWFhZiAxMDA2NDQKLS0tIGEvYnVpbHRpbi9nYy5jCisrKyBiL2J1aWx0aW4vZ2MuYwpA
QCAtMzU0LDYgKzM1NCw3IEBAIGludCBjbWRfZ2MoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2
LCBjb25zdCBjaGFyICpwcmVmaXgpCiAJY29uc3QgY2hhciAqbmFtZTsKIAlwaWRfdCBwaWQ7CiAJ
aW50IGRhZW1vbml6ZWQgPSAwOworCXRpbWVzdGFtcF90IGR1bW15OwogCiAJc3RydWN0IG9wdGlv
biBidWlsdGluX2djX29wdGlvbnNbXSA9IHsKIAkJT1BUX19RVUlFVCgmcXVpZXQsIE5fKCJzdXBw
cmVzcyBwcm9ncmVzcyByZXBvcnRpbmciKSksCkBAIC0zOTIsNiArMzkzLDkgQEAgaW50IGNtZF9n
YyhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkKIAlpZiAo
YXJnYyA+IDApCiAJCXVzYWdlX3dpdGhfb3B0aW9ucyhidWlsdGluX2djX3VzYWdlLCBidWlsdGlu
X2djX29wdGlvbnMpOwogCisJaWYgKHBhcnNlX2V4cGlyeV9kYXRlKHBydW5lX2V4cGlyZSwgJmR1
bW15KSkKKwkJZGllKF8oIkZhaWxlZCB0byBwYXJzZSBwcnVuZSBleHBpcnkgdmFsdWUgJXMiKSwg
cHJ1bmVfZXhwaXJlKTsKKwogCWlmIChhZ2dyZXNzaXZlKSB7CiAJCWFyZ3ZfYXJyYXlfcHVzaCgm
cmVwYWNrLCAiLWYiKTsKIAkJaWYgKGFnZ3Jlc3NpdmVfZGVwdGggPiAwKQo=
--00000000000066bbb5056a2a58e5--
