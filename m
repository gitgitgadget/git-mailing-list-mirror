Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14FFE20966
	for <e@80x24.org>; Thu, 30 Mar 2017 22:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbdC3WiB (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 18:38:01 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36671 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbdC3WiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 18:38:00 -0400
Received: by mail-oi0-f41.google.com with SMTP id r203so45141599oib.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=DsvRbe3EM8cYMhWuteKKcivQE5M8oAnLfSofnBrf1kM=;
        b=BUam3NECRJR495FzY/FHGH95vqpQ+hbQIpDCOwVd6DbYhR79UKYUTu/VlW160IL/E5
         xPR8IbFyI7t377q0fTeDsxcVCGWYRFfMPa/nw3G//rjpgNu+MyVo1QKjtnHnStOWabB3
         Lo3ghsl1o/jOILFz/r3hrmrwPpXu4aLmKD4CBrSXVoLFQ1EechZ0m0pF+teGZ71XSQWm
         P0kmxU3Bzo+APJzRM+TtyVXgGCq2/4hOq4HrbqFG0Dsoi/MNv95lDiI0Z3tUtEAREX/w
         90+fmQRhHxokYfzBfBlmgdaRKPnzhmPPUOV0iKAwGDiWXBc7YIU4CglUhoS48CPed5nV
         AiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=DsvRbe3EM8cYMhWuteKKcivQE5M8oAnLfSofnBrf1kM=;
        b=oplJ8a3CuHpLuy26Cr1DavX06iqAep8bX6H5wYvWgln10mFvJ8jlSdSbP4gx3Fr88R
         TrpRVhZ26zFWX7L7bcS9pfzke23AQEdqtslSYWV6+9Hq4aJwYoimRoYvyCPw5ituW0SE
         L5WWNn2GwjZ/WPc0MUgRE+quZdw3Ass7iVQMoBWz2dhMnd7Q0dsfHopSzO3XDb2Od7Tx
         Aul02U5x6ASg6d78KelsR9icgz+wE5vrTvkfAz63PG5oqMkxQiACiuaz6Eufl/2VAVtP
         my87eLLbMqnDvZ+rLvUmzl0VBucHvye/Voc3YZ383CaRH3gJYQ91/W0pyc72GlVFfHO5
         jC1A==
X-Gm-Message-State: AFeK/H2yT/Kl4CH0s3WvNsATWOWG7i8WyGBg/5N8tfikBGVra3LiakIL7YUk0tf18xdhlUUrhnqk8WSZUUeJWQ==
X-Received: by 10.157.16.1 with SMTP id h1mr1445160ote.216.1490913478590; Thu,
 30 Mar 2017 15:37:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Thu, 30 Mar 2017 15:37:58 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 30 Mar 2017 18:37:58 -0400
Message-ID: <CAH8yC8nAYKMe21Q+QvoTvR_WnNJyn2p8DYSkzKmn_dWaeGb+4g@mail.gmail.com>
Subject: /bin/bash: /usr/ucb/install: No such file or directory
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this is the last of the issues for Git 2.12.2 on Solaris 11.3.

It looks like 'install' is located in a few places, but not in
'/usr/ucb'. I believe /usr/ucb is Solaris 9 or Solaris 10. I think the
equivalent place to look on Solaris 11 is /usr/gnu (but I only have
limited experience on Solaris).

solaris:~$ find /usr -name install 2>/dev/null
/usr/share/install
/usr/dtrace/DTT/install
/usr/sadm/install
/usr/gnu/bin/install
/usr/sbin/install

solaris:~$ ls /usr/ucb
/usr/ucb: No such file or directory

Here's the default one based on default paths using Bash. I change the
default shell, but not the default paths:

solaris:~$ sudo su -
Oracle Corporation      SunOS 5.11      11.3    September 2015
solaris:~# which install
/sbin/install

Jeff

************

...
Writing MYMETA.yml and MYMETA.json
    GEN git-add--interactive
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-send-email
    GEN git-svn
    SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR perl
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN.pm
>blib/lib/Git/SVN.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/GlobSpec.pm
>blib/lib/Git/SVN/GlobSpec.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <private-Error.pm
>blib/lib/Error.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/I18N.pm
>blib/lib/Git/I18N.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Editor.pm
>blib/lib/Git/SVN/Editor.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>"
<Git/SVN/Memoize/YAML.pm >blib/lib/Git/SVN/Memoize/YAML.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Fetcher.pm
>blib/lib/Git/SVN/Fetcher.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Ra.pm
>blib/lib/Git/SVN/Ra.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Utils.pm
>blib/lib/Git/SVN/Utils.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git.pm
>blib/lib/Git.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Prompt.pm
>blib/lib/Git/SVN/Prompt.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Migration.pm
>blib/lib/Git/SVN/Migration.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/IndexInfo.pm
>blib/lib/Git/IndexInfo.pm
"/usr/local/bin/perl5.24.0" -pe
"s<\Q++LOCALEDIR++\E></usr/local/share/locale>" <Git/SVN/Log.pm
>blib/lib/Git/SVN/Log.pm
Manifying 9 pod documents
    SUBDIR templates
/usr/ucb/install -d -m 755 '/usr/local/bin'
/bin/bash: /usr/ucb/install: No such file or directory
gmake: *** [install] Error 127
