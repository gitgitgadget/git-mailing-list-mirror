From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Updating a submodule with a compatible version from another submodule
 version using the parent meta-repository
Date: Wed, 26 Jan 2011 20:06:01 +0100
Message-ID: <4D407099.4010805@web.de>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com> <AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 20:06:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiAh1-0008KW-83
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 20:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab1AZTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 14:06:04 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:48603 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1AZTGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 14:06:03 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id EBF64184F4F39;
	Wed, 26 Jan 2011 20:06:01 +0100 (CET)
Received: from [93.246.34.225] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PiAgr-000832-00; Wed, 26 Jan 2011 20:06:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX191WPsv0pY5usCBcy2lgoeCDPEddVV5t2GYyoJ3
	XVShDV3710bauRqrfF2/EUm6VBEwOLT9IMRyCaGmPUNiVKNIsE
	aSsf0iknEkk5hLpXnkvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165531>

Am 26.01.2011 19:32, schrieb Julian Ibarz:
> I am using git submodule in one of my professional projects and I am
> facing an issue when I am using git bisect in one of the submodules.
> 
> Basically I have a meta repository which I will call A and two
> submodules B and C. Sometimes I use git bisect in B but it is
> dependent on C so when I go back too much in the history of B, C needs
> to change its version to a compatible one. Doing this manually is
> really time consuming for me and I guess a lot of people have this
> issue so I was a little bit surprise to not find easily anything on
> the net that permits to do this automatically.

What about bisecting in A (doing "git submodule update" after every
step) to bisect to a smaller range of commits in B (which are then
not dependent on your submodule C anymore and can be bisected inside
B)? This of course assumes A properly records the dependencies
between B and C.

> Is there anything existing to do that and I just didn't find it yet?
> If not I think I might have an implementation idea I would like to try
> out.

The call to "git submodule update" after each bisect step in the
superproject will be obsolete as soon as the recursive checkout
I am currently working on is done, but that is not here yet.
