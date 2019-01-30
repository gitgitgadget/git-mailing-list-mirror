Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7052C1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 21:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfA3VJm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 16:09:42 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:43434 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbfA3VJm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 16:09:42 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UL1oZK022433;
        Wed, 30 Jan 2019 13:09:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=lvwRTKY5XbgsCyS6Q71C2lOFPvXykwO5Sgc/4359BNc=;
 b=u5I9PrNn4cPm3j3FgeD/nOT1JcHit7FNzfXSQFFbkHvHcjHz8GXP7jtBWxGid3HtfT1u
 HGL3NqUG4T7Vx+mCD11QwT5PIzCaRWl3tiuLZHRqsGKygo0mxxBhGdPcr5QHp5niCFgc
 cCVHgwGPOk+Myc3iMsMD62LcPGJYTEfUQq0XVBHpzAh3RM4YBldQtwUFhBOownIosw96
 ZGlLvk5E45o6yIR+WyuUUVFcXXKmm7PDnBn5YZJXSaAbXeazPc9KKOdas7n/kgZuHUDl
 Dusa/+H4X7jlApfGLF2MjzMuWjxd2a0eWzKHJVWB87hT3aEaDtdTDjtDGD7z8NOv9+cx hA== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com [17.179.226.133])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9833kqay-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 13:09:35 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5001H8XFYPSB0@mr2-mtap-s01.rno.apple.com>; Wed,
 30 Jan 2019 13:09:35 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500B00X0BJG00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 13:09:34 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: 6f2e473a32517f61feffe5442021687c
X-Va-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-Va-CD: 0
X-Va-ID: da42231c-cdbe-4e88-80b0-f015ddec8e05
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: 6f2e473a32517f61feffe5442021687c
X-V-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-V-CD: 0
X-V-ID: 33ab31f8-6b9e-4e99-806e-77c58a4410c2
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500000XBSD100@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 13:09:33 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_15:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500AE6XFXUF70@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 13:09:33 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 13:09:32 -0800
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Message-id: <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-13-jeremyhu@apple.com>
 <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
 <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
 <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 11:32, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Jeremy,
> 
> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
> 
>>> On Jan 29, 2019, at 3:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>>> 
>>>> Useful for setting up osxkeychain in Xcode.app's gitconfig
>>>> 
>>>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>>>> ---
>>> 
>>> A concern shared with 13/13 is this.
>>> 
>>> While it may not hurt too much to look at one extra location even on
>>> non-Apple platform, it probably is a mistake to have this xcode
>>> specific change in generic part of the system like config.c or
>>> attr.c.  For that matter, would it make sense to force Apple uses to
>>> look at one extra location in the first place?  In other words, we
>>> already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
>>> defined so system owners can give reasonable default to its users.
>>> The value of not using that facility and instead adding yet another
>>> place is dubious.
>> 
>> This allows for per-distribution configuration and could be useful for
>> other applications as well that want customizations specific to their
>> install of git.  For our specific use case, we do not want to munge the
>> system policy when installing Xcode.  Prior to doing things this way, we
>> were just changing the default in our distributed git binary, but this
>> seems a bit more flexible.
> 
> I think you misunderstood Junio, thinking that he referred to
> /etc/gitconfig. He did not. system_path(ETC_GITCONFIG) refers to
> <prefix>/etc/gitconfig, where <prefix> is that runtime prefix when
> compiled with RUNTIME_PREFIX.

Oh!  Awesome.  I didn't even notice this was a thing.  That would exactly solve our use case.  I'll give that a whirl.  That likely allows us to eliminate these two patches completely!

> So you can definitely have your own per-distribution configuration: it
> lives in that very <prefix>/etc/gitconfig where the portable Git is
> installed.
> 
> And since we have that nice facility, I agree with Junio that we probably
> do not even need an extra config, certainly not one just introduced for
> XCode.
> 
> Ciao,
> Johannes
> 
>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>>> config.c | 13 +++++++++++++
>>>> config.h |  2 ++
>>>> 2 files changed, 15 insertions(+)
>>>> 
>>>> diff --git a/config.c b/config.c
>>>> index ff521eb27a..656bfef8ab 100644
>>>> --- a/config.c
>>>> +++ b/config.c
>>>> @@ -1631,6 +1631,14 @@ const char *git_etc_gitconfig(void)
>>>> 	return system_wide;
>>>> }
>>>> 
>>>> +const char *git_xcode_gitconfig(void)
>>>> +{
>>>> +	static const char *xcode_config;
>>>> +	if (!xcode_config)
>>>> +		xcode_config = system_path("share/git-core/gitconfig");
>>>> +	return xcode_config;
>>>> +}
>>>> +
>>>> /*
>>>> * Parse environment variable 'k' as a boolean (in various
>>>> * possible spellings); if missing, use the default value 'def'.
>>>> @@ -1673,6 +1681,11 @@ static int do_git_config_sequence(const struct config_options *opts,
>>>> 	else
>>>> 		repo_config = NULL;
>>>> 
>>>> +	current_parsing_scope = CONFIG_SCOPE_XCODE;
>>>> +	if (git_config_system() && git_xcode_gitconfig() && !access_or_die(git_xcode_gitconfig(), R_OK, 0))
>>>> +		ret += git_config_from_file(fn, git_xcode_gitconfig(),
>>>> +					    data);
>>>> +
>>>> 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
>>>> 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
>>>> 		ret += git_config_from_file(fn, git_etc_gitconfig(),
>>>> diff --git a/config.h b/config.h
>>>> index ee5d3fa7b4..f848423d28 100644
>>>> --- a/config.h
>>>> +++ b/config.h
>>>> @@ -115,6 +115,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
>>>> extern int git_config_copy_section(const char *, const char *);
>>>> extern int git_config_copy_section_in_file(const char *, const char *, const char *);
>>>> extern const char *git_etc_gitconfig(void);
>>>> +extern const char *git_xcode_gitconfig(void);
>>>> extern int git_env_bool(const char *, int);
>>>> extern unsigned long git_env_ulong(const char *, unsigned long);
>>>> extern int git_config_system(void);
>>>> @@ -131,6 +132,7 @@ enum config_scope {
>>>> 	CONFIG_SCOPE_GLOBAL,
>>>> 	CONFIG_SCOPE_REPO,
>>>> 	CONFIG_SCOPE_CMDLINE,
>>>> +	CONFIG_SCOPE_XCODE,
>>>> };
>>>> 
>>>> extern enum config_scope current_config_scope(void);
>> 
>> 

