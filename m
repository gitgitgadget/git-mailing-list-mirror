From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 06:58:34 -0700
Message-ID: <7vehc4ssj9.fsf@alter.siamese.dyndns.org>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
	<20130614130910.GF23890@serenity.lan>
	<CALkWK0=dN4oqgvu9FL+EpqyekoQ385tTGbd3Gnf4mee-eTBeOA@mail.gmail.com>
	<20130614132102.GG23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:58:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUWY-0006Lf-CK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab3FNN6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:58:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049Ab3FNN6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:58:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1FCB25902;
	Fri, 14 Jun 2013 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vwGMq6syszdzWx8qc6AktJy/tfg=; b=U4Hll2
	bXcHxi0Ttw5kHm36QFow6N47NIOneCxwiBYcC2tCU22k7STMhW9B3b7gIET1Df/L
	SaDvMCdikQHgRB7wkmZ93ThE/sfJ/Ly+wDam7ZVB8G/xczbRJeqszpKrDJfztvFL
	i0r7v1wC/Bjp4eV7hSDLs1QPPi4/wLUhs4iSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=utrCrwxfyRmLhdhkEGCI9FVSy1Wuix6i
	A1F32nvpDn/Q2NYr18jAuyrNteiK5/LXzvHQqnBTMnRHGrsGZ31CKelobfuqCh4E
	YQuz7NjsEjVFY5gzf1TGWBUqO1CE/dYI1XgacuwkNJWpJ5EFxR1pfsaZSU03Z/Vy
	XNAdnN6Il+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72A225901;
	Fri, 14 Jun 2013 13:58:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B6EC258FC;
	Fri, 14 Jun 2013 13:58:36 +0000 (UTC)
In-Reply-To: <20130614132102.GG23890@serenity.lan> (John Keeping's message of
	"Fri, 14 Jun 2013 14:21:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81F6B83E-D4FA-11E2-B992-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227872>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Jun 14, 2013 at 06:45:19PM +0530, Ramkumar Ramachandra wrote:
>> John Keeping wrote:
>> > I don't think this is the correct behaviour.  I can think of cases where
>> > I would want to output multiple things into the same directory.
>> 
>> format.cleanOutputDirectory = true|false?
>
> Maybe, but I was thinking of something more like:
>
>     Output directory is not empty, use "--allow-non-empty-dir" if you
>     really want to proceed.
>
> Using that configuration variable lets someone shoot themselves in the
> foot quite badly if they forget that they have set it and set the output
> directory to somewhere containing important data.

Yes.  format.refuseToOutputToNonEmpty that defaults to false and
gives your error message is a sensible way to go.
