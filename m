From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 07 Oct 2011 22:40:28 +0200
Message-ID: <4E8F63BC.1060401@drmicha.warpmail.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org> <4E8EBDA7.2040007@drmicha.warpmail.net> <20111007091636.GA22822@elie.hsd1.il.comcast.net> <4E8ECA25.205@drmicha.warpmail.net> <20111007100646.GA23193@elie.hsd1.il.comcast.net> <4E8EED39.1060607@drmicha.warpmail.net> <20111007195023.GA29712@elie.hsd1.il.comcast.net> <7v1uuovahm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 22:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCHDv-0001I1-4h
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692Ab1JGUkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:40:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35094 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569Ab1JGUkb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 16:40:31 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E43C20B1E;
	Fri,  7 Oct 2011 16:40:31 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 07 Oct 2011 16:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=z5ww1qO76ITVDZaT+CVS0A
	YwREs=; b=FR23DLG2YGCA0jkNtA2muf/n3vOg4g6k9GA19pXuU7vqxcNNRt/azY
	8wzTyMc7uztcGh52RbM5eWuxhtcq0OFUmX/VaGyHNfsvScg4mfJDa+SyGHpf7Szn
	hs9hLLAFMbOYuxoGu6k4JeZrZFExuaMEK3IyocyaOTjnsvNLGHEHo=
X-Sasl-enc: nmsGHZsBb4up3B+gMydSqbLY/nv9Ee9MFrZqhkGrSbpZ 1318020030
Received: from localhost.localdomain (p548598D0.dip0.t-ipconnect.de [84.133.152.208])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5C6CFCA084C;
	Fri,  7 Oct 2011 16:40:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7v1uuovahm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183109>

Junio C Hamano venit, vidit, dixit 07.10.2011 21:59:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> I am surprised that you seem to have missed what I meant by "branch
>> names are local"....
>> This matters, a lot, because there is no easy way to partition a
>> namespace of names descriptive for humans without a central authority
>> to negotiate conflicts.
> 
> I think we are in total agreement.  The branch names are local, but the
> users may want to annotate to describe _the history_ they intend to build
> on it.
> 
> Various ways to convey the description when the end product (i.e. the
> history built on it) is shiped were outlined in the series, so that the
> shipper can help the receiver understand the history. The information in
> the annotation (i.e. the _value_ of branch.$name.description) is something
> the shipper wants to share with the receiver, but the mapping between the
> local name of the branch the shipper used to build that history (i.e. the
> key "$name" in branch.$name.description) is immaterial in the end result.

It just seems we judge the "local" aspect completely differently. The
point that I don't get is: How to share a branch without sharing a
branch name? You cannot. Of course you may "change the name" during the
push, or during a fetch, and at that point you know both and can map the
description.

Note that I'm not tied to the notes implementation. But versioned branch
descriptions would be nice for several purposes, for example series
cover letters, or descriptions on long lived feature branches. And I
don't see how else to have versioned descriptions.

Also, for transporting descriptions via config, you have to have an
updated git on the server side, whereas anything object/ref based would
work now, right?

Michael
