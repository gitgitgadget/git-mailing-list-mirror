From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Tue, 17 Jan 2012 08:41:45 +0100
Message-ID: <4F152639.9010505@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de> <4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de> <20120116190956.GA13802@sigill.intra.peff.net> <4F1494AA.1000004@unclassified.de> <20120116212709.GA21770@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, git@vger.kernel.org,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 17 08:42:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn3gE-0008DZ-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 08:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab2AQHly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 02:41:54 -0500
Received: from dotforward.de ([178.63.102.138]:42350 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab2AQHlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 02:41:53 -0500
Received: from dsl01.83.171.184.42.ip-pool.nefkom.net ([83.171.184.42] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1Rn3fu-0006CF-Tb; Tue, 17 Jan 2012 08:41:47 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120116212709.GA21770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188697>

On 16.01.2012 22:27 CE(S)T, Jeff King wrote:
> On Mon, Jan 16, 2012 at 10:20:42PM +0100, Yves Goergen wrote:
> 
>> On 16.01.2012 20:09 CE(S)T, Jeff King wrote:
>>> What is the output of "git config core.ignorecase" in your repository?
>> None, i.e. an empty line.
> 
> That's odd. When the repository is first created, git will do a test to
> see whether the filesystem supports case-sensitivity, and will set
> core.ignorecase if it does not. Might this repository have been created
> on a different filesystem, and then moved onto the case-insensitive
> filesystem?
> 
> Or might it have been created by something other than core git? I don't
> know whether one can create a repo in TortoiseGit, or if so how it does
> so.

It may have been created through the Visual Studio source provider for
Git, which is configured to use TortoiseGit which in turn uses msysGit.
But I have not written any of those programmes so I cannot guarantee for
what they do.

> In any case, try doing:
> 
>   git config core.ignorecase true
> 
> and see if that clears up your problems.

'git config core.ignorecase' now outputs "true" but I can still commit
the same file (modified) twice. So this doesn't help.

Meanwhile I have browsed my other code projects and found that the
designer-generated file name is sometimes with a "D" and sometimes with
a "d", so it's usually inconsistent. I haven't figured out where that
comes from but it means that this is a common issue that Git needs to
handle well to be usable on Windows. But we're not there yet.

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
