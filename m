From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v2/GSoC 4/4] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 12:38:16 +0800
Message-ID: <CAKqreuy0jU7WOi8_iGXR2hzYJE0kG8855hQuaeaW9OTKm3yF_Q@mail.gmail.com>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
	<1458233326-7735-4-git-send-email-huiyiqun@gmail.com>
	<20160317180811.GA23669@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 05:38:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmB3-0007bi-Qd
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 05:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcCREiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 00:38:18 -0400
Received: from mail-ob0-f194.google.com ([209.85.214.194]:33711 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbcCREiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 00:38:17 -0400
Received: by mail-ob0-f194.google.com with SMTP id z10so6773914obg.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 21:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iWgEYllBKRl906avkANdW/k+ECUQMw/RalWY83lTpIo=;
        b=Q5f6urU9r12ay6Sl+h+G4CzXN9XxHL9qltafZaSt6btag9b6m4YS2CTfekqC5Mt+FA
         jfrRIN0aHWhpNEeAeSLw0GxR20krxO3UZGUWUlVgGLDV1THCQfgTEAPuskjSjjl9i3xO
         FOaSh80EGvVqpBDY01J01Jqg1pjg60uW++pIOaNmMaQEj98LpSK4Y4BXbN5a+xDpN/BX
         kUIfMhDe78Sjym6eyBoP7K99lgnFpPcAlIMCYPqZDJA+zzxpASeN2Hzm/hKJLMbEK7oI
         oq+xizoSlpchqHtYFYIpayWsIKwn98mfpVj4gPYaD5Xwk236NzKQK0hqBkSs3NjChefg
         VTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iWgEYllBKRl906avkANdW/k+ECUQMw/RalWY83lTpIo=;
        b=Y4g3H7edoNOqYdTrZFimbZogh7lH/zH3izKOMpglc7q3HhLyXVYtjpKaXpC04oskRc
         UnX46nhBF2Iet1DZLPiJhCnrJwl2pqssAGSrNvOmTVFq+4sN+pp17pynOi/CdqtcXqDI
         4ZVyoqS9q91NfnhJKXGtMtJt3qVUUPdLvLYaKT0fGBi9ZiQ8KhOVXrgz8h9Mhl+u642X
         T4NXheNgrC66rylPNeBSM8RTyN94TOe1rJeEeYThYkWG+pYdfqvdZ5PBDi8wq94/AjjA
         bn4MySUGDDs2OvFqoXrClsH/5HGduur+WCtYgqVWbXFj+WIcVwcelNVoxH8heEe2E8vO
         0aBw==
X-Gm-Message-State: AD7BkJJohzBFV5Od1YAKGlYDe+AuTRvtnsRqstJ0yShoahMcpkVpFa5x8UGL5GTiH29tj0+ou2aeWlpbLrG25Q==
X-Received: by 10.60.150.163 with SMTP id uj3mr8419844oeb.67.1458275896768;
 Thu, 17 Mar 2016 21:38:16 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 21:38:16 -0700 (PDT)
In-Reply-To: <20160317180811.GA23669@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289183>

2016-03-18 2:08 GMT+08:00 Jeff King <peff@peff.net>:
> On Fri, Mar 18, 2016 at 12:48:46AM +0800, Hui Yiqun wrote:
>
>> t0301 now tests git-credential-cache support for XDG user-specific
>> runtime file $XDG_RUNTIME_DIR/git/credential.sock. Specifically:
>>
>> * if $XDG_RUNTIME_DIR exists, use socket at
>>   `$XDG_RUNTIME_DIR/git/credential-cache.sock`.
>>
>> * otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.
>>
>> Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
>> ---
>>  t/t0301-credential-cache.sh | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
>> index 82c8411..892d1ba 100755
>> --- a/t/t0301-credential-cache.sh
>> +++ b/t/t0301-credential-cache.sh
>> @@ -12,7 +12,34 @@ test -z "$NO_UNIX_SOCKETS" || {
>>  # don't leave a stale daemon running
>>  trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
>>
>> +test_expect_success 'set $XDG_RUNTIME_DIR' '
>> +     XDG_RUNTIME_DIR=$HOME/xdg_runtime/
>> +'
>> +
>> +helper_test cache
>> +
>> +test_expect_success 'when $XDG_RUNTIME_DIR is set, `$XDG_RUNTIME_DIR/git` are used' '
>> +     test_path_is_missing "/tmp/git-$(id -u)/git/credential-cache.sock" &&
>> +     test -S "$HOME/xdg_runtime/git/credential-cache.sock"
>> +'
>
> This test fails for me, probably because XDG_RUNTIME_DIR is not
> exported.
>
> -Peff

Could you please give a try to the patch set v2, test of which is
definitely passed on my computer.
