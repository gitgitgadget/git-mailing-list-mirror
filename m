From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 20:45:45 +0700
Message-ID: <CACsJy8AuhbwkjGjeQRYe1XZFsAntNdpKYxBM9aeMwF3HpB16Ow@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <20130530114808.GD17475@serenity.lan> <CAJ-05NM9EhikDBP0izqWrnLbZW6RcHq_cH-20YTE08SZw5fjqA@mail.gmail.com>
 <CACsJy8A1oEezNeFjXTrQ=+gJ6nxDheFYTU0xtiSRt0aOOvE=Vw@mail.gmail.com> <CAJ-05NPacjAEC99Ntd9eMnTD9_PMMYFob-_tAx5CeSB79TkRSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 15:46:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3BM-00069q-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386Ab3E3NqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 09:46:16 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36017 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076Ab3E3NqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 09:46:15 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so557092obb.39
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ygQEfBQMWrhz6xaqn4gpLhxB/8rv54Ckzt/MAr6ECBA=;
        b=cHdiZt+siVxPeRW671zQZG2H42BpUnFLJJjX9oqP4fyA+HK0RJ9I52UuOq7w9mJ8iq
         S6SUIqUh+WofEPdzHI56IX5ZewSaEbzyJG7KP7x63b1WtI4IHEHxfRIJDrI7pobVaz7o
         oWLywE8PXbEAjUAwcNkt2ToaWN+Zx9EPeDUxFlXhllt0ycJVSRylwAAiArsGXHuNHma7
         TaXcO+QkH9Udtmrmx30DQwaVBA8VW3aYY/G9zM6qmlR1krxu11eoIDKu6WmXht+v6aWR
         WUapMt6GLTln19QpSnkFhPd68K6bzIZi/spyzgtBfJxE2c0NJ5RZcskKderlxLCs8yk/
         OkPw==
X-Received: by 10.60.150.146 with SMTP id ui18mr4018040oeb.101.1369921575385;
 Thu, 30 May 2013 06:46:15 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Thu, 30 May 2013 06:45:45 -0700 (PDT)
In-Reply-To: <CAJ-05NPacjAEC99Ntd9eMnTD9_PMMYFob-_tAx5CeSB79TkRSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225991>

On Thu, May 30, 2013 at 8:34 PM, Alex Benn=C3=A9e <kernel-hacker@bennee=
=2Ecom> wrote:
> From the following run:
>
>
> 14:31 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
> describe --long --tags
> ajb-build-test-5224-11-g9660048
>
> real    0m14.720s
> user    0m12.985s
> sys     0m1.700s
> 14:31 ajb@sloy/x86_64 [work.git] >wc -l /tmp/log-pack.txt
> 1610 /tmp/log-pack.txt
>
> The pack has been "tuned" with a gc --aggressive. Assuming the number=
s
> are offsets into the pack it looks fairly random access until the las=
t
> 100 or so.
>
> [snipped]

Thanks. Can you share "verify-pack -v" output of
pack-a9ba133a6f25ffa74c3c407e09ab030f8745b201.pack? I think you need
to put it somewhere on Internet temporarily as it's likely to exceed
git@vger limits.
--
Duy
