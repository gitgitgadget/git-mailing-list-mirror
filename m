Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1215BC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9B860F5E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhHSSO0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 19 Aug 2021 14:14:26 -0400
Received: from elephants.elehost.com ([216.66.27.132]:28780 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhHSSOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:14:25 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17JIDg4M007542
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Aug 2021 14:13:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathon Anderson'" <janderson@acesquality.com>,
        <git@vger.kernel.org>
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
In-Reply-To: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
Subject: RE: Git Modifying DLL
Date:   Thu, 19 Aug 2021 14:13:36 -0400
Message-ID: <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFiQNuw5Jq9CnWXA2eVMek+endVO6xlycnA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 19, 2021 1:59 PM, Jonathon Anderson wrote:
>
>I'm having an issue with git modifying a DLL file and corrupting it.
>When I download the original working file, it has a hash starting with 8FE400... I then commit the DLL and push it to our repo. When I
>download the file from the repo, the DLL can't be loaded, and it has a hash starting with E004FB...
>
>Opening the DLL in a hex editor and using the compare feature, there's a single change to the file. In the original, the byte code starting
>at 0x0074 is 2E 0D 0D 0A 24.
>In the git file, the byte code starting at 0x0074 is 2E 0D 0A 24
>
>A single carriage return character (0x0D) has been removed, and the file size has changed from 260,608 bytes to 260,607 bytes.
>
>I ruled out the possibility that the repo server was doing anything to the file because I deleted the file in my local repository then ran "git
>reset --hard HEAD" to restore the file, and the hash had once again changed to E004FB...
>
>OS: Windows 10.0.19043 pro
>git: 2.32.0.windows.1
>
>I have no settings configured for git behavior handling line endings.
>
>The original DLL can be found here:
>https://www.powershellgallery.com/packages/PSWindowsUpdate/2.1.1.2
>
>Navigate to "Manual Download", download the nuget package and unzip it. The file is PSWindowsUpdate.dll

Have you set up an entry for *.dll as binary in your .gitattributes file?

-Randall

