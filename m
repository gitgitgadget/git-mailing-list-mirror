From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sat, 10 Nov 2012 18:28:18 +0100
Message-ID: <509E8EB2.7040509@drmicha.warpmail.net>
References: <5093DC0C.5000603@drmicha.warpmail.net> <20121108200919.GP15560@sigill.intra.peff.net> <509CCCBC.8010102@drmicha.warpmail.net> <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 18:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXEsD-00061k-5j
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 18:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab2KJR2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 12:28:22 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39566 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184Ab2KJR2V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 12:28:21 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AA60B20766;
	Sat, 10 Nov 2012 12:28:20 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Sat, 10 Nov 2012 12:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=opLmlTETqwHFWBMnCd7e9z
	GiTvo=; b=sdDeOnJVpmqIddYcWHTeoLkcKYqi4aVVQD+oxJVDixTBcLL3z4S57D
	6+ocLaQwm62s3XnYLfAQcAFnAc4U76zCLz85DpcH86x/VudrBUGsE++g1J3wU0TX
	0ZxR9D91jCJplHMA5KQaMxflU9UnLFsJ21StFq4idaGbcMbb0tb/o=
X-Sasl-enc: cwKDyMVKQdeNDbDXiqmZeaXf6t8fnrrlzChLz7VsruTP 1352568500
Received: from localhost.localdomain (unknown [88.71.237.31])
	by mail.messagingengine.com (Postfix) with ESMTPA id D5E6B8E00A4;
	Sat, 10 Nov 2012 12:28:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209285>

Felipe Contreras venit, vidit, dixit 09.11.2012 15:34:
> On Fri, Nov 9, 2012 at 10:28 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> 
>> Hg seems to store just anything in the author field ("committer"). The
>> various interfaces that are floating around do some behind-the-back
>> conversion to git format. The more conversions they do, the better they
>> seem to work (no erroring out) but I'm wondering whether it's really a
>> good thing, or whether we should encourage a more diligent approach
>> which requires a user to map non-conforming author names wilfully.
> 
> So you propose that when somebody does 'git clone hg::hg hg-git' the
> thing should fail. I hope you don't think it's too unbecoming for me
> to say that I disagree.

There is no need to disagree with a proposal I haven't made. I would
disagree with the proposal that I haven't made, too.

> IMO it should be git fast-import the one that converts these bad
> authors, not every single tool out there. Maybe throw a warning, but
> that's all. Or maybe generate a list of bad authors ready to be filled
> out. That way when a project is doing a real conversion, say, when
> moving to git, they can run the conversion once and see which authors
> are bad and not multiple times, each try taking longer than the next.

As Jeff pointed out, git-fast-import expects output conforming to a
certain standard, and that's not going to change. import is agnostic to
where its import stream is coming from. Only the producer of that stream
can have additional information about the provenience of the stream's
data which may aid (possibly together with user input or choices) in
transforming that into something conforming.

Michael
