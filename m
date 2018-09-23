Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6C61F453
	for <e@80x24.org>; Sun, 23 Sep 2018 13:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeIWTC1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 15:02:27 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36322 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeIWTC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 15:02:26 -0400
Received: by mail-ed1-f52.google.com with SMTP id f4-v6so14160491edq.3
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=BT0QLwr6wljSdiStBK0JqQ08O8Sj1Y8YrwU+G+8Dl5k=;
        b=WVY2zFa9ZKRg74NkTaSpZk3/X6ql7Vo9aPbeHx1T0nKBMxfL1p4hP+N34RgtqIt2Lj
         Jb22vPsre5iYpn8gpriatMMWNOWMViKEU6JX0/9rwsItsmuTUf4EKEpVypT+6urK8uC2
         LBGpqtTlzPcNbvbWA3cwcjoZ8H4Kyo06nbkSMsS/mEBVs3qCzo3PhI8MqXqbI4vnLtht
         U8sfe8pMXn8vikaGYdA/JYmUf5mdytmbJOgBLPVVXPVibybm0eXhPXvPcEOxniD9aQOu
         PITbgXZaYJOoypa7DMPEn07YYgY035U9ahmQnu7DUP/+k32Vs3a2d9Fh+QCbpkCtvzSJ
         Uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=BT0QLwr6wljSdiStBK0JqQ08O8Sj1Y8YrwU+G+8Dl5k=;
        b=h/ml5eRbw0OkaNypuj9Ke0U5hbzruUczgwAZnNiQbdNg3fxkquWd+rm2nsJT5WPWiD
         13trqIeM8OVYNSK9kKnfnzWCiHHwvb1QFP6zqiz7pBka6dHXUjNRHkciVN3X84UtJi8U
         4/6sqtF4fP8GnsfIgRfGNdLCuIPf9UFwR88gEFOpydv8XNTmhPysbCXwTWXX0KBkdpAu
         zBg3D830SrJPKrMPaQlnhlcz1atbOizffiRJuecxFfRlCO5J5gVWcJtPO2P4NVczmv95
         36LnoJdYZp2waixsH+HGeXxOmwzX3xYraLEeysreJg8eNYHcQlYke0p0G1JLZfCOhHp5
         898Q==
X-Gm-Message-State: ABuFfoh6Bm2E1bs4zJGLzb6fIwtLDJ7PxaKrQoIHudW9FlYN4U9WqdMx
        Y+8NlxGdPCDIdughnKZUCSRG/zWS
X-Google-Smtp-Source: ANB0VdYscDAfB3ZjQEkWB/jKZ4ZYwB76FraVEGcgJQii2Ff73T2m8ptSvJYL/5hlUj/5gZt4r+i5Hg==
X-Received: by 2002:a50:9e85:: with SMTP id a5-v6mr10283205edf.92.1537707900635;
        Sun, 23 Sep 2018 06:05:00 -0700 (PDT)
Received: from [192.168.2.7] ([217.9.127.11])
        by smtp.gmail.com with ESMTPSA id r23-v6sm4841845edi.17.2018.09.23.06.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 06:04:59 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Import/Export as a fast way to purge files from Git?
Message-Id: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
Date:   Sun, 23 Sep 2018 15:04:58 +0200
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently had to purge files from large Git repos (many files, many =
commits).=20
The usual recommendation is to use `git filter-branch --index-filter` to =
purge=20
files. However, this is *very* slow for large repos (e.g. it takes 45min =
to
remove the `builtin` directory from git core). I realized that I can =
remove
files *way* faster by exporting the repo, removing the file references,=20=

and then importing the repo (see Perl script below, it takes ~30sec to =
remove
the `builtin` directory from git core). Do you see any problem with this=20=

approach?

Thank you,
Lars



#!/usr/bin/perl
#
# Purge paths from Git repositories.
#
# Usage:
#     git-purge-path [path-regex1] [path-regex2] ...
#
# Examples:
#    Remove the file "test.bin" from all directories:
#    git-purge-path "/test.bin$"
#
#    Remove all "*.bin" files from all directories:
#    git-purge-path "\.bin$"
#
#    Remove all files in the "/foo" directory:
#    git-purge-path "^/foo/$"
#
# Attention:
#     You want to run this script on a case sensitive file-system (e.g.
#     ext4 on Linux). Otherwise the resulting Git repository will not
#     contain changes that modify the casing of file paths.
#

use strict;
use warnings;

open( my $pipe_in, "git fast-export --progress=3D100 --no-data HEAD |" ) =
or die $!;
open( my $pipe_out, "| git fast-import --force --quiet" ) or die $!;

LOOP: while ( my $cmd =3D <$pipe_in> ) {
    my $data =3D "";
    if ( $cmd =3D~ /^data ([0-9]+)$/ ) {
        # skip data blocks
        my $skip_bytes =3D $1;
        read($pipe_in, $data, $skip_bytes);
    }
    elsif ( $cmd =3D~ /^M [0-9]{6} [0-9a-f]{40} (.+)$/ ) {
        my $pathname =3D $1;
        foreach (@ARGV) {
            next LOOP if ("/" . $pathname) =3D~ /$_/
        }
    }
    print {$pipe_out} $cmd . $data;
}

