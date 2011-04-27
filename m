From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 09:57:48 +0200
Message-ID: <4DB7CC7C.2050508@drmicha.warpmail.net>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>	<7vsjt49stq.fsf@alter.siamese.dyndns.org>	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org> <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 09:57:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzdE-0004Wi-KS
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 09:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab1D0H5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 03:57:51 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53459 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754170Ab1D0H5u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 03:57:50 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2865220D42;
	Wed, 27 Apr 2011 03:57:50 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 27 Apr 2011 03:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ydMIrA7B7RXiarpAtRw1eJZ6FLk=; b=XvwjifClD6Zrax67qEACdaXOOuYahphuOYg69DW2ygZ+La+GnFLgqjNlhQfbTyc7y1fe6X/eK8F7b8NsjALNiM/jI5TLjypKl8KCdXR98ztC9I0Ep3XSixwYOqJFhkiR23THvETfctQEFxNBQrGQHu4J0M9uBVh+MQc0Rv1bbSI=
X-Sasl-enc: 8M31Kr7K7G7bj8OspQgQEDjhVr9hdMcXqtL/Z+yaUuG1 1303891069
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8642340044A;
	Wed, 27 Apr 2011 03:57:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172185>

Jon Seymour venit, vidit, dixit 27.04.2011 09:15:
> On Wed, Apr 27, 2011 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>> My thoughts about this are inspired by how the node project manages
>>> packages with its npm package manager and also the fact that I have
>>> several ideas on the boil at the moment that would definitely benefit
>>> from a standard way to manage these concerns.
>>
>> Sounds like you have a plan ;-)
>>
> 
> Ok, here we go:
> 
>     https://github.com/jonseymour/gpm
> 
> Anyone who violently objects to the suggested name of a package
> manager interface - gpm, please speak up now because it'll be easier
> to change now.
> 
> (And yes, gpm is intended to be an *interface*. The idea would be to
> allow the interface to be back-ended by different implementations
> depending on taste, platform etc.).
> 
> I suggest using this list for discussion, but I also think the github
> issue manager would be a pretty good option.
> 
> Speak up if, you see anything wrong so far!

I'm sorry to spoil the party before it started but I'm not very fond of
having yet another package manager orthogonal to what distributions have
already. This is definitely not a way to get anything like that into a
distribution which has proper policies.

What we could need now to help users is a working "make -C contrib/foo"
to easily install selected features from our contrib area (with
"install" or "doc" targets), i.e. set things up so that we can have very
simple makefiles in contrib (with an include).

If you really want to go forward with a bigger solution, we could
distribute "extensions" by installing but not "activating" them, and
have some command which activates them selectively (like hg extensions).
That is something distributions could ship, although I don't see any
need for it personally. Our architecture makes it so easy to "integrate"
git-foo, git-foo.1 and config variables without touching the core git
installation at all!

Michael
