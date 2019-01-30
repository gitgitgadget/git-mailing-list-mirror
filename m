Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693F01F453
	for <e@80x24.org>; Wed, 30 Jan 2019 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfA3XQP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:16:15 -0500
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:42258 "EHLO
        ma1-aaemail-dr-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbfA3XQP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 18:16:15 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0ULuW9J051924;
        Wed, 30 Jan 2019 14:01:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=PwzKAWrcWJruMwe3RV+vFiFQLPQ11qrhi8PQzXpqkic=;
 b=d2RWGSUeBdnbCMNvBYy89YGK2c0LqUZwQ7C51JcPaZkfzBALYSFq5vXCEmxpxkDqlFBE
 3escAB6HhGjwMxyvPMDniBKj8DE7pEVLUCgXTKiKr3/XFrrVpfpWkOn7zEeqM+T3y2xQ
 OmejvddU/Eyik4Us1DzwmhBHBjAs+XRZgiyNt9afJyD3EAqjQ+4rGyk6OqoM4L9SvfV7
 I766SqMlTAu2YyjHCNT6ZY6CSpyOXyIuDJ5TtcJVdgcmVaYu+eloc5BP4UacA+4k0Q51
 ZINL4F+h6GjJfm/7ovSKnHxDMYofQ+9xU3duhvMgAr5MfOIzFjzN+IvpuXfdGuBgkx53 +w== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 2q8qe49mnw-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 14:01:11 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500C3EZTRXI10@ma1-mtap-s03.corp.apple.com>; Wed,
 30 Jan 2019 14:01:07 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500F00ZSAM400@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 14:01:06 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: 6f2e473a32517f61feffe5442021687c
X-Va-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-Va-CD: 0
X-Va-ID: 3348e4ef-f445-43ca-ae19-ccceaa4284fa
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: 6f2e473a32517f61feffe5442021687c
X-V-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-V-CD: 0
X-V-ID: 66f743cd-b1fb-4369-84d7-d001c3d32bbb
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500800ZJQ4B00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 14:01:06 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_16:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500MF5ZTTBSA0@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 14:01:06 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com>
Date:   Wed, 30 Jan 2019 14:01:05 -0800
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Message-id: <8507DB9E-A76E-4038-BDB6-110066865C1E@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-13-jeremyhu@apple.com>
 <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
 <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
 <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
 <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_16:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 13:09, Jeremy Huddleston Sequoia <jeremyhu@apple.com> wrote:
> 
> 
> 
>> On Jan 30, 2019, at 11:32, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> Hi Jeremy,
>> 
>> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
>> 
>>>> On Jan 29, 2019, at 3:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> 
>>>> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>>>> 
>>>>> Useful for setting up osxkeychain in Xcode.app's gitconfig
>>>>> 
>>>>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>>>>> ---
>>>> 
>>>> A concern shared with 13/13 is this.
>>>> 
>>>> While it may not hurt too much to look at one extra location even on
>>>> non-Apple platform, it probably is a mistake to have this xcode
>>>> specific change in generic part of the system like config.c or
>>>> attr.c.  For that matter, would it make sense to force Apple uses to
>>>> look at one extra location in the first place?  In other words, we
>>>> already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
>>>> defined so system owners can give reasonable default to its users.
>>>> The value of not using that facility and instead adding yet another
>>>> place is dubious.
>>> 
>>> This allows for per-distribution configuration and could be useful for
>>> other applications as well that want customizations specific to their
>>> install of git.  For our specific use case, we do not want to munge the
>>> system policy when installing Xcode.  Prior to doing things this way, we
>>> were just changing the default in our distributed git binary, but this
>>> seems a bit more flexible.
>> 
>> I think you misunderstood Junio, thinking that he referred to
>> /etc/gitconfig. He did not. system_path(ETC_GITCONFIG) refers to
>> <prefix>/etc/gitconfig, where <prefix> is that runtime prefix when
>> compiled with RUNTIME_PREFIX.
> 
> Oh!  Awesome.  I didn't even notice this was a thing.  That would exactly solve our use case.  I'll give that a whirl.  That likely allows us to eliminate these two patches completely!

Unfortunately, I was quick to celebrate.  This picks up the bundled file instead of a system-wide file.  I'd love it if we could still honor system-wide config/attributes in addition to RUNTIME_PREFIX-relative ones (eg: user overrides system which overrides distribution).  I worry that as is, we'd stop referencing the system-wide configs which might confuse users.

Is that something you'd be interested in, or should we just continue to maintain our separate patches?

> 
>> So you can definitely have your own per-distribution configuration: it
>> lives in that very <prefix>/etc/gitconfig where the portable Git is
>> installed.
>> 
>> And since we have that nice facility, I agree with Junio that we probably
>> do not even need an extra config, certainly not one just introduced for
>> XCode.
>> 
>> Ciao,
>> Johannes
>> 
>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>>> config.c | 13 +++++++++++++
>>>>> config.h |  2 ++
>>>>> 2 files changed, 15 insertions(+)
>>>>> 
>>>>> diff --git a/config.c b/config.c
>>>>> index ff521eb27a..656bfef8ab 100644
>>>>> --- a/config.c
>>>>> +++ b/config.c
>>>>> @@ -1631,6 +1631,14 @@ const char *git_etc_gitconfig(void)
>>>>> 	return system_wide;
>>>>> }
>>>>> 
>>>>> +const char *git_xcode_gitconfig(void)
>>>>> +{
>>>>> +	static const char *xcode_config;
>>>>> +	if (!xcode_config)
>>>>> +		xcode_config = system_path("share/git-core/gitconfig");
>>>>> +	return xcode_config;
>>>>> +}
>>>>> +
>>>>> /*
>>>>> * Parse environment variable 'k' as a boolean (in various
>>>>> * possible spellings); if missing, use the default value 'def'.
>>>>> @@ -1673,6 +1681,11 @@ static int do_git_config_sequence(const struct config_options *opts,
>>>>> 	else
>>>>> 		repo_config = NULL;
>>>>> 
>>>>> +	current_parsing_scope = CONFIG_SCOPE_XCODE;
>>>>> +	if (git_config_system() && git_xcode_gitconfig() && !access_or_die(git_xcode_gitconfig(), R_OK, 0))
>>>>> +		ret += git_config_from_file(fn, git_xcode_gitconfig(),
>>>>> +					    data);
>>>>> +
>>>>> 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
>>>>> 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
>>>>> 		ret += git_config_from_file(fn, git_etc_gitconfig(),
>>>>> diff --git a/config.h b/config.h
>>>>> index ee5d3fa7b4..f848423d28 100644
>>>>> --- a/config.h
>>>>> +++ b/config.h
>>>>> @@ -115,6 +115,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
>>>>> extern int git_config_copy_section(const char *, const char *);
>>>>> extern int git_config_copy_section_in_file(const char *, const char *, const char *);
>>>>> extern const char *git_etc_gitconfig(void);
>>>>> +extern const char *git_xcode_gitconfig(void);
>>>>> extern int git_env_bool(const char *, int);
>>>>> extern unsigned long git_env_ulong(const char *, unsigned long);
>>>>> extern int git_config_system(void);
>>>>> @@ -131,6 +132,7 @@ enum config_scope {
>>>>> 	CONFIG_SCOPE_GLOBAL,
>>>>> 	CONFIG_SCOPE_REPO,
>>>>> 	CONFIG_SCOPE_CMDLINE,
>>>>> +	CONFIG_SCOPE_XCODE,
>>>>> };
>>>>> 
>>>>> extern enum config_scope current_config_scope(void);
>>> 
>>> 
> 

