From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Mon, 4 Apr 2016 13:48:10 -0400
Message-ID: <CAPig+cTSHQcMh=gTLgE3kCgLqBr55ar9wn3gwXLbvRiOyqch1A@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
	<CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
	<CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
	<vpq4mbhmi3g.fsf@anie.imag.fr>
	<CA+DCAeTm7wjgdjLwR__pcyev-EsqecdAT8xdGEFfuekg4ToKSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:48:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8bp-0006aA-FO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbcDDRsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:48:13 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36622 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbcDDRsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:48:11 -0400
Received: by mail-ig0-f195.google.com with SMTP id kb1so7626838igb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=phsS9XxScai8t5ok5N0IPtoQU7UThkJqacxLe9Z1j2I=;
        b=nYmWolR8wMQVIBUQiNOb2eP1jcPYv8rnGUDO2ar1RmFccJ900G4OEuhBgpLC6kN+lL
         wMqpx6bJZeY05yn6/p2yd6OeY+S4Hqnw1F92znHRhRnUpa8LMnMbCd4JpcrQBXShGNUz
         j1HPO0FG/v4ULf0lDlFAs7yA/8oV2IpUvbK0W8IBqejoVvE78pByIXo1PhpOBElxcF8s
         m5pOFZmQ89awbM3SpIUk/0cpc9Tz4PDvHqFWYZe4AwevSDTIIdaGSly5RNhCJuThacM8
         sID3Cy9i+bRAFC5T7OMo74ev2gWHAmPdyqoMhbJWIAbw3OOpJp1pHeOrDrN+hDsnwMZc
         rwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=phsS9XxScai8t5ok5N0IPtoQU7UThkJqacxLe9Z1j2I=;
        b=JFTdcNTpkFv456IR4EEFdeL9WDXrOeakg58KAgx2LFVIR1shnaphmmSVA6dqQQv8SB
         gu+Qyv7GltlfCKVLd6rgb3UvjenJ9rBteTCeDyXGvklt6bAL9pd2wMGCiFygc+4rG3TB
         8kBoyCtfAOZKn2g1UUehr6QvB9tH304Oi8WW56QSJbJyCNsUdWaIRCPj5G53m44UkAIT
         EhysSf3W2SeO/r9pIy2QxKkSNVlqpS2Ma+9QzKsdA7sTBzyzS9Oshi475ICH1xzWt3xH
         0mmojpH832IF7m431F4sfBopZcDZLnmALi/xsf6RP+zuX91pqWopv95EwmqPpCX2Lqvt
         tVag==
X-Gm-Message-State: AD7BkJKFiqGpd+WHPB9V7QpxA3jHC8JsZE2sg0KL0+TtvM4DaG2+PU29ya6qXlO/hMiQ/+xFmybnVR1jKEBbGw==
X-Received: by 10.107.47.41 with SMTP id j41mr16942911ioo.168.1459792090966;
 Mon, 04 Apr 2016 10:48:10 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 10:48:10 -0700 (PDT)
In-Reply-To: <CA+DCAeTm7wjgdjLwR__pcyev-EsqecdAT8xdGEFfuekg4ToKSA@mail.gmail.com>
X-Google-Sender-Auth: RZSOzjVubTF4teCp8e41GsemEfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290709>

On Mon, Apr 4, 2016 at 1:36 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Mon, Apr 4, 2016 at 10:22 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> I think it would be much simpler to drop the loop, and write instead
>> something like (untested):
>
> I tested it (with few minor changes), and worked fine.
>
> test_autostash () {
>         OLDIFS=$IFS
>         IFS='='
>         set -- $*
>         IFS=$OLDIFS
>         expect=$1
>         cmd=$2
>         config_variable=$3
>         value=$4
>         test_expect_success "$cmd, $config_variable=$value"     '
>                 if [ "$value" = "" ]; then
>                         test_unconfig $config_variable
>                 else
>                         test_config $config_variable $value
>                 fi &&
>
>                 git reset --hard before-rebase &&
>                 echo dirty >new_file &&
>                 git add new_file &&
>
>                 if [ $expect = "ok" ]; then
>                         git pull $cmd . copy &&
>                         test_cmp_rev HEAD^ copy &&
>                         test "$(cat new_file)" = dirty &&
>                         test "$(cat file)" = "modified again"
>                 else
>                         test_must_fail git pull $cmd . copy 2>err &&
>                         test_i18ngrep "uncommitted changes." err
>                 fi
>         '
> }
>
> test_autostash ok '--rebase' rebase.autostash=true
> test_autostash ok '--rebase --autostash' rebase.autostash=true
> test_autostash ok '--rebase --autostash' rebase.autostash=false
> test_autostash ok '--rebase --autostash' rebase.autostash=
> test_autostash err '--rebase --no-autostash' rebase.autostash=true
> test_autostash err '--rebase --no-autostash' rebase.autostash=false
> test_autostash err '--rebase --no-autostash' rebase.autostash=
> test_autostash ok '--autostash' pull.rebase=true
> test_autostash err '--no-autostash' pull.rebase=true
>
> Perhaps this looks better than the one with the loop. Even better than
> the implementation in v2[1].
>
> I think it would be wise to go with the above script for v3 (as I will
> be doing a re-roll of the series[1]).

This new function is sufficiently complex that it increases cognitive
load enough for me to question if it is really a win for such a small
number of tests. The individual tests, as implemented in the current
round, are quite easy to understand, and don't place any significant
cognitive burden on the reader.

Although I'm the one who brought up the idea of "automating" these
tests, I'm not convinced that it's an improvement in this case, but I
don't feel so strongly that I'd forbid it. So, choose the approach
which seems best to you while weighing comprehension load for people
new to these tests, as well as maintainability costs.
