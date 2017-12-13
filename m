Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD141F407
	for <e@80x24.org>; Wed, 13 Dec 2017 17:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbdLMRWG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:22:06 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34130 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbdLMRWF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:22:05 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBDHM0f7071882
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Dec 2017 12:22:00 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Simon Doodkin'" <helpmepro1@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com> <alpine.DEB.2.21.1.1712131739080.23267@MININT-6BKU6QN.europe.corp.microsoft.com>
In-Reply-To: <alpine.DEB.2.21.1.1712131739080.23267@MININT-6BKU6QN.europe.corp.microsoft.com>
Subject: RE: feature-request: git "cp" like there is git mv.
Date:   Wed, 13 Dec 2017 12:21:53 -0500
Message-ID: <000501d37436$e2659340$a730b9c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJfa9Usa2cjU4UzuR8KWtZMnNIO7gI7Hf57ohe54cA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On December 13, 2017 11:40 AM Johannes Schindelin wrote:
>On Tue, 12 Dec 2017, Simon Doodkin wrote:
>> please develop a new feature, git "cp" like there is git mv 
>> tomovefile1 tofile2 (to save space).
>> there is a solution in https://stackoverflow.com/a/44036771/466363
>> however, it is not single easy command.
>This is not how this project works. The idea is that it is Open Source, so
that you can develop this feature yourself, and contribute a patch.

Agree with Johannes. Let's help though, to quantify the requirements so that
Simon can get this right. I'm putting my tyrannical repository manager hat
on here rather than developer so...

Are you looking to have git cp copy the entire history of tomovefile1 to
tofile2 or just copy the content of tomovefile1 to tofile2 and add and/or
commit the file?

In the latter, I see the convenience of this capability. Even so, a simple
cp would copy the content and then you can commit it fairly easily. In the
former, copying the entire history of a file inside the repository is going
to potentially cause tofile2 to appear in old commits where prior to the git
cp command the file was not present? In this situation, you are actually
rewriting history and potentially impacting signed commits (which would no
longer pass a signature check, I hope). Stitching repositories is sometimes
done when repairs or reorganization is required, but I'm concerned that this
is opening up a can of worms that breaks the atomicity of commits
(particularly signed ones). What I don't want, for my own teams, is for
members to think that git cp would be a harmless (unless it actually is)
command, rather than a repair/reorg mechanism used for splitting apart a
repository, or copying a file to a new project then splitting selectively.
So, I'm obviously a bit confused about the goal.

Simon: the stackoverflow post provides a few options on this command. Can
you clarify which particular direction you are interest it?

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



