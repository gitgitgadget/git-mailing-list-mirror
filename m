Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63AE620188
	for <e@80x24.org>; Tue,  9 May 2017 11:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbdEILaU (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 07:30:20 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37577 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdEILaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 07:30:19 -0400
Received: by mail-it0-f48.google.com with SMTP id g126so6855349ith.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y6wtAuPZyjMxzwXjoYDsyEjUTpYXBKu7AEwp5qPGKb0=;
        b=J/yF6pGfkb/bi9iyaJeVFB/SHqcDxxNPHXiLRq7fJTCesnwEtb97g6wvGjIQhkSzdB
         cFUxPY2i23/oDmw8DzYaebK35VG1/sye+16mTFmrgqikV4lertthu9eEIwYlWSxzpOBp
         z6cxNZfItoW016I1mzwTgbBLK3m6t4yQI6ONHZ212JZHctm0rGhbPvNTPZ6bEBhGX5QH
         yHTbRkBG1j2qUSNjCTK+ndJ8ZafAnylKaeodZL2P+uf+gO4wt6ZtFhPFQz2Q40frbjeB
         aHgw5S0F+8/FP/4uiWgMTpj8/nhvhnp6RtK0LszTvjUh87DixgO3t3enUSJlXHyP2em+
         5jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y6wtAuPZyjMxzwXjoYDsyEjUTpYXBKu7AEwp5qPGKb0=;
        b=obS0P00gZ019jCDD0t7i0w3O5ougMK3OkVKpsyP5/iQV/k/EDxGUK/T7LGpxBAYWS/
         wpnXLSDb/MOZlh3Ht9iZ8RxFHkNFPqpvZdUQSQcE6LQq4drN4vrbxCN315op3moDiw3s
         wGiOGKgWXawu3hPX836hp62hdX2NJIxID2AyXTLpu9/PYYIDVxrB0RbXjIaHiX0Sz9BL
         F42EHUEVDOyB4KFo+NxlkROndkdcNp7Dfv96b/QKdwwTGP73De/GRr3rtuVkvVMPcu7c
         wRCUxDcFZDux+krutsWN0QUyF/xhI87X3pj+xI07Plb4ZT5M7gUlRb3/HU3q04ZnFaT7
         hnYw==
X-Gm-Message-State: AODbwcC/kMc5dbv4pRCSZ1Ur2PiikPx91MRcTYmT9JQ8PekFOJvhJJnY
        ysO+ungPyald0TzrUrdUsrMxKfB9RA==
X-Received: by 10.36.138.131 with SMTP id v125mr688030itd.66.1494329418660;
 Tue, 09 May 2017 04:30:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 04:29:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705091234210.146734@virtualbox>
References: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox> <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com> <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
 <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com>
 <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net> <alpine.DEB.2.21.1.1705091234210.146734@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 13:29:57 +0200
Message-ID: <CACBZZX6=Uu-tdSMzkyvFGZvbLohSrrqsw1f-NavECs-saX1L6A@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 12:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 9 May 2017, brian m. carlson wrote:
>
>> On Tue, May 09, 2017 at 02:00:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> > On Tue, May 9, 2017 at 1:32 AM, brian m. carlson
>> > <sandals@crustytoothpaste.net> wrote:
>> > > PCRE and PCRE2 also tend to have a lot of security updates, so I
>> > > would prefer if we didn't import them into the tree.  It is far
>> > > better for users to use their distro's packages for PCRE, as it
>> > > means they get automatic security updates even if they're using an
>> > > old Git.
>> > >
>> > > We shouldn't consider shipping anything with a remotely frequent
>> > > history of security updates in our tree, since people very
>> > > frequently run old or ancient versions of Git.
>> >
>> > I'm aware of its security record[1], but I wonder what threat model
>> > you have in mind here. I'm not aware of any parts of git (except maybe
>> > gitweb?) where we take regexes from untrusted sources.
>> >
>> > I.e. yes there have been DoS's & even some overflow bugs leading code
>> > execution in PCRE, but in the context of powering git-grep & git-log
>> > with PCRE this falls into the "stop hitting yourself" category.
>>
>> Just because you don't drive Git with untrusted regexes doesn't mean
>> other people don't.
>
> Or other applications.
>
>> It's not a good idea to require a stronger security model than we
>> absolutely have to, since people can and will violate it.  Think how
>> devastating Shellshock was even though technically nobody should provide
>> insecure environment variables to the shell.
>>
>> And, yes, gitweb does in fact call git grep. That means that git grep
>> must in fact be secure against untrusted regexes, or you have a remote
>> code execution vulnerability.
>
> And not only grep is affected. Think HEAD^{/<regex>}. There are plenty of
> sites where you are allowed to specify revs in a freer form than SHA-1s.

That will still use reg(comp|exec) for the foreseeable future. We have
plenty of manual use of that all over the place:

    $ git grep 'reg(comp|exec)\(' *.[ch] builtin/*.[ch]

And the ^{/rx} feature is powered by the one in sha1_name.c

> Having said that, I do like the prospect of a faster git grep.
>
> Hopefully there will be a way to make use of PCRE that can be switched
> off? Like, a compile-time replacement of the regex API backed by PCRE v2
> *iff* PCRE v2 is used for building?

Yup, see my just-sent
<CACBZZX6V8qbnrZAdhRvPthy5Z91iEG8rrJ=3DSf9tdkOt52M9j1Q@mail.gmail.com>.
It'll be optional for now, as it's been for a while.

Aside from that I do think given these numbers it's worth considering
making PCRE a default dependency, and possibly getting rid of stuff
like kwset because a) it reduces the many codepaths we have now of
either doing fixed/basic/extended/pcre into one b) since the numbers
suggest pcre can support all of that faster that seems like a sensible
thing to do.

But anything like that will be a few patch series's down the road, for
now I'm just making it all optional.
