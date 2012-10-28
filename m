From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Sun, 28 Oct 2012 21:48:18 +0100
Message-ID: <508D9A12.6010104@web.de>
References: <20121023204437.GE28592@odin.tremily.us> <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us> <50883E54.4080507@web.de> <20121025005307.GE801@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Nahor <nahor.j+gmane@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Oct 28 21:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSZml-0004c4-45
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 21:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab2J1UsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 16:48:24 -0400
Received: from mout.web.de ([212.227.17.11]:57881 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755671Ab2J1UsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 16:48:22 -0400
Received: from [192.168.178.41] ([91.3.156.115]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MCZP8-1TbxRp1UmI-009Y6Z; Sun, 28 Oct 2012 21:48:19
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121025005307.GE801@odin.tremily.us>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:bcS1pUVWh3aHf/Oks0vl16kV9zd5N3RXnD3z3LEowwL
 hrd0M6+gOQuots8hoMtdvkZsZi27bApECY3AGCOoSGqP5t9nRv
 PyauktLrI2nOoNn+mK4jFcerwquSLsg6/pEpF9mLK/eycGyhtS
 T5FksgSC4/xlgWEBx3/8yYZyFsOy5Y2Bd+e0offiFRVMv0+Jqr
 RqRtjYzwMxbj3WyNNuFNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208564>

Am 25.10.2012 02:53, schrieb W. Trevor King:
> On Wed, Oct 24, 2012 at 09:15:32PM +0200, Jens Lehmann wrote:
>> I still fail to see what adding that functionality to the submodule
>> command buys us (unless we also add code which really uses the branch
>> setting). What's wrong with doing a simple:
>>
>>    git config -f .gitmodules submodule.<path>.branch <record_branch>
>>
>> on the command line when you want to use the branch setting for your
>> own purposes? You could easily wrap that into a helper script, no?
> 
> Sure.  But why maintain my own helper script if I can edit
> git-submodules.sh?  It seems like a number of people are using this
> config option, and they generally store the same name in it that they
> use to create the submodule.  This way I can save them time too.

But people are already using the "branch" setting in *different* ways:

Am 23.10.2012 22:55, schrieb W. Trevor King:
> As Phil pointed out, doing anything with this variable is ambiguous:
>
> On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
>> Some projects now use the 'branch' config value to record the tracking
>> branch for the submodule.  Some ascribe different meaning to the
>> configuration if the value is given vs. undefined.  For example, see
>> the Gerrit submodule-subscription mechanism.  This change will cause
>> those workflows to behave differently than they do now.

I don't have a problem with the amount or complexity of the code being
added, But by adding that option we may be giving the impression that it
is officially sanctioned, or that it will be kept up to date by further
submodule commands. I added Shawn to the CC, maybe he can comment on how
the "branch" setting is used in Gerrit and what he thinks about adding
code to set that with "git submodule add -r <branch> ..." to core git.
