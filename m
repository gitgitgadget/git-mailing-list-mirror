X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Tue, 21 Nov 2006 16:47:46 -0600
Organization: Freescale
Message-ID: <45638212.8030501@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org> <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org> <456330CD.9080503@freescale.com> <20061121183941.GB22283@spearce.org> <45637457.1010505@freescale.com> <Pine.LNX.4.63.0611212306060.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 22:48:13 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <Pine.LNX.4.63.0611212306060.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32049>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmePG-00052k-Bh for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031245AbWKUWrz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031255AbWKUWrz
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:47:55 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:65271 "EHLO
 de01egw01.freescale.net") by vger.kernel.org with ESMTP id S1031245AbWKUWry
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:47:54 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
 kAM09Xi1008804; Tue, 21 Nov 2006 17:09:33 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kALMlkPR015228; Tue,
 21 Nov 2006 16:47:46 -0600 (CST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 21 Nov 2006, Timur Tabi wrote:
> 
>> Shawn Pearce wrote:
>>
>>> finally you can either run from that directory (see INSTALL file)
>>> or you can install the binary somewhere else.  We don't really
>>> recommend using `pu` for production level work, so make sure you
>>> have a backup of any repository you run it on.  :)
>> So how do I make a shallow clone?  I've set it all up, but there is no
>> git-shallow-clone command, and git help clone doesn't have anything either.
> 
> Try "git clone --depth 1 <url>". This will cut each ancestor chain after 
> one ancestor (IIRC).

I think you mean git-clone.sh instead of git-clone.  If I do the above command, 
I get:

$ ./git clone --depth 1 git://127.0.0.1/temp/u-boot-83xx/
Usage: /home/b04825/bin/git-clone [--template=<template_directory>] 
[--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] 
[-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]

However, git-clone.sh is not quite working either.  I had to run git-daemon on 
my machine, because git-clone.sh doesn't like the http protocol, and my firewall 
blocks everything but that.  So I cloned a repo, started git-daemon, and I tried 
this:

$ ./git-clone.sh --depth 1 git://127.0.0.1/temp/u-boot-83xx
usage: git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=upload-pack] 
[host:]directory <refs>...
fetch-pack from 'git://127.0.0.1/temp/u-boot-83xx/' failed.

A regular git-clone of git://127.0.0.1/temp/u-boot-83xx works, so I think 
there's something wrong with git-clone.sh or my invocation thereof.

-- 
Timur Tabi
