From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 13:23:06 -0500
Message-ID: <4F85CC0A.1020602@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411060357.GA15805@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:23:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2CI-0004e5-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621Ab2DKSXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:23:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53656 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab2DKSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:23:08 -0400
Received: by obbtb18 with SMTP id tb18so1542030obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DdIwfSHqC/jslEC5k9kdLzFLH1466dCwglNFhIaSeqM=;
        b=eh44NVGGIuomLpzK2a0h9H+yHGCkYTl00noSGBzcmASIielYgptiD3Dk6YbHQh/9t7
         Gz1BId/WdnFDVe/vsTqPhZSFhmfzZoMZl953CiNcFgFph6OU+/r6gdgIYrj6SMa2s1po
         0fRQ+wVVhZkUWmmdIckH51A4Hodgf5RwB4Y1pYk6AWTr79jEdNorTTGDe0o9m82z9JHx
         IGZz6vMSCGWFZTSB6aF1wGy3TT+DoJcO3WZenEXyklu+CGSSE3gtimFYJdWaWTTdBcnN
         69M+XWuwUev7JUCai6DGgLKYdOisVmFvKc84ZM+VG+ZlRW4kva4jTxrduZmH+ub0njAK
         Xd9w==
Received: by 10.182.7.4 with SMTP id f4mr21464096oba.57.1334168587905;
        Wed, 11 Apr 2012 11:23:07 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id yv3sm3648612obb.3.2012.04.11.11.23.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 11:23:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120411060357.GA15805@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195230>

On 4/11/2012 1:04 AM, Jonathan Nieder wrote:
>
> I would suggest tracking source code instead of binaries if
> possible, though.
>
Reasons why we want to track binaries:
(1) Standard Targets: Our deployment is assembly line style because our
target servers are under our control.
(2) Copy vs. Recompile:  We run certain "supported" linux distro
versions on our target servers so we can just put our binaries on them
instead of recompiling.
(3) In-house-Source Compiled Binaries:  For our particular proprietary
(third-party) source language the binaries run on top of a runtime that
runs on top of the O/S so that makes the need to recompile on a server a
non-issue.  We use xxd and compile listings to "diff" our compiled
binaries to detect missing copybook and data dictionary dependencies 
(missed recompiles), unnecessary recompiles (you didn't really change 
what you thought you changed), and miscompiles.  We do this compiled 
binary validation in git branches and then diff the branches to detect 
the discrepancies.
(4) Proprietary-Third-Party Binaries (no source) Versioning:  For our
third party binaries we don't have the source.  The are distributed as
self-extracting-executables.  Changes to third party binaries are
relatively infrequent but frequent enough to cause confusion and
therefore need to be tracked.
(5) Graphics "Source" Versioning:  Our graphics files are part of our
software and changes need to be tracked.
(6) O/S Versioning:  Our linux distro is tracked in a bazaar repo so
I'm thinking we should be able to track it in a git repo instead.  The
assembly line just deploys the payload to a new server instead of doing
manual install.
(7) Superproject tracking of "Super-release":  The above subsystems are
related in varying degrees (dependent).  A superproject can associate
all the versions that comprise a "super" release of the various
subsystem version dependencies.

While some of the reasons above may be non-normative for some git-users,
I think that a large portion (if not the majority) of git-users will
find some subset of the above reasons normative for their use-cases
(namely reasons 5 and 4) therefore making the necessity for binary
tracking normative for git-users in general.

v/r,
neal
