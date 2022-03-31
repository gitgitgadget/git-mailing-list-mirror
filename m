Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF1C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 13:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiCaNK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiCaNK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 09:10:26 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABCF2DA83
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 06:08:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=RQjV4dfchduwlUrJ/RxXT+FoPhpRE41PnO/JBHVVUBHkJxgOtwY72P99iu9Ck7qekpq9NrLvUiTcd5vf+jSTgzm9YTPKk2FQKePrhYQtb4w6HFbPyLjiYkgGzDA7sbhOVjt3sayCv43L3hL4e8Lsg+p6dj6KwzG9itsvG/jOP0r+SLY3dmIomOfVuOcPnbK3a0s0zlsCbysTK/rHh5LAAJjGAzGz/sQTaQ/5gh8FyssSEIOcqqbmNbOLfvllsn8qi3+g+Tu9WhDKSsm5RE66+IzaiLyoi1Ud75Al3hlPnqXIG14xriiFZoD5aqa9rBmlskw9XnN5gy9IgE9kDJZ6ug==; s=purelymail1; d=slashdev.space; v=1; bh=PoRZNB1/YgPcr+nQbi3L4msjX5QjsOCtDTriiUCgN/g=; h=Received:To:From;
DKIM-Signature: a=rsa-sha256; b=FZ5O5Zt7zC2N04EQvV9y8W1pR9KafuIQG2XRu76/l5ZNwjiLcMXhYDdyD+N0xcSgw6J7LgYLt6Jfo/VaV4MHG8vZ+mLzEfGbh9BhCePZjeXTytXHkVXTfilo6yNKN2jY+C6WPR95TCkv5AetbBCFtg8gRF7sXOi+j9yrlxrX8Pu9LAnKlzV+VT0U+DKu8f0z87MrbWbCpMvnMS+8UWGxumHrKDq5K6LMPzSTdg5KgKa398GiXXD5dr1A1qCnXWmAkLkLGct8MG+qrdSHkTDEiyIMgHbvoCbTO6KzNYZRG4tczN4aMPYDIzH69qMIEmpZc9fH6227syqZ6lPm6TTUjw==; s=purelymail1; d=purelymail.com; v=1; bh=PoRZNB1/YgPcr+nQbi3L4msjX5QjsOCtDTriiUCgN/g=; h=Feedback-ID:Received:To:From;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -960214210;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 31 Mar 2022 13:08:14 +0000 (UTC)
Message-ID: <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space>
Date:   Thu, 31 Mar 2022 15:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
Content-Language: en-CA
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>
References: <20220330190956.21447-1-garrit@slashdev.space>
 <xmqq5ynv6rb4.fsf@gitster.g>
 <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
 <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
From:   Garrit Franke <garrit@slashdev.space>
In-Reply-To: <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.03.22 02:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Thu, Mar 31 2022, Garrit Franke wrote:
>=20
>> On Wed, Mar 30 2022, Junio C Hamano wrote:
>>
>>> Sorry, but it is unclear why it is a good thing.
>>
>> My main motivation behind this change was a standardized user
>> experience across tools. Many users use these shorthands out of habit
>> to get an overview of a program. Seeing the command fail and having to
>> retype it in a longer form creates unnecessary friction between the
>> user and the program.
>=20
> I think this is a good trade-off in this case. I.e. -v and -h are
> commonly understood.

An interesting observation I just made is that curl [0] uses both
"--verbose" and "--version" on the top level [1][2] including=20
shorthands. "-v" corresponds to "verbose", "-V" corresponds to "version.

Not that I'm a fan of this clutter, but it's a possible path to go down=20
if we actually needed a second shorthand using this letter.

[0]: https://github.com/curl/curl
[1]:
https://github.com/curl/curl/blob/master/docs/cmdline-opts/version.d
[2]:
https://github.com/curl/curl/blob/master/docs/cmdline-opts/verbose.d


