Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D1F1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 10:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfJFKQV (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 06:16:21 -0400
Received: from mout.web.de ([212.227.17.12]:53343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJFKQU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 06:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570356975;
        bh=1Pj2lgMSzUmGEXRuZRN3ABS45b9L39fxNk3s3z6IqOk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LT0LDrR0usOdo8/foSIHHmJ+mTPVVp5eG11KC8Gd3COs3DcDpRKmsnTgPuPvJP+zx
         BwDFh6KoJdmAszRzoJZYfWGP8QVvDtwWhLfazZtSH0+dVLAezT5bL43JThrs0ClYmM
         /2JxnnI1xx83aitlPdrBPRl/wNio1oGtUhU+1WXs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilJB-1hgKmo1Joj-00cvtW; Sun, 06
 Oct 2019 12:16:15 +0200
Subject: Re: PATCH] remove duplicate #include directives
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <1133ae3b-81e8-4ec1-c2d7-d071e7e65ec1@web.de>
 <xmqqh84pa0ah.fsf@gitster-ct.c.googlers.com>
 <59f7fafc-818e-1996-4e1a-5697bd4880e0@web.de>
 <xmqqv9t269qk.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5af3ad29-5127-b5f7-46c9-f1d3d45b4e67@web.de>
Date:   Sun, 6 Oct 2019 12:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9t269qk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U2wWwWzsNVHRMpTTPdqBhNEdFp+haD4okUT1GssdcpxEEWbWO68
 AGMpwQkxiVKEMYiXeEz/EV2ohc/PGP5XSj9iEFHI68fMx63HIRX4IegrR7ufOxALkaLQoa3
 uh762evcOhBld2knfdyaaFhs1ZRmq9UotgOy41OSwT693pXm7lIqV3ZmOxkgN01fr5o9rRH
 lOjG20li/JPP0la3msGlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L6nB0R7Ocvs=:swTJ+Ea5ye6Rqqtd9HHkub
 mrKUGVixac9CReztpv56BOfxhWDo+UHUtO7xad0kbmykwPfQ8WrZTEbKtXV14XSGqpDBn8Lh4
 2zLSdOroL2I0x4W8gu2lUYF0kXAFELqP3uUv/KTm/3QPJuWJpW+9J26/B/U6a0HirbK3tnKbb
 Yki3tQbESgOpJ4+xehuQgRm0CWuKO9cuYrc7qBF4GjEkgipK3tBMNs3zjjWJ8xt9B1rGOd4zy
 Sz15JBFscOExXzyW8aFLWcEbqC6BhKH+iIfKfrd6bDT1qToey5Lkrpn9I+Y/x9OXFz1Ncr27t
 ZF0NRBx9n+/Y2HWA4X5th9AFkz/gLTARUqnwKtjbtn/g2WlI3FjDRQtUN2jQEtQUme3Y8Q6aL
 DvBwKJfZdjVUu4wBgJY44R3hNT2EZa1jOjFkWODhuqtubYlDCivHqNo/qEnt0LrI4xUqzeAvr
 ykC0fbwHGU1ntHKEwgml5i0MxYN30Lwfg6pR48nQ6mgNWEYkEnp5SkrWhcB96iWu8O+ACjXXg
 GK2gRB2Ub6JOCmOZ45yboW2dctP4+caJF9KINThU0MWtArKfpmEk63BYu8+mZ8EC4TMbKXz/8
 Y1JRJy64OeSNawlf4GFRyn8vRG2aA1lQ0Uo4hvsYBodNx4K/YJS+ROgmRhzCr5jMdJj68o9zW
 Zqatg3K7BLDEloRoq7BoSyFBjOIx5pziZYQUseG1gpVZVpNJgKRmBMePNIdo17luMpXFRR+lR
 RUe2IXP8JqaBeZ+N2FdlayQcKVkHFX4VvEB30mOYAkhQPXCthrHYwwCxv5TDYzbgxXAIRsdEi
 nRnt1zBKx8ceHH9tZtQr5GsNXCPdcLtrRu0+SWUiNBuTGLVTSJDnLcO96tK21AuCS5+VX8is/
 Amf/pi3W8gFHheANtbBLtWKg2YhlXuEhlqc3FoBYBLqCFLzb1e963Ga1Vy1fButZjNOYwkfnT
 ieAWaml2N6pPy7gezMTAquJvy2kXMn2EgkxKqOkmEo5P/Ug7lXyRqGJtfJgaeIdcJcLQUspPc
 5gbljC4lcnYfnoIQFRDO6ulbmaydaWrnzW9KEHJ9v0PpPLh1VoyygC0R/V24UdXq85XWym+Mi
 QqGgkUawWJnaKzYwEkNv4wQ12F97LBSNNgsqlYBn5aEvkz4USjj+TvyY1U3tHQblFW/igD+F0
 lcWPHFb30v4DDe3omwPCD3b5KONs2Z6h98I+Cj+S5Rb/90GfyC13EL+/Pf2iCYhVXtinv0IVd
 kNaCe8q90qGebRZa8j2O/WhHQebOwtRJQpGUQxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.10.19 um 01:41 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>> This one here requires one more piece of information, though, namely ou=
r
>> convention of wrapping header files in guard defines to make repeated
>> includes of them no-ops.  We do that for those removed by the patch, bu=
t
>> we have a few exceptions to that rule in our repo (at least
>> command-list.h, kwset.h, sha1dc_git.h, tar.h, unicode-width.h).  So in
>> that sense it's not such a good example of a self-sufficient patch. :)
>
> Not really.  "We use header guards" is an argument that demotes this
> cleanup from "must have" to "nice to have".  If a project did not
> use header guards or including the same header twice were an error,
> the patch in question would have been more necessary, but that
> wouldn't have changed the correctness of the patch, I think.

You start with "No", but make my point -- a reader would need more
information than the content of the patch itself to classify it as a
trivial cleanup, namely knowledge of our use of include guards.

Here is an example of a non-idempotent header:

   #define NDEBUG
   ...
   #include <assert.h>
   ...
   #undef NDEBUG
   ...
   #include <assert.h>

(That's the only one we use that I'm aware of.)

Ren=C3=A9
