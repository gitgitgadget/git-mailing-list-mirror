From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 16:35:31 +0100
Message-ID: <492D6CC3.2050408@drmicha.warpmail.net>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com> <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 16:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5MRn-0007zS-H8
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 16:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYKZPfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 10:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbYKZPfi
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 10:35:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46859 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269AbYKZPfh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2008 10:35:37 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 94D761C62B2;
	Wed, 26 Nov 2008 10:35:34 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 26 Nov 2008 10:35:34 -0500
X-Sasl-enc: G4BEdhPD+6RuYWzlletoJwms664z1XeO2TPnUDIuwR/P 1227713734
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ABEFD3ABD;
	Wed, 26 Nov 2008 10:35:33 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101740>

Ondrej Certik venit, vidit, dixit 26.11.2008 11:18:
> On Wed, Nov 26, 2008 at 10:35 AM, Ondrej Certik <ondrej@certik.cz> wrote:
>> On Wed, Nov 26, 2008 at 1:14 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi,
>>>
>>> On Tue, 25 Nov 2008, Ondrej Certik wrote:
>>>
>>>> I would like to export our whole git repository to patches, and then
>>>> reconstruct it again from scratch. Following the man page of "git
>>>> fast-export":
>>>>
>>>> [...]
>>>>
>>>> However, the repository is very different to the original one. It
>>>> contains only 191 patches:
>>> Can you try again with a Git version that contains the commit
>>> 2075ffb5(fast-export: use an unsorted string list for extra_refs)?
>> I tried the next branch:
>>
>> $ git --version
>> git version 1.6.0.4.1060.g9433b
>>
>> that contains the 2075ffb5 patch. I haven't observed any change ---
>> the "git log" still only shows 191 commits (git log --all shows
>> everything).
> 
> I deleted all tags and then fast-exported and imported, now all the
> commits show in "git log", however, the patches are wrongly connected.
> Basically, both repositories are identical (including hashes) up to
> this commit:
> 
> d717177d4  (fixed downloads instructions in the README and a typo)
> 
> However, the original repo (sympy-full-history-20081023) contains 3
> children at this commit:

There's some nice 3 way branching and double 2 way merging going on. I
cut out the interesting part of the graph, making d717177d4 and
6e869485f parentless. The resulting mini DAG is reproduced correctly by
export|import, even with -M -C.

Michael
