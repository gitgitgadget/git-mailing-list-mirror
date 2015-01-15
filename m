From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: cosmetic bug: "git show --pretty:format" produces different output
 than "git show --format"
Date: Thu, 15 Jan 2015 17:23:39 +0100
Message-ID: <54B7E98B.6020907@drmicha.warpmail.net>
References: <CAEKevnWfFq9gyN8Ga8zXUDwk_+Mk6RK0HVT-+sbejjVPw0U0=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Francesc Zacarias <francesc@spotify.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 17:23:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBnD1-0006Ap-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 17:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbbAOQXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 11:23:44 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40473 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755087AbbAOQXn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 11:23:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DF02321364
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 11:23:42 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 15 Jan 2015 11:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Wp/SbjYEql+vFXw1qQVZcW
	ysM58=; b=hTlRsZbqIohBOmOaUthHaukk9AAHvLBKC7gopQmVqTulISkZAU3Ydp
	EapObp3vhQhVX3O2gJsxmxJzhTAFh6cviXFPxfXypTpgcwgZP1TmBS/GmlUOx8iD
	PKPLWPaiGMPjYtcjC08mUQP65gfBbpcOJqpX6BuJWSaU1VQ/lOR8c=
X-Sasl-enc: Z7RfMAY0Sgp5zgAzFJzUQQn4tBiLsAAKplPWUXGszqYe 1421339022
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5E0E36800D3;
	Thu, 15 Jan 2015 11:23:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAEKevnWfFq9gyN8Ga8zXUDwk_+Mk6RK0HVT-+sbejjVPw0U0=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262485>

Francesc Zacarias schrieb am 15.01.2015 um 14:55:
> Hi!
> 
> I noticed that git produces differing output for
> "git show --pretty:format show" and "git show --format", even though
> the man page says that both are equivalent.
> "git show --format" always appends an empty line at the end. The only
> way I've found to get rid of that empty line in --format is by adding
> -s option.
> 
> So, "git show --pretty:format" and "git show -s --format" do produce
> the same output.
> 
> I can reproduce this issue in Ubuntu Trusty (git version 1.9.1) and
> Debian Jessie (git version 2.1.4).
> 

The first part of the man page is a bit sloppy, but refers to the FORMAT
section. There, it says that "--pretty" is equivalent to
"--pretty=tformat:" which is different from "--pretty=format:".

Unfortunately, "--format" seems to be parsed as ("--pretty" and
therefore?) "--pretty=tformat:" which I consider a bug.

Michael
