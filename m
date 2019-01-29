Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D231F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfA2Xwe (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:52:34 -0500
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:42358 "EHLO
        ma1-aaemail-dr-lapp01.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbfA2Xwe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 18:52:34 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TNqSCn034352;
        Tue, 29 Jan 2019 15:52:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=p8YvX4De5SOH8saPzyzfwbVVMCYP/eAe04EqxY0hzU0=;
 b=BXGDDLGOltMInApyzzRCR2QjrUC6bmwoS/uhkCcXRNwen2sJ/+fIKacmf7SVtMZLbziJ
 GXyLQcxRH7LWhvY5LQRIJ+nZaLy911hxNIqjmJPuKaergQ0BFBU8aBRNDqJWCCxgVUWv
 zIjmpIzMFq4MUdBll3XNgD/6Xxr11p66M0lv3IejFKvfN7thfLCkbrxjyYV4nFpF6qkS
 cmlqt+d6kj9I2sNmj0JOWLExeOK/k2RBb7o/RM9lwLx3zNMc1L1gsCv8YQtWv99EeZLQ
 +foO2jJUYEvHWeP1d5oi87+/SqZZMqqYDONeJnHogvGfK6o7Ze3TwDcayEwP9wo0aEbx cw== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 2q8q3b3j6h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 15:52:28 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM400AMPABFDWF0@ma1-mtap-s03.corp.apple.com>; Tue,
 29 Jan 2019 15:52:28 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM400600A33KA00@nwk-relayp-sz02.apple.com>; Tue,
 29 Jan 2019 15:52:28 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 870e2c9ccb5cba399604c8bab4417fc4
X-Va-E-CD: 6f2e473a32517f61feffe5442021687c
X-Va-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-Va-CD: 0
X-Va-ID: b77f774f-6454-48fd-b0f1-894047e113d1
X-V-A:  
X-V-T-CD: 870e2c9ccb5cba399604c8bab4417fc4
X-V-E-CD: 6f2e473a32517f61feffe5442021687c
X-V-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-V-CD: 0
X-V-ID: f3c3b966-abc3-47d8-b8a6-b6b13820f4a3
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM400500A2IKV00@nwk-relayp-sz02.apple.com>; Tue,
 29 Jan 2019 15:52:27 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_18:,, signatures=0
Received: from [17.114.130.22] (unknown [17.114.130.22])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM400G1CABFXC80@nwk-relayp-sz02.apple.com>; Tue,
 29 Jan 2019 15:52:27 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 29 Jan 2019 15:51:45 -0800
Cc:     git@vger.kernel.org, peff@peff.net
Message-id: <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-13-jeremyhu@apple.com>
 <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_18:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 29, 2019, at 3:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> 
>> Useful for setting up osxkeychain in Xcode.app's gitconfig
>> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> ---
> 
> A concern shared with 13/13 is this.
> 
> While it may not hurt too much to look at one extra location even on
> non-Apple platform, it probably is a mistake to have this xcode
> specific change in generic part of the system like config.c or
> attr.c.  For that matter, would it make sense to force Apple uses to
> look at one extra location in the first place?  In other words, we
> already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
> defined so system owners can give reasonable default to its users.
> The value of not using that facility and instead adding yet another
> place is dubious.

This allows for per-distribution configuration and could be useful for other applications as well that want customizations specific to their install of git.  For our specific use case, we do not want to munge the system policy when installing Xcode.  Prior to doing things this way, we were just changing the default in our distributed git binary, but this seems a bit more flexible.

> 
> 
> 
> 
> 
> 
> 
>> config.c | 13 +++++++++++++
>> config.h |  2 ++
>> 2 files changed, 15 insertions(+)
>> 
>> diff --git a/config.c b/config.c
>> index ff521eb27a..656bfef8ab 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1631,6 +1631,14 @@ const char *git_etc_gitconfig(void)
>> 	return system_wide;
>> }
>> 
>> +const char *git_xcode_gitconfig(void)
>> +{
>> +	static const char *xcode_config;
>> +	if (!xcode_config)
>> +		xcode_config = system_path("share/git-core/gitconfig");
>> +	return xcode_config;
>> +}
>> +
>> /*
>>  * Parse environment variable 'k' as a boolean (in various
>>  * possible spellings); if missing, use the default value 'def'.
>> @@ -1673,6 +1681,11 @@ static int do_git_config_sequence(const struct config_options *opts,
>> 	else
>> 		repo_config = NULL;
>> 
>> +	current_parsing_scope = CONFIG_SCOPE_XCODE;
>> +	if (git_config_system() && git_xcode_gitconfig() && !access_or_die(git_xcode_gitconfig(), R_OK, 0))
>> +		ret += git_config_from_file(fn, git_xcode_gitconfig(),
>> +					    data);
>> +
>> 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
>> 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
>> 		ret += git_config_from_file(fn, git_etc_gitconfig(),
>> diff --git a/config.h b/config.h
>> index ee5d3fa7b4..f848423d28 100644
>> --- a/config.h
>> +++ b/config.h
>> @@ -115,6 +115,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
>> extern int git_config_copy_section(const char *, const char *);
>> extern int git_config_copy_section_in_file(const char *, const char *, const char *);
>> extern const char *git_etc_gitconfig(void);
>> +extern const char *git_xcode_gitconfig(void);
>> extern int git_env_bool(const char *, int);
>> extern unsigned long git_env_ulong(const char *, unsigned long);
>> extern int git_config_system(void);
>> @@ -131,6 +132,7 @@ enum config_scope {
>> 	CONFIG_SCOPE_GLOBAL,
>> 	CONFIG_SCOPE_REPO,
>> 	CONFIG_SCOPE_CMDLINE,
>> +	CONFIG_SCOPE_XCODE,
>> };
>> 
>> extern enum config_scope current_config_scope(void);

