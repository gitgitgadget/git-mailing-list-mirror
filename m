From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to prevent empty git commit --amend
Date: Tue, 13 Jan 2015 12:20:48 +0100
Message-ID: <54B4FF90.2050306@drmicha.warpmail.net>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>	<CACx-yZ12mn-EyR5Mx9rmACLtyeYWRdyef4jDqdFAPzeQDm03ug@mail.gmail.com> <CA+iO_8niTScwtYVRV-5wBNHOzr08k=1Vug0yH3+vQ-Y9GgyJKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ivo Anjo <ivo.anjo@ist.utl.pt>,
	Daniel Knittl-Frank <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 12:21:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAzWv-0005Z5-K2
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 12:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbbAMLUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 06:20:54 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55552 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101AbbAMLUu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2015 06:20:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 171AF20A54
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 06:20:50 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 13 Jan 2015 06:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=RWx8+dysJU0ek/Ofhuc+jD
	Rmwdg=; b=pnZgOHLLvA5j83jzTAIZejpCxBdE/AU41ydb29fLtwYlBLeb2g4sNF
	UteUk4AK32PufN22lHU8jswVj6hCsaamVIsAjaQwr2T0uOAxcITKq1Yd8gS5GvdM
	JX2wQB23XfTaTp8cyPLFzvx1HvT01obuQioORse6Nvl59ERm2Bkbo=
X-Sasl-enc: cBSOLR/yAtn61m6HwOY0L7TFOPAyJjkVsECWiitTcQ/R 1421148049
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7B0A7680107;
	Tue, 13 Jan 2015 06:20:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CA+iO_8niTScwtYVRV-5wBNHOzr08k=1Vug0yH3+vQ-Y9GgyJKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262335>

Ivo Anjo schrieb am 13.01.2015 um 11:22:
> Hello Daniel,
> 
> Thanks for your answer!
> 
> My issue is not with cancelling the amend commit, is that because the
> amend commit already lists changes to the files I am working on (those
> changes that already went in the commit I was ammending), I don't
> realize that I forgot to add what I changed. For instance:
> 
> $ echo "Hello" >> readme.txt
> $ git add readme.txt
> $ git commit -m "Add readme"
> 
> $ echo "World" >> readme.txt
> $ git commit --amend
> 
> now if I just save and close the editor git will say it committed
> successfully (which it did), but in reality nothing at all happened.
> 
> Of course I can check the status or some other things before/after the
> amend commit, but since end up doing this error sometimes I was hoping
> I could set up git to stop me from doing it.

"git commit --amend" is (also) the way to edit the last commit message,
and for that you need to be able to do an "empty" amend.

In your example above, git will also tell you that you have unstaged
changes to readme.txt.

If that isn't enough, you can use "-v" to display the diff in the editor
(and remove it).

Michael
