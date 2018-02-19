Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088AB1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeBSXXD (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:23:03 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34684 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932192AbeBSXXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 18:23:02 -0500
Received: by mail-wm0-f41.google.com with SMTP id a20so2150695wmd.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=852j/6WDILBZkk8phf0zMdOzsfptJuV8ABckwhoOr6o=;
        b=NN9/Qz7wgq9O+WFevXZf1mH/wiZPEHp4VIAZeny4gSU9UkPJ6v9BPRql6TF3YPXlTb
         5pj025mDgVZDrsaQb2lpkqGrCj3XzbAHGn42efv9WcAHKCQyFh88hGPQdDwpVMqV0om5
         tfkyuyj5ssi/EsQJj1vbsSX1VUqajycrwJrBxbUmwwfx7kV5/VvsNJlSFaR+kqhK85Vv
         nDUJm2Dv/INnHV0/PLEOdDo2AeAOV6mAdBi99kc01QiiNWYHx7C2jjn11riVfsiV25Dl
         A981skip6RqJ1Qp7vrgcMwO3+QhLtAYPIHMWhFe84b0IKM29lNWB3wpj36NABn+oIPa3
         1sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=852j/6WDILBZkk8phf0zMdOzsfptJuV8ABckwhoOr6o=;
        b=WUqBWMQ+VHVv5t33zhvlPHul5Fr51Hm1zaWknCbTNYTvoyL37S7nsT22vg+V2xbm6M
         tJG70jCl7nlYC2j+59xsZ86zX7AcGEdCejD1aLqlqx+HepilMEp369L2DoLc3wFJ7IAR
         0ttgaB1UvxnXigsGuK4heRmoNyNymHr+UNgsst05VFpgJpe1DHk+o9b9T+ilnYCO64xR
         6L4DzHyqf/9pc4a0QCFsTnTbMWxLmgBCZ+FiiIP1z7sFJLyv5YiS0D57lPnplwrkdGcB
         pYbCASmEsZCLdDdDVQuTWEbufFPGMJJR0+v3of4ECwJUt1Od/kX+rWFx2PO5+GlvcyiP
         5Duw==
X-Gm-Message-State: APf1xPDf2TebyklRcjmOP5+K6sMQH1GcQHnrHEliclxcJPmHHlAo7A5e
        Okpb/Ghsq6ZZb1XIG5ZXlGrmy0xMllgaUoPJRfA=
X-Google-Smtp-Source: AH8x226vsuj5+vNJnDFk5qGtgwrDCRQzOWefcy9sywjQHnHjVug0LiFS5uSs2mz8GnEec8OF/6gaPez15xCJItk0X0I=
X-Received: by 10.28.107.69 with SMTP id g66mr11253170wmc.145.1519082581043;
 Mon, 19 Feb 2018 15:23:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.200 with HTTP; Mon, 19 Feb 2018 15:22:40 -0800 (PST)
In-Reply-To: <007901d3a9d2$2edd7cd0$8c987670$@nexbridge.com>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <007901d3a9d2$2edd7cd0$8c987670$@nexbridge.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Mon, 19 Feb 2018 15:22:40 -0800
Message-ID: <CAE1pOi00dRYGgLbvep=pC1azAqc+qX=K1+iM-SZycygZyMBg6w@mail.gmail.com>
Subject: Re: Git should preserve modification times at least on request
To:     Git Users <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 2:37 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On February 19, 2018 4:58 PM Johannes wrote:
>> On Mon, 19 Feb 2018, Peter Backes wrote:
>>
>> > please ensure to CC me if you reply as I am not subscribed to the list.
>> >
>> > https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preservi
>> > ng_modification_time_on_files.3F argues that git isn't preserving
>> > modification times because it needs to ensure that build tools work
>> > properly.
>> >
>> > I agree that modification times should not be restored by default,
>> > because of the principle of least astonishment. But should it be
>> > impossible? The principle of least astonishment does not mandate this;
>> > it is not a paternalistic principle.
>> >
>> > Thus, I do not get at all
>> > - why git doesn't *store* modification times, perhaps by default, but
>> > at least on request
>> > - why git doesn't restore modification times *on request*
>> >
>> > It is pretty annoying that git cannot, even if I know what I am doing,
>> > and explicitly want it to, preserve the modification time.
>> >
>> > One use case: I have lots of file lying around in my build directory
>> > and for some of them, the modification time in important information
>> > to me. Those files are not at all used with the build tool. In
>> > contrast to git pull, git pull --rebase needs those to be stashed. But
>> > after the pull and unstash, the mtime is gone. Boo.
>> >
>> > Please provide options to store and restore modification times. It
>> > shouldn't be hard to do, given that other metadata such as the mode is
>> > already stored. It would make live so much easier. And the fact that
>> > this has made into the FAQ clearly suggests that there are many others
>> > who think so.
>>
>> Since you already assessed that it shouldn't be hard to do, you probably
>> want to put your money where your mouth is and come up with a patch, and
>> then offer it up for discussion on this here mailing list.
>
> Putting my large-production-user hat on, there are (at least) three
> conditions that exist in this space:
>
> 1. Build systems - this typically need the file modification time to be set
> to the time at which git touches a file (e.g., checkout). This permits build
> systems to detect that files are modified (even if an older version is
> checked out, make, for example, still needs to see the change to initiate a
> build. My understanding is that current git behaviour is modeled on this use
> case.
>
> 2. Commit linkage - in some environments, files that are checked out are set
> to the timestamp of the commit rather than the original file time or the
> checkout time. This permits a faster production resolution of when changes
> were run through the system as a group. I have implemented this strategy
> (somewhat grudgingly) in a few places. It is a possible desire for some
> users. I particularly dislike this approach because merge/cherry-pick/rebase
> can mess with the preceptive "when" of a change and if you are going to do
> this, make sure that your metadata is suitably managed.
>
> 3. Original file times - as Peter asked, storing the original file time has
> some legacy advantages. This emulates the behaviour of some legacy SCM
> systems and makes people feel better about things. From an audit point of
> view, this has value for systems other than git. In git, you use the
> hash-object to figure out what the file really is, so there is no real audit
> need anymore for timestamps, which can be spoofed at whim anyway. The
> hash-object comment applies to 2 also. Same comment here for dealing with
> non-touching but modifying. For example: what is the timestamp on a
> merge-squash? I would contend that it is the time of the merge-squash, not
> the original time. It could also be an interim term, when a conflict was
> resolved.
>
> Just remember that #2 and #3 break #1, unless you essentially rebuild from
> scratch in every build (ant/maven models). With that said, I seen many repo
> admins who want all of the above, so making them all available would make
> their lives easier.

Aside from exactly which modification times should be used (which I
would love to have a bit more control over as well), something else
I'd like to see is that, when switching between branches, files that
are the same on both branches should not have their modification time
changed.
