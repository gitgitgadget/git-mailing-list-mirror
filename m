Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCD3211B5
	for <e@80x24.org>; Wed, 19 Dec 2018 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeLSTAO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 14:00:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46248 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbeLSTAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 14:00:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so17860057edt.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=i1wSGLWochP/2z1AKcajx3tfvia9/5Rhi88Epi7CTqc=;
        b=hniD837UASchThBj0MPiV74VwAcR9sIg2+ZN9Ka54mGXKvEZIjR0uM8lEcQ/T46cg2
         jK4OVjBSUlOHiXeVIkLVmNpHKwdiM/MoCOVC8EosdO5zoCpalgpR2Z2uhN48C9QXYt5A
         2/X7edDVbIeBY3HuxNLvPasjyoGln3i/5BIhsNyUgoWgSLZK0mUC32QCekJkIEZueKcw
         NjMss7Wn15OTk67oCXpHq0rURN27rpax0OA2wrmH5LUSaODatkVACjpVpQxf8B94k7LI
         TF6sb+f+as72HTrD8ghzofzS9GkIz8BrujB9pqNlCDkpCEVFHAbvTo1JXck8YjSWx39W
         XfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=i1wSGLWochP/2z1AKcajx3tfvia9/5Rhi88Epi7CTqc=;
        b=E/nvgLahsV4dipPpqVyPulNwiZKorfTGgzEo5UBHbtllfCPABCyVr1+OuC3NAAQ1Hh
         9drVtzaJ6gI6T5C4dk5Ruziz5KR/iBzOWCAD47V1A1ovzLV310r/QCYUlPx4LGZby8h2
         hNv/pmQ0rxGHoUNozerSHcav8I5juSHlrZVNXQP8kOx0QIessbccVtUYTXkX2lL3TjZ6
         YHeRO+tuhBQAmLiBjJG4iNCSAMupYwX8a0/DpZaq9nYFc3x7drxH/NTBYWS1WXhtSo+4
         IvHAYkwdQfdJ8zVhv6EQVRYymPGhIyXbpjOGiOi2hmvfnWql5Xgvjaf7Coc7cuU88g7Z
         2AkQ==
X-Gm-Message-State: AA+aEWaWr3InqPiZm5ANdXqPpgIeGI2VmXkY4fK3tmOmv1kvzlEXfdUY
        hjj9WoLzphnEDsNE24a7KH0Ih38W
X-Google-Smtp-Source: AFSGD/UEe+Gp+LLhasbm21+SDSx00KaHOZoFIr4qXS1L8FwQjHS7U1ya8O3/7GfzVAcprQhUn3MSGQ==
X-Received: by 2002:a50:e3cb:: with SMTP id c11mr21498440edm.80.1545246012272;
        Wed, 19 Dec 2018 11:00:12 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v43sm5729294edc.18.2018.12.19.11.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 11:00:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrew Shearer <andrew@terabyte.co.nz>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: error: Use of uninitialized value $hash in chomp
References: <ME1PR01MB11218735004432E3E26C66FFE1BE0@ME1PR01MB1121.ausprd01.prod.outlook.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <ME1PR01MB11218735004432E3E26C66FFE1BE0@ME1PR01MB1121.ausprd01.prod.outlook.com>
Date:   Wed, 19 Dec 2018 20:00:21 +0100
Message-ID: <874lb9fika.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 19 2018, Andrew Shearer wrote:

> Hello
>
> I am using a "git svn clone" command to extract our project history from svn into git.
> About 30m into the process it fails with:
>
> r50739 = 2a1491de1353b1e3cce50d8f9d383407218a44f1 (refs/remotes/git-svn)
> fatal: Cannot open '.git/Git_svn_delta_33316_0_UkxiJV': Permission denied
> Use of uninitialized value $hash in chomp at C:/Program Files/Git/mingw64/share/perl5/Git.pm line 929, <GEN11> line 36311.
> hash-object -w --stdin-paths --no-filters: command returned error: 128
>
> error closing pipe: Bad file descriptor at C:/Program Files/Git/mingw64/libexec/git-core\git-svn line 0.
> error closing pipe: Bad file descriptor at C:/Program Files/Git/mingw64/libexec/git-core\git-svn line 0.
>         (in cleanup)  at /usr/share/perl5/vendor_perl/Error.pm line 198 during global destruction.
>
> I tried updating to the latest build, 2.20.1.windows, but it still fails.
>
> There is nothing particularly special about svn changeset 50739 that I can see compared to any other.
> Anyone know why this might be failing or how I could resolve it?

That "Permission denied" looks scary. Don't know how git-svn gets into
this, but try with this patch on top:

    diff --git a/perl/Git.pm b/perl/Git.pm
    index d856930b2e..f5d15895d3 100644
    --- a/perl/Git.pm
    +++ b/perl/Git.pm
    @@ -926,7 +926,13 @@ sub hash_and_insert_object {
                    throw Error::Simple("out pipe went bad");
            }

    -       chomp(my $hash = <$in>);
    +       my $hash = <$in>;
    +       unless (defined $hash) {
    +           sub noes { die "blah" }
    +           noes();
    +       } else {
    +           chomp($hash);
    +       }
            unless (defined($hash)) {
                    $self->_close_hash_and_insert_object();
                    throw Error::Simple("in pipe went bad");

Then run:

    perl -d $(git --exec-path)/git-svn

Set a breakpoint at that "noes" with:

  DB<1> b Git::noes

Continue:

  DB<2> c

Then when it stops there get a backtrace with "T":

      DB<2> T
    @ = DB::DB called from file 'perl/Git.pm' line 931
    . = Git::noes() called from file 'perl/Git.pm' line 932
    . = Git::hash_and_insert_object(ref(Git), 'Makefile') called from -e line 1

And see if you can get any other relevant info out of the debugger. See
"perldoc perldebug".
