From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Mon, 4 Apr 2016 23:06:29 +0530
Message-ID: <CA+DCAeTm7wjgdjLwR__pcyev-EsqecdAT8xdGEFfuekg4ToKSA@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
	<CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
	<CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
	<vpq4mbhmi3g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8QV-0001wm-EL
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbcDDRgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:36:31 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:34070 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcDDRga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:36:30 -0400
Received: by mail-qg0-f65.google.com with SMTP id j35so18294690qge.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2XBF22b7uc2cvVWYvYCsnXP6KWldvdBGbuzxA+q1Tf4=;
        b=W1+ZFrySDNSauMsu9cGp42i6+9vxyglZYw7qSBepL9XqIO+qC2u/7gCQCH/vEw+hn2
         rOjwweu9On0tg6ArpqMFPXhK9qYrBIkmwK4B2LdF1j3CU7ht6MJifYkBOR9EW6FpJC/q
         0KC5Uk6Q7wSHL/RO7pLKmRvIGtLDoNQ/JVlN+W9j6biVWXsony7cDZQWhF42Xxkx9aGL
         wh3Jpcxy0+uzaPP5ldX2Epl03v5VevlCra2r9XqkLPRx8BBQq8f1OYuhI4SIp8woxmts
         gFsQYSonnPvjOuT+XjL2RxisphOsTdjbdQlCkODxqeJ15uoMz1100GrDtlJH4h6/kMta
         zFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2XBF22b7uc2cvVWYvYCsnXP6KWldvdBGbuzxA+q1Tf4=;
        b=mnd3Azdr6kUTTpH8auGgLKhwr/JnFvjQ1PMBYQm4EFKkJE63O2xpGqdU9MvkLUuNbF
         aIkwi79Jpcj8VRDHAyu5r+gUI98uyvaZRKsbUygbaL3tV5/4KSAyjSKzafOhzbuJq4sk
         lcc+Vk4x+4bbsZ+hv2hnHG4WKQ45PdYMDHBVv5FeQlia+SXDXyGajSqAPZDfiIYFgrbh
         jXyS1QyDWHFoVKDvEk9//LFf1NN3+R58DRs6uldICeqzSgKNptK7rMrnPtqSleXazzlx
         RZeGDjbirL+AMXMJVLpSvEVP0VN0Hr9CmDo0bZkzhU66iKT81p1xGtvAfh9zwDWNvW6q
         CfYA==
X-Gm-Message-State: AD7BkJIn2NYveQBN9Yr89guq/Jtgn2Zl+vZBM1EteSG1uT9K4LA3a5v1vWYP1wkEN7id9efM6H099F+kXcf2mg==
X-Received: by 10.140.240.3 with SMTP id l3mr15990812qhc.93.1459791389357;
 Mon, 04 Apr 2016 10:36:29 -0700 (PDT)
Received: by 10.55.10.135 with HTTP; Mon, 4 Apr 2016 10:36:29 -0700 (PDT)
In-Reply-To: <vpq4mbhmi3g.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290707>

On Mon, Apr 4, 2016 at 10:22 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I think it would be much simpler to drop the loop, and write instead
> something like (untested):

I tested it (with few minor changes), and worked fine.

test_autostash () {
        OLDIFS=$IFS
        IFS='='
        set -- $*
        IFS=$OLDIFS
        expect=$1
        cmd=$2
        config_variable=$3
        value=$4
        test_expect_success "$cmd, $config_variable=$value"     '
                if [ "$value" = "" ]; then
                        test_unconfig $config_variable
                else
                        test_config $config_variable $value
                fi &&

                git reset --hard before-rebase &&
                echo dirty >new_file &&
                git add new_file &&

                if [ $expect = "ok" ]; then
                        git pull $cmd . copy &&
                        test_cmp_rev HEAD^ copy &&
                        test "$(cat new_file)" = dirty &&
                        test "$(cat file)" = "modified again"
                else
                        test_must_fail git pull $cmd . copy 2>err &&
                        test_i18ngrep "uncommitted changes." err
                fi
        '
}

test_autostash ok '--rebase' rebase.autostash=true
test_autostash ok '--rebase --autostash' rebase.autostash=true
test_autostash ok '--rebase --autostash' rebase.autostash=false
test_autostash ok '--rebase --autostash' rebase.autostash=
test_autostash err '--rebase --no-autostash' rebase.autostash=true
test_autostash err '--rebase --no-autostash' rebase.autostash=false
test_autostash err '--rebase --no-autostash' rebase.autostash=
test_autostash ok '--autostash' pull.rebase=true
test_autostash err '--no-autostash' pull.rebase=true

Perhaps this looks better than the one with the loop. Even better than
the implementation in v2[1].

I think it would be wise to go with the above script for v3 (as I will
be doing a re-roll of the series[1]).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/290596

Thanks,
Mehul
