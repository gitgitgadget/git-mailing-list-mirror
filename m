From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Mon, 24 Aug 2015 13:28:14 +0100
Message-ID: <CAE5ih78P2-oiZTY-d_5NYgchG3mh4FVy8GaNmBhicmmceU2k8w@mail.gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih7_zTP-5WFtPfEcgVsG-sV6k2BhfYh5Z_ttS0oVvJx4NgA@mail.gmail.com>
	<24F604FE-6052-4250-80CD-3C366FE5D8DC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 14:28:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTqrR-0001D3-4N
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 14:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbbHXM2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 08:28:17 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:32853 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbbHXM2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 08:28:15 -0400
Received: by obbhe7 with SMTP id he7so111441227obb.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=d6WRPF0c/h5GLB6LvicgNBrLW6WeBIZ23owsOOK/Qqw=;
        b=N6HKNsFkKB8dl74KPY6+fBhf8B7s/2SOxe4pdycU42/P/AyUmwnCNwxgLRXOxJc1rt
         UHIg96exqIHD9PUElvx+g6val9oFu050qaYjGE6jugQcb/2+51UDUnqbc99cZ/40mT6y
         3lXqABUtqwzHZE6AoKIT/AgqNxc18kmMWGUec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d6WRPF0c/h5GLB6LvicgNBrLW6WeBIZ23owsOOK/Qqw=;
        b=hPzpZA3JEn8ZAXDLrXNin3rD1vk+foz84wyBQ1t0PcmcLPSWYF3FeD3QcgBZKK0Gy2
         0p/U4QbHVPYYL7Rsxo2tldrvc4eKrrV/tBfEFeFvmtMK/B+PpuNI+WXHimomaAI9LQGM
         ZsSbz5H83XyYgx99rvuhboqmgdj7ZoE0QqJRNfThx+a9MIuS4nstB1byKSAvslTVSDpq
         8OFaRTdrByxE1nf5tf74jkzAJyD9ZBVM098uK2p7p9E2JlQFYX4cdqN87T3IQR1PGChf
         T1woRz2RzGdVxZ4+3M6Nq/+l74y91YDLdWq0MqLM62mywhy+YfKimGSkDoKooWwsTLqd
         +GlQ==
X-Gm-Message-State: ALoCoQmcF4UlAZFK9mWjQYlYBEbImE67aIPPQga4STBtQHnOe5Zw9qadSuOLkQ++hV97VesOuzxK
X-Received: by 10.60.54.1 with SMTP id f1mr21562954oep.68.1440419294280; Mon,
 24 Aug 2015 05:28:14 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Mon, 24 Aug 2015 05:28:14 -0700 (PDT)
In-Reply-To: <24F604FE-6052-4250-80CD-3C366FE5D8DC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276445>

On 24 August 2015 at 10:51, Lars Schneider <larsxschneider@gmail.com> w=
rote:
>>
>> I'm still trying to fully understand what's going on here - can you
>> point out where I've got it wrong below please!
> Your welcome + sure :)
>

<snip>

>
> While I was working on the examples for this email reply I realized t=
hat the problem is only present for paths given in a client-spec. I add=
ed a test case to prove that. That means I don=E2=80=99t need to reques=
t *all* paths. I *think* it is sufficient to request the paths mentione=
d in the client spec which would usually be really fast. Stay tuned for=
 PATCH v5.

I've just tried a small experiment with stock unaltered git-p4.

- Started p4d with -C1 option to case-fold.
- Add some files with different cases of directory (Path/File1,
PATH/File2, pATH/File3).
- git-p4 clone.

The result of the clone is separate directories if I do nothing
special (PATH/File1, Path/File2, etc). But if I set core.ignorecase, I
get a single case-folded directory, Path/File1, Path/File2, etc. I'm
still failing to get how that isn't what you need (other than being a
bit obscure to get to the right invocation).

I've put a script that shows this here:

https://github.com/luked99/quick-git-p4-case-folding-test

Thanks!
Luke
