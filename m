Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255EB1F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 07:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755548AbcKOHzx (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 02:55:53 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34257 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbcKOHzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 02:55:53 -0500
Received: by mail-yw0-f169.google.com with SMTP id t125so86333491ywc.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 23:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=27F7bq4HpJ4K/vdbpeD9vIZ4KfD4dsHZSGV0WJ3rtHk=;
        b=YJk70RuCBqa8xX5/8H16Z045r16Z4YmmZ6eaZWWn3aNirUjnnch1XlabqXXUruurqU
         1ecQ/va6SUtnEIdBSQLout1xtOh2dQEj+ETZ/rQKZYu3X2eaYB3BJ7L6RONoyggokTx2
         0mPGk26GgdKzAU8neemSAFql+yQq5sXFx2QbGpL+S1rAl4pC6MEi1VZ2LsSHPXiaOFct
         InqgalnggWu2KcbjoBNtdV8HdK2fn9rUMTze99X4A5XspBUVSgBBmjwWhEL3bJa2cO1O
         CVjTP4RLC+gAJnnx/miHRQxMT9bzZJq2lttQV+Laz1UZpSRgdB9QdKT5jhnZCKEA3Bpa
         RQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=27F7bq4HpJ4K/vdbpeD9vIZ4KfD4dsHZSGV0WJ3rtHk=;
        b=Q72czt1oBDuyUe2udA6Rhe8NGmqNjqI9DVv9KUgwsC7fhL4Amnhd04GvPVkTNw2RFR
         hfI1whXvmxijdkJRc9rkCg8ouvukeJPsX9uuZ8yyt1VmWmkkLPhKOZohcdNYllnDg1VL
         GBrMR6H4aAXlIPTxZFyUh6ZoSFSnGmA2h/fpaEhqMP+bew2ZMokiTYSh4FnPOj/52K6g
         M4Oyxdd3kyOKdubVFDWEWMXTVK3g0WWkFIbon5FGvVK1A7ve3ylSPbQftbiq6kMvUNeZ
         eFH8XTQ6r0JDDi5MBGRWK4F3l43iW+7kWBanYERBniORP3fV3+P0p8EcU5hmoDiFEYXB
         q/Gg==
X-Gm-Message-State: ABUngvfafMnE9KvvS2/QW/+NL5C8IIabdbtqwHc58vBQOADf5HCaKlQUNJVxOS3Za861mbi4H9wzQPVlydBiuQ==
X-Received: by 10.129.197.74 with SMTP id o10mr10944167ywj.122.1479196552237;
 Mon, 14 Nov 2016 23:55:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 14 Nov 2016 23:55:31 -0800 (PST)
In-Reply-To: <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 14 Nov 2016 23:55:31 -0800
Message-ID: <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 10:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Tue, Nov 15, 2016 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>>  - More importantly, what do these do?  I do not think of a good
>>>>    description that generalizes "base of refs/foo/bar/boz is foo" to
>>>>    explain your :base.
>>>
>>> $ ./git for-each-ref --format "%(refname)%(end) %(refname:dir)"
>>> refs/heads/master                  refs/heads
>>> refs/heads/ref-filter                refs/heads
>>> refs/remotes/junio/va/i18n     refs/remotes/junio/va
>>>
>>> $ ./git for-each-ref  refs/heads --format
>>> "%(align:left,30)%(refname)%(end) %(refname:base)"
>>> refs/heads/master                 heads
>>> refs/heads/ref-filter                heads
>>> refs/remotes/junio/va/i18n     remotes
>>>
>>> I guess this should clear it up.
>>
>> Hmph.
>>
>> I would guess from these examples that :dir is an equivalent to
>> dirname().  But it is unclear how :base is defined.  Is it the path
>> component that comes immediately after "refs/" that appears at the
>> beginning?
>
> ':dir' is equivalent to dirname(). Yup, base is the folder right after 'refs/'.
> For local branches it is 'heads' for remotes it is 'remotes'. This is useful
> when we want to make decisions based on the type of branch we're dealing
> with (using along with %(if)...%(end)).
>
> --
> Regards,
> Karthik Nayak


dirname makes sense. What about implementing a reverse variant of
strip, which you could perform stripping of right-most components and
instead of stripping by a number, strip "to" a number, ie: keep the
left N most components, and then you could use something like

"keep=2" to keep "refs/heads"

?

I think that would be more general purpose than basename, and less confusing?

Thanks,
Jake
