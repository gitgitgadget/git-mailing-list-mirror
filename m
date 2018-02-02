Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A071F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeBBJ5V (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:57:21 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:39564 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBBJ5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:57:19 -0500
Received: by mail-qt0-f169.google.com with SMTP id f4so30135891qtj.6
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=54c5rqk8anAadhlPGJ3BTSj7F7xo34aCxWs6U7A8Icc=;
        b=Ax4hv9cyE37jJPB7LHJWFL9TO6pW1ZcKBtlt2kccoOTxd/58Cp6F1HRXYlyBlp4WKK
         BQo9lFbkiaOmkKyUfYnBRw7gELcIPRYo3rN58ooZ7MHzdJE27vjUnfLSYf1Fy4AKsDnz
         p1agu2mBcpvaZDlikg3L8Gsz3XODFJWQY1VDRaJnZX7Hpd+UJLJdJCyPCaqNesH9rrLC
         3arVwXUtyK1zS5LW+u6pPM+lGI/Yhe+UVUJuVpVMrzrbP/N1XfzgWeM+dsCwITYWkGly
         WY3h14yW93Z7W2yAHJmwthmGKFVniXnZ7j3JyN2ovCKYU80ufQ6sunJmlq0M2o3zwCAJ
         hHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=54c5rqk8anAadhlPGJ3BTSj7F7xo34aCxWs6U7A8Icc=;
        b=AVMB4lkXZb2Q4jSk7To/SMP6DN+Ki2oCYK4Zk4KtOc56MaasX4MxrAK6dPqeq4Bow4
         +tiOF6aqRLE9ESdoCRk9q2QEO+ugMs4WDTM0yCuLcFsNoSQIe8vMHfJHwZS5w4EV6wFw
         WYNCKuvHT/Z0+px1a6ptBDzIcJl7jsaT+GOAcawrT2rhKoadk3o8LkKMmOzANe0Ufj1Y
         KQty5+jsEi8f4E+bvL3W1m5uW3Zj0KpWvyz0nljEeVnKP77vAOg4Ebt1gjKXCx/tz/Ri
         xXbaUt+OiVH2xg0N2ozn1rjEYLXO9q4DRsl3mSNkD222EqPHENgon4kmdBYyHxbvlOmp
         wloQ==
X-Gm-Message-State: APf1xPCR+LB7M/QKsqJdva/5e/812NX8xXCofQFewdYolDvdhsiUpuYJ
        JK7nfId9PtJ9ARSTokp6DtANZOovGy3+/B/yDe8=
X-Google-Smtp-Source: AH8x226CzryDNpBhBdLRzg1mcIcGWsjp5RWJR1HKbK9/NfZw4rG8h+Wk2pAnViNjWBRu2YsATh35yQaFmrItiWMxs0M=
X-Received: by 10.200.27.67 with SMTP id p3mr987665qtk.254.1517565438920; Fri,
 02 Feb 2018 01:57:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 01:57:18 -0800 (PST)
In-Reply-To: <fa3f512a-bd77-80c7-4fec-071639f62d26@suse.com>
References: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
 <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com> <fa3f512a-bd77-80c7-4fec-071639f62d26@suse.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 04:57:18 -0500
X-Google-Sender-Auth: jP1Hr0Zl0OBICtsD7JVjyplx72E
Message-ID: <CAPig+cTDHsBSPZ+o+jh9bDvJ7NcZ3DGe+penppPwyupCJzmhAA@mail.gmail.com>
Subject: Re: [PATCHv2] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 2:15 AM, Nicolas Morey-Chaisemartin
<nmoreychaisemartin@suse.com> wrote:
> Le 02/02/2018 =C3=A0 02:29, Eric Sunshine a =C3=A9crit :
>> On Thu, Feb 1, 2018 at 12:21 PM, Nicolas Morey-Chaisemartin
>> <nmoreychaisemartin@suse.com> wrote:
>>> - I'll post another series to fix the misleading messages in both commi=
t.c and tag.c when launch_editor fails
>> Typically, it's easier on Junio, from a patch management standpoint,
>> if you submit all these related patches as a single series.
>> Alternately, if you do want to submit those changes separately, before
>> the current patch lands in "master", be sure to mention atop which
>> patch (this one) the additional patch(es) should live. Thanks.
>
> Well this patch does not touch any of the line concerned by fixing the er=
ror message. So both should be able to land in any order.

Yup, that's a reasonable way to look at it. I see them as related
(thus a potential patch series) simply because the existing error
message in tag.c is fine, as is, until the --edit option is
introduced, after which it becomes a bit iffy. Not a big deal, though.

> Plus I've never had to look into localization yet so I'm going to screw u=
p on the first few submissions (not counting on people that disagree or wou=
ld prefer another message),

As long as you just change the content of double-quoted string, you
shouldn't have to worry about localization. The localization folks
will handle the .po files and whatnot.
