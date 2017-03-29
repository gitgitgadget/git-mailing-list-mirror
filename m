Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9716E1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 01:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbdC2BD4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 21:03:56 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:34782 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932623AbdC2BDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 21:03:55 -0400
Received: by mail-ot0-f179.google.com with SMTP id a5so899651oth.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Ej0E6W8N5DRe1Wqeqpb100dL320PlT17QiVPWh+21jI=;
        b=tQcROiGiMEIiX8o/lv0e1tFU0v/jl4yv2o1oYGswE5KmEkhdAeHBpH759SexdnFFxl
         5WxX7XGUsFyTnmM9mieCmz+An9swcqguWefvtDXv7OqnNX00In1GWrb5e4/fWujFA9Yd
         Fq8QiV9qokA7wmBdH+Ql6VlLgXOk0xBgjCgLvR17D10yfPqXV45tBQ74mXtBcRwLaRF/
         J58wZ7XJuOkJHThfLI1x3UWun9LcgX+J9Q0GuU8bZbVAeMbH7Wo5tVvRuEVWsuTgrLFp
         ItMQOlQLtMWn7or4Os5L21o1CuyqPRVhhN3/wmjVmIMvc2u9bs7iq4WJVKWG/Ep6Tawt
         gpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Ej0E6W8N5DRe1Wqeqpb100dL320PlT17QiVPWh+21jI=;
        b=nqVbpdplwstnG322jQ+lpWJLq6mVHPQwjuwiIzBefXh6nCiBm8R13+yaaivw6kpkbc
         MJxN7lgL5gyAXrTn1QDPjz7FR6Vz51Uf5QIphwqIuzEAN//J+OX1Up3A2YXNKGH4FaU9
         1NTcKuFKfm0fDMgQktlU+3gLNZ8HmqK2rr2aCrdZQT8PUyvaMEy8KFdf6/3S0i8VeA8n
         xLwokn77FnGxAEV9ccDIjGVrnSYD6Ro8ZFM1M8bf4u/2L9CD7m1vD/Cz4sHDAt3xj5T6
         sdcMzzFkC6kD7HDQWfyrvVijX9XF4arz4YZADv22xej9Cru+weRbq6q4UJW2BHYSEK7I
         2MbQ==
X-Gm-Message-State: AFeK/H2cJZqrrtVtmCn8B6dI7lE1NXJCzGVqBv0W3blRDc2249+RQF5P5ho1JIKpdTcNVMY/peBY2GDwecKBeQ==
X-Received: by 10.157.63.118 with SMTP id m109mr14616598otc.270.1490749423942;
 Tue, 28 Mar 2017 18:03:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Tue, 28 Mar 2017 18:03:43 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 28 Mar 2017 21:03:43 -0400
Message-ID: <CAH8yC8kpKii+FNZEUqDqLcuEWBsTTnrqMHq_3VLdAzcpDSKFww@mail.gmail.com>
Subject: Can't locate ExtUtils/MakeMaker.pm in @INC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This looks like the last issue with Git 2.12.2. This time the machine
is Fedora 25.

I configured with PERL_PATH=/usr/local/bin/perl. The local Perl was
built specifically for this error, and it includes
ExtUtils/MakeMaker.pm:

$ find /usr/local -name MakeMaker.pm
/usr/local/lib/perl5/5.24.1/ExtUtils/MakeMaker.pm

$ make all
...

    GEN git-bisect
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-quiltimport
    GEN git-rebase
    GEN git-request-pull
    GEN git-stash
    GEN git-submodule
    GEN git-web--browse
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX='/usr/local' INSTALL_BASE=''
--localedir='/usr/local/share/locale'
    GEN git-p4
Can't locate ExtUtils/MakeMaker.pm in @INC (you may need to install
the ExtUtils::MakeMaker module) (@INC contains: /usr/local/lib64/perl5
/usr/local/share/perl5 /usr/lib64/perl5/vendor_perl
/usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 .) at
Makefile.PL line 3.
BEGIN failed--compilation aborted at Makefile.PL line 3.
Makefile:83: recipe for target 'perl.mak' failed
make[1]: *** [perl.mak] Error 2
Makefile:1843: recipe for target 'perl/perl.mak' failed
make: *** [perl/perl.mak] Error 2
make: *** Waiting for unfinished jobs....
Failed to build Git

/usr/local/bin/perl is on path but Git is using the old one in /usr/bin:

    $ which perl
    /usr/local/bin/perl

It appears Git is not honoring the request for the updated Perl.

Thanks,
