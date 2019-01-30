Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9E21F453
	for <e@80x24.org>; Wed, 30 Jan 2019 21:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfA3VIH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 16:08:07 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:39114 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbfA3VIG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 16:08:06 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UL1u4p022566;
        Wed, 30 Jan 2019 13:07:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=+nhYJ6MTmii/2bbo0bU4wJoTRd1VE80ih5dFZDTTxxc=;
 b=e5mawO8kinS63OL838vUbORQEcC4uz408Uh1brsd2YNBGtNJca867wRpOqQmWkWsYGTW
 2wsmqaTQwnecO4UQZAC8BQMXxmWG/vY1QodYhhx/+SzcPLNYR6F9Yo41cuucKyf6mv/U
 wh/VJxXJ2BzeX6JO0/+gxiEUQfTwrtEXc9EzU272KoPGHb2OuKbVcp+zznI5oTtskr5F
 hJLX9W9dSiO45yX2IpM7WC+xqWkV617HUQVK19kShe66dJiysSTqbv1sbTiBSwz6Ik23
 8empuIvuU8yD/8kex+p3z6Oahgv84ACcoIBRoaBuENI+oU1bbiAjpYnhrURysLpHQOLw JQ== 
Received: from ma1-mtap-s02.corp.apple.com (ma1-mtap-s02.corp.apple.com [17.40.76.6])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9833kpeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 13:07:58 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by ma1-mtap-s02.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5008AZXD8EBA0@ma1-mtap-s02.corp.apple.com>; Wed,
 30 Jan 2019 13:07:57 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500E00WD8PE00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 13:07:56 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: ebfa66d69e7d944e5f11137bd8176fa4
X-Va-R-CD: 2f92c04bed7413abf23072cd974bb4dc
X-Va-CD: 0
X-Va-ID: 3764ba31-92ab-449e-b0f8-867d037ad8d2
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: ebfa66d69e7d944e5f11137bd8176fa4
X-V-R-CD: 2f92c04bed7413abf23072cd974bb4dc
X-V-CD: 0
X-V-ID: 992f3826-1e32-4683-b02d-f7ca5615fa8a
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500F00X01BR00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 13:07:54 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_15:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500HD1XD5IM60@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 13:07:54 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 10/13] Support for Xcode.app co-exestince and
 relocation
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <nycvar.QRO.7.76.6.1901302025490.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 13:07:53 -0800
Cc:     git@vger.kernel.org, peff@peff.net
Message-id: <97CD298A-D301-4D27-9C7A-598C582EB43E@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-11-jeremyhu@apple.com>
 <nycvar.QRO.7.76.6.1901302025490.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 11:26, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Jeremy,
> 
> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
> 
>> This patch has been trimmed down significantly from its original version
>> when rebasing on top of git 2.18 because git 2.18 included support for
>> runtime prefix support for darwin, making this patch mostly duplicative.
>> 
>> The remaining changes are needed to ensure that git-perl can find the
>> subversion perl module (which relocates with it) and handle relocation
>> of python scripts.
>> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> 
> I am really curious about this kind of problem now. Is it that you want to
> bundle a Perl inside a portable Git, and that Perl is not at all
> relocatable and so you force Git to pretend that it is?

Not exactly, although that's an interesting problem as well.

In our specific case, Xcode.app is a relocatable bundle that contains the Xcode application, SDKs, toolchains, useful command line tools including git and svn, and more.  perl is distributed with the system in /usr/bin/perl and not with Xcode.

git-svn uses requires the perl modules that ship with subversion.  Since subversion ships with Xcode, those perl modules are packaged inside of Xcode, and the system perl has no logic to locate modules in various apps on the system as that would be an abstraction violation, IMO.

This patch changes the perl template to allow git-svn (or any other perl based tool installed by git) to locate these subversion perl modules within Xcode.app.  It requires the perl script itself to have been executed from within Xcode.app, which is why this complicates testing out of the build directory as discussed in patch 2 in the series.

The /usr/local/versioner/perl/versions logic there is specific to our build infrastructure, but if you're interested in taking something like this, I could come up with a better way to generalize it.

The issues for python are similar to for perl, but I forget the specifics around what exactly was failing in the python case.

> Ciao,
> Johannes
> 
>> ---
>> Makefile                                      |  3 +++
>> .../runtime_prefix.template.pl                | 25 +++++++++++++++++++
>> 2 files changed, 28 insertions(+)
>> 
>> diff --git a/Makefile b/Makefile
>> index 60711d6abe..97f46444f5 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2171,6 +2171,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
>> 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>> 	    -e "s=@@INSTLIBDIR@@=$$INSTLIBDIR=g" \
>> 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
>> +	    -e 's=@@PERLVERSION@@=$(shell grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$$:\1:')=g' \
>> 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
>> 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
>> 	    $< >$@+ && \
>> @@ -2206,6 +2207,8 @@ $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
>> $(SCRIPT_PYTHON_GEN): % : %.py
>> 	$(QUIET_GEN)$(RM) $@ $@+ && \
>> 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
>> +	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
>> +	    -e 's|"@@INSTLIBDIR@@"|os.path.realpath(os.path.dirname(sys.argv[0])) + "/../../share/git-core/python"|g' \
>> 	    $< >$@+ && \
>> 	chmod +x $@+ && \
>> 	mv $@+ $@
>> diff --git a/perl/header_templates/runtime_prefix.template.pl b/perl/header_templates/runtime_prefix.template.pl
>> index 9d28b3d863..b0b6b0bef1 100644
>> --- a/perl/header_templates/runtime_prefix.template.pl
>> +++ b/perl/header_templates/runtime_prefix.template.pl
>> @@ -1,3 +1,28 @@
>> +# BEGIN XCODE RUNTIME_PREFIX generated code
>> +BEGIN {
>> +    use File::Spec;
>> +    my $PERLVERSION = "@@PERLVERSION@@";
>> +    if ($^V =~ m/v([0-9]+).([0-9]+)/) {
>> +        $PERLVERSION = $1.".".$2;
>> +    }
>> +    my $__prefix = File::Spec->rel2abs( __FILE__ );
>> +
>> +    if ($__prefix =~ m/\/libexec\/git-core\// ) {
>> +        $__prefix =~ s/\/libexec\/git-core\/.*//;
>> +        unshift @INC, $__prefix . "/share/git-core/perl";
>> +        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
>> +    } elsif ($__prefix =~ m/\/bin\// ) {
>> +        $__prefix =~ s/\/bin\/.*//;
>> +        unshift @INC, $__prefix . "/share/git-core/perl";
>> +        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
>> +    } elsif ( $__prefix =~ m/\/usr\// ) {
>> +        $__prefix =~ s/\/usr\/.*/\/usr/;
>> +        unshift @INC, $__prefix . "/share/git-core/perl";
>> +        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
>> +    }
>> +}
>> +# END XCODE RUNTIME_PREFIX generated code.
>> +
>> # BEGIN RUNTIME_PREFIX generated code.
>> #
>> # This finds our Git::* libraries relative to the script's runtime path.
>> -- 
>> 2.20.0 (Apple Git-115)
>> 
>> 

