Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9451F453
	for <e@80x24.org>; Thu, 31 Jan 2019 08:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAaI30 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 03:29:26 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:54996 "EHLO
        nwk-aaemail-lapp01.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfAaI30 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Jan 2019 03:29:26 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
        by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0V8LoDm016475;
        Thu, 31 Jan 2019 00:29:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=BpnLRsVFjSMFNVuKEHKs7/uTU19dqCM9xmW9xb6tQbc=;
 b=uTIBOhZMdwHYEj7dSD1/wnQHy8kh8VTr0z4zJDlniN/rC09M2qQ5kceCLEkwUla6IHG0
 VjObgOpANtQc8wk91DtfiRweo1iWUj2RKMgpXoN63LkssRzaHdwxd+rldzEEfJE888k1
 HJaCBlAdLtUtSWPoLI/Fkg1GYNfbGuAVPI8Y1R/lBB+CJ+22RDYCQ8NYiKNLiEyP33S2
 TfyG1iIt8smwrvchM/k3X9ckNxIYa8tsMV4k/AwElxBI5SAIwUJnIyCzKQWxinJDfM1b
 zuo3W8qdPYE0gFmQoIP2pl2B2Q3+LklldF7Eiu6xmqeBjLOzBHrKDD4ADSogd3WXdfEm Nw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp01.apple.com with ESMTP id 2q8qc8q3pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 31 Jan 2019 00:29:15 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM6006QJSWRLR90@mr2-mtap-s03.rno.apple.com>; Thu,
 31 Jan 2019 00:29:15 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM600M00SHHN600@nwk-relayp-sz02.apple.com>; Thu,
 31 Jan 2019 00:29:15 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 9b759b6cf7ac78e1486c7ce26dc22bec
X-Va-E-CD: 6f2e473a32517f61feffe5442021687c
X-Va-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-Va-CD: 0
X-Va-ID: d3cc0521-e612-43bf-8572-1ecdb4fe5b71
X-V-A:  
X-V-T-CD: 9b759b6cf7ac78e1486c7ce26dc22bec
X-V-E-CD: 6f2e473a32517f61feffe5442021687c
X-V-R-CD: 1c05571ebdb9a1c8ed31b511f901c90d
X-V-CD: 0
X-V-ID: 8cb6096e-f394-45fc-b91a-a5b0952bd809
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM600E00SVYFX00@nwk-relayp-sz02.apple.com>; Thu,
 31 Jan 2019 00:29:15 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-31_04:,, signatures=0
Received: from [17.234.14.13] (unknown [17.234.14.13])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM600E70SWQL000@nwk-relayp-sz02.apple.com>; Thu,
 31 Jan 2019 00:29:15 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <20190131000137.GB23492@gmail.com>
Date:   Thu, 31 Jan 2019 00:29:14 -0800
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Message-id: <63687F17-1BC5-40B4-9708-EACFFEEFCB57@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-13-jeremyhu@apple.com>
 <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
 <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
 <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
 <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com>
 <8507DB9E-A76E-4038-BDB6-110066865C1E@apple.com>
 <20190131000137.GB23492@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 16:01, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> Hi,
> 
> Jeremy Huddleston Sequoia wrote:
> 
>> Unfortunately, I was quick to celebrate.  This picks up the bundled
>> file instead of a system-wide file.  I'd love it if we could still
>> honor system-wide config/attributes in addition to
>> RUNTIME_PREFIX-relative ones (eg: user overrides system which
>> overrides distribution).  I worry that as is, we'd stop referencing
>> the system-wide configs which might confuse users.
>> 
>> Is that something you'd be interested in, or should we just continue
>> to maintain our separate patches?
> 
> For the internal deployment at Google, what we've done is to put an
> [include] path directive in the global gitconfig:
> 
> 	[include]
> 		path = /usr/share/git-core/config
> 
> Users can edit the global git config in etc, but the distributed
> config at /usr/share/git-core/config is read-only as part of the
> distributed package.
> 
> We considered making an upstream change to bake in the distributed
> config in the git binary but decided that this way is a little
> nicer since it lets people comment out the include.path setting if
> they want to e.g. for experimentation.  It's also more explicit
> (hence easier to understand).
> 
> Would a similar approach work for your setup?  Can you say a little
> more about how you'd like things to work from an end-user pov?

That might work.  I could put this in the Xcode.app gitconfig:

	[include]
		path = /private/etc/gitconfig

Would that result in /private/etc/gitconfig's taking precedence or Xcode.app's?
Is there anything analogous I could do for gitattributes?

