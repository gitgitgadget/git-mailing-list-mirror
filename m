Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28665C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiHJJwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHJJwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:52:12 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EC36CD1A
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660125119;
        bh=+17qtQPnCd4VhHp+0KnYm0pjBv5lRjxNio/xGzjMfBY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dGQVjwFyEu/0BpNIkLjnok0qzFnEjd9tra3PTPgAmMQahFBAqr5n4TJA3WZOSioaB
         TpgHTJZoQSichG/GqIfoJ66ZXaARpjrCmeiHuFP4W4OUlaiCq84PmI6N65mKUaVbz6
         VcHcV5IvoIrHEgX1IqnfpmVkPlrPeLOIL/sPnCcw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1nKC7E1oHX-01813k; Wed, 10
 Aug 2022 11:51:59 +0200
Date:   Wed, 10 Aug 2022 11:51:58 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexander Meshcheryakov <alexander.s.m@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
Message-ID: <20220810095157.wo4jaumtu47qplsb@tb-raspi4>
References: <20220809182045.568598-1-calvinwan@google.com>
 <xmqqsfm4prqk.fsf@gitster.g>
 <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
 <CA+VDVVUKf48Q9A0hWPnBE+qG_7tBDuXKkdo+wWDU7iC3Wg=oEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+VDVVUKf48Q9A0hWPnBE+qG_7tBDuXKkdo+wWDU7iC3Wg=oEg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:osG1p6VTggMPghITl28Cj/e6JSORalJqZmekFTV8GWYmT4Azi24
 QVMpOiGuNdaAfjA8PMFtztO/PMeDfCATGWj4Z0UvPbF3nHiAA43EaX2KVBMM5vWTU79dEd+
 nFk866LrDboe48DhSDSRgLZqikoo6TfLkvESKl8rXss33ddhlPMTaogm6ls+Kj9MV5hlnX1
 fvuiP9EoK0yvL8GZSZMyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F4fyFBrYvys=:sFxUvcQyne5oS54iKbLlSO
 DE5/nsNf723tmkk2L9E2sS4vTf5C5vaBhePsGwsAZA1cu/8NofZ7Um7+NXrn9c/YS1P8d+pCz
 4L3Gx5eiOoMUl+1biqjXe8FealjM7nGyHcjHmCDR7Exzx71xlULMyqt6obvr9BE7MTcxu765j
 OSKJdPRNNevTXVQGT284MxufIzVUkaklty2AGPOXI7HLvT2OAYbDCwixGfBfMGMQq+jvo9mUP
 rBGWto2wrPuI2YJZ8fuJTTbKipb+oZ2ABscuYu8O17J+xHkZtb9XkaaGtSvkDQqzYl/C0q+Sv
 v08iPiNc0n+A0NnfETDRux7Tocp6aoH+diAiJQAb6hcqPhlIKmDl+ysMmyGd4chFRcHeloMT1
 ZbJI54dSrz/OPrNZ4gtIlrV5LR87JMUE1gWQD/5+aS5v0C1TCQCxaaJ5s6k4fqlHqk40avEoq
 8BqdstS12EGeyghrcWWa7UaYywuMMAbr9nqrvx8n+WQbUXKp3FVkMDfq4pznGXfGHEFdZQCNY
 pTQn+wPs7rYMZCtXRDm55r/HpK3c0YOMt4owNmkZTEBhHJLEVKCH1Du014RvKwilrZfdjUQkd
 QpIzzYhvzK/QUU9303OHWVYGy4xCqOUKjFRPLv3u8Z8QG+N00mvUwVOa6udqmBtrzHtdQBq+E
 KhraysCVNqP05hlxz92qJZl9gYYPdORWQn4V0VmjGEUENDlzExeOqS1hFeLIYEgseP3DmjHvZ
 RgeKCYkXACYv6hMGilBZhejPVgL6DcljY6GQezB8C/rl6xCLd9JDWTN+H/r35iToUuXmrqL0g
 keUNJPc6cfJdtFB26GIHlI02zWSfBwpoxZhkmNh9aa2WHgalqABZuwEAbkrnuMQy3553IEp8K
 JvS/DW82jOGMtstzbqFf//NHgq0Db407XkU/YFTE3sTtAQM8WyruepC8qi6LJ2t6RZeI6nTFx
 1AAVfaUCAWjqlQnhN/f42cKTc1Db/eMEVHGcS09vDEc7ixjiKlW01YeZF3gOGnYITh1ZhS+2m
 95kYWLAPfmTvyNGwD5EqdaOsoYkFGEA4Ez/Po4QpMKLIwcgOD35SDYTLdIfzQqYBhexfnCLOc
 6SmEsH5Boe6uSOJJLG1cR3y+51AdEhMJ9Vkj4VEGuMnAnr4w4139YDO5A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 12:56:11PM +0400, Alexander Meshcheryakov wrote:

Thanks for digging.

(And please, try to avoid top-posting here in this list)

> I believe I have found exact place where strlen is used incorrectly
> This is at diff.c:show_stats
>
> https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450=
/diff.c#L2623
>
> It probably should be replaced with one of utf8_width, utf8_strnwidth
> or utf8_strwidth from utf8.c

That did not help here. If I understand it right, this function is not at =
all involved
in our `git log --stat` ?

I tried this patch (not 100% git-style) and didn't see any print.


=2D-- a/diff.c
+++ b/diff.c
@@ -2620,7 +2620,14 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
                        continue;
			                }
					                fill_print_name(file);
							-               len =3D strlen(file->print_name);
							+               {
							+                       const char *cp =3D file->print_name;
							+                       size_t l =3D strlen(file->print_name);
							+                       len =3D utf8_width(&cp, &l);
							+                       fprintf(stderr, "%s/%s:%d file->print_name=
=3D'%s' len=3D%lu\n",
							+                               __FILE__, __FUNCTION__, __LINE__,
							+                               file->print_name, (unsigned long)le=
n);
							+               }
							                if (max_len < len)
									                        max_len =3D len;


And looking here, it seems as we are calculating max_len here.
Still more digging needed (but I don't promise anything today)
