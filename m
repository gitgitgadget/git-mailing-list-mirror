Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D23D1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeADX6C (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:58:02 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:41307 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeADX6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:58:01 -0500
Received: by mail-io0-f180.google.com with SMTP id f6so3996609ioh.8
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0jER6mYznAEWqOIzTSNg1S9Nk1Y/sHQxDWvTw9+kIi4=;
        b=JZySJHLkmuS/PmQWgQvA+95Rx/rL+sWyD0jRnHacqlDf5n9SOVZvwUBl/ihd4FcTey
         xCYto8+x3eMQs1SrQui3b1KROgAGs0yugciFeV0AfLVZ8Gg37EXHyR+rzmwnK1JGlniV
         UtQKtmiB7Gy23sbaCoevh5MrkQgc+p3c0iBgmRx163pKYvPCGzTrR6C1CXq/TYRHdpyi
         1IsZ9YFE07OsUx5nUa3MLtTU5e38qH7tVzsylJIH37gQjE97MZVW7isr/fThlUCwPa28
         yxVu7OLbX6p7c0ZB15Ej2oZ2fHpncxhxtNzFQ3qtyiJox938eCM2/zeFOtWBMPLNygbz
         i20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0jER6mYznAEWqOIzTSNg1S9Nk1Y/sHQxDWvTw9+kIi4=;
        b=kDAxpUX7V8WTYua1+yEkrYQJYoPXZNcJ4TBQWfG2G2WIabgb5fc0IPZ9y7YIU//AjN
         q9C7WBkrsv3bzGuNelYe4z7p2j22R4L/O4jxGSoNJ3kKMZ2r59efLEZDu+C4norrGlRK
         /WWChp6fgrEtzWf+vK0JK9LC0tsEnzHNjCIsWtSLGVS1HJRwiad4Ac9gfdlJo/1oQAOj
         1X7NEvVDa3SGOr32ltQfIxrV0pnD6Ag46LzasLDg7SJyrjEhm47Qq00Qu81fpXUp0lOD
         FEAAKX0OquSoNuOpnBclHiKeAE5xRE/YdIWAigijgUnx+ZciawPwClCJHH9eyB/QRsw9
         Q8gA==
X-Gm-Message-State: AKwxytdrl2eQMtEGIKArX8wyht419lmsD5U3GbXlVcO6Nk/LpvtyXWxI
        AYBGNHzo86xGeoUSA5D2sBY2CSf8Wq0D8SO+EE0=
X-Google-Smtp-Source: ACJfBovyNFzBhGmLpykhCuo54YeIWcCXj8qhPw4MCBmJvVXp6nglTJywV4670m9TSWPQKzgNbn4OQ15I6cR1WXU8F4I=
X-Received: by 10.107.188.197 with SMTP id m188mr1543254iof.67.1515110280641;
 Thu, 04 Jan 2018 15:58:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.4.74 with HTTP; Thu, 4 Jan 2018 15:57:59 -0800 (PST)
In-Reply-To: <CAL21BmkMrpEoijmMJ=2Y330shxABerc4tCBRpM2d4h0DypbYqA@mail.gmail.com>
References: <CAL21BmnycG4=Wm_e1S85QVPfs3vV_Q=TAjTAG-sv+f2mK6wbBQ@mail.gmail.com>
 <20171229132237.GA12561@sigill.intra.peff.net> <CAL21BmkcDK+VRc2CBTKnV5eubLh8u37THYjXhuTgFKR4Z=VtTA@mail.gmail.com>
 <CAL21BmkMrpEoijmMJ=2Y330shxABerc4tCBRpM2d4h0DypbYqA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 5 Jan 2018 00:57:59 +0100
Message-ID: <CAP8UFD3Bd4Af1XZ00VyuHnQs=MFrdUufKeePO1tyedWoReRjwQ@mail.gmail.com>
Subject: Re: Rewrite cat-file.c : need help to find a bug
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 11:23 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>
> So for now 2 of my last commits fail, and I am tired of searching for the=
 error.
> I was also trying to leave cat_file_info variable and fill in both new
> and old variables and then compare resulting values by printing them
> into file. Everything is OK, but I find it dudpicious that the
> resulting file is too small (fprintf was invoked only 3 times, it was
> here: https://github.com/telezhnaya/git/commit/54a5b5a0167ad634c26e4fd7df=
234a46286ede0a#diff-2846189963e8aec1bcb559b69b7f20d0R1489)
>
> I have left few comments in github to simplify your understanding what
> I was trying to achieve. Feel free to ask any questions if you find
> the code strange, unclear or suspicious.

Let me try to see how I can debug it.

Running `./t1006-cat-file.sh -v -i` gives:

---------------
expecting success:
        maybe_remove_timestamp "$batch_output" $no_ts >expect &&
        maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)"
$no_ts >actual &&
        test_cmp expect actual

Segmentation fault (core dumped)
--- expect      2018-01-04 23:31:20.515114634 +0000
+++ actual      2018-01-04 23:31:20.635114274 +0000
@@ -1,2 +0,0 @@
-5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689 blob 11
-Hello World
\ No newline at end of file
not ok 9 - --batch output of blob is correct
#
#               maybe_remove_timestamp "$batch_output" $no_ts >expect &&
#               maybe_remove_timestamp "$(echo $sha1 | git cat-file
--batch)" $no_ts >actual &&
#               test_cmp expect actual
#
---------------

So there is a segfault probably when running $(echo $sha1 | git
cat-file --batch). Let's try to run that manually.

$ cd trash\ directory.t1006-cat-file/
$  echo 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689 | git cat-file --batch
Segmentation fault (core dumped)

That's it. Now let's use gdb to see where it comes from:

$ echo 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689 > myarg.txt
$ gdb git
GNU gdb (Ubuntu 8.0.1-0ubuntu1) 8.0.1
Copyright (C) 2017 Free Software Foundation, Inc.
...
(gdb)

Let's run the cat-file command inside gdb:

(gdb) run cat-file --batch < myarg.txt
Starting program: /home/ubuntu/bin/git cat-file --batch < myarg.txt
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00005555556e88e6 in populate_value (ref=3D0x7fffffffd430) at ref-filter.c=
:1496
1496                    ref->disk_size =3D *obj_info.disk_sizep;
(gdb)

Let's get a backtrace:

(gdb)  bt
#0  0x00005555556e88e6 in populate_value (ref=3D0x7fffffffd430) at
ref-filter.c:1496
#1  0x00005555555783f1 in batch_object_write (
    obj_name=3D0x555555a655f0
"5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689", opt=3D0x7fffffffd6e0,
    data=3D0x7fffffffd5e0) at builtin/cat-file.c:291
#2  0x0000555555578660 in batch_one_object (
    obj_name=3D0x555555a655f0
"5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689", opt=3D0x7fffffffd6e0,
    data=3D0x7fffffffd5e0) at builtin/cat-file.c:346

Let's see what's the code that makes it segfault:

(gdb) l
1491                            fflush(stdout);
1492                            return -1;
1493                    }
1494                    ref->type =3D *obj_info.typep;
1495                    ref->size =3D *obj_info.sizep;
1496                    ref->disk_size =3D *obj_info.disk_sizep;
1497                    hashcpy(ref->delta_base_oid.hash,
obj_info.delta_base_sha1);
1498            }
1499
1500            /* Fill in specials first */

Line 1496 has "ref->disk_size =3D *obj_info.disk_sizep;" so let's look
at those variables:

(gdb) p *ref
$1 =3D {objectname =3D {hash =3D
"^\034\060\235\256\177E\340\363\233\033\363\254<\331\333\022\347\326\211"},
  flag =3D 0, kind =3D 4148386208, symref =3D 0x7ffff778b9e0
<_IO_2_1_stdin_> "\210 \255\373",
  commit =3D 0x7fffffffd510, values =3D 0x555555a66cb0, type =3D OBJ_BLOB, =
size =3D 11,
  disk_size =3D -7613955248136140544, rest =3D 0x0, delta_base_oid =3D {
    hash =3D "-\334qUUU\000\000\360\324\377\377\377\177\000\000\340\325\377=
\377"},
  start_of_request =3D 0x555555a655f0 "5e1c309dae7f45e0f39b1bf3ac3cd9db12e7=
d689",
  refname =3D 0x7fffffffd4a8 ""}
(gdb)  p obj_info
$2 =3D {typep =3D 0x555555a53df8 <o_type>, sizep =3D 0x555555a66c30,
disk_sizep =3D 0x0, delta_base_sha1 =3D 0x0,
  typename =3D 0x0, contentp =3D 0x0, whence =3D OI_LOOSE, u =3D {packed =
=3D
{pack =3D 0x0, offset =3D 0,
      is_delta =3D 0}}}

Ok we can see that "disk_sizep =3D 0x0" which means that it segfault
because line 1496 tries to read the value pointed to by disk_sizep
which is NULL.

I hope this will help you.

Best,
Christian.
