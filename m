From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 11:38:40 +0100
Message-ID: <5114D5B0.5080906@drmicha.warpmail.net>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com> <5113E849.8000602@elegosoft.com> <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com> <20130207233017.GD19397@google.com> <7v38x766b2.fsf@alter.siamese.dyndns.org> <20130208074813.GA7337@elie.Belkin> <7v622343uy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3lMI-0006Gb-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 11:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946133Ab3BHKim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 05:38:42 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60378 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030242Ab3BHKil (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 05:38:41 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4518D20C7D;
	Fri,  8 Feb 2013 05:38:40 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 08 Feb 2013 05:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ShCL8sTRbmdGvwe2GB57l/
	3bEDA=; b=FfhaxTU50o77pQcuWETqHrOX6ruDZcxzmrqdQDm2AZUZAFsWyt21cz
	rWhKfoWFnzI6TeiWqSu/VmZEZoHzfhP0TBXrKVaAYwY3DGpfpr0CD6vKogosoWPA
	WrOH+h3zJKBEvFm84nw9XPMM6gcH3XCZDCi4KtoH9QVxN6tdPn6Bc=
X-Sasl-enc: Fj6cmddL1AYFmVNcn35mPTrncNaNba3R/ERc163WIujL 1360319919
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F156E482493;
	Fri,  8 Feb 2013 05:38:38 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7v622343uy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215772>

Junio C Hamano venit, vidit, dixit 08.02.2013 09:16:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> "Wait, why did the remote rewind?"
> 
> Oh, I am very well aware of that glitch.
> 
> "git push" has this hack to pretend as if the pusher immediately
> turned around and fetched from the remote.
> 
> It shouldn't have been made to do so unconditionally; instead it
> should have been designed to give the pushee a way to optionally
> tell you "I acccept this push, but you may not see it to be updated
> to that exact value you pushed when you fetched from me right now".
> 
> The hack is not my design; it was not even something I accepted
> without complaints, so I can badmouth about it all I want without
> hesitation ;-)
> 
> More importantly, we could fix it if we wanted to.

And this seems to be more natural, too. It can keep the internals (the
auxiliary ref on the server side) hidden from the user.

As for the triangle remote, I really think we should clean up the
situation regarding push, pushurlinsteadof and the various different and
inconclusive output formats of "git remote" (with or without "-v", with
or without a remote name) first, before introducing yet another way to
twist things around. "git push downstream" does not hurt any kittens
(while git remote ouput does, somehwat).

Michael
