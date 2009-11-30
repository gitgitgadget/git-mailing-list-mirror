From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 00:28:19 -0800
Message-ID: <7v4oocwh5o.fsf@alter.siamese.dyndns.org>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com>
 <20091130075927.GA5767@coredump.intra.peff.net>
 <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1ci-0001n2-GM
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbZK3I2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbZK3I2b
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:28:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbZK3I2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:28:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06978A2887;
	Mon, 30 Nov 2009 03:28:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+646+hiiyluQJmSh/+qBmCrShak=; b=xiNch2
	+HTKV2sdcouLbxPQOJEY8x4AviltZIkHqSpRId+rnhDw7OJyHXhruoSqiKdHxa3g
	pcUFdzhwImn24F6QDia+Y4f9Im9UxzG7Fppw9zSej7F6Z7TPHcLa2xMxLKqKilns
	xIxCzOBLJGBiUqap6JuGSzrXqtIKqVmrVijFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oxYoEE9utRRkMW8L4e0z1vZGFYkNu6Tz
	P0DG97YRLoGSvpHzzbtkW72mvt1QQBGF1Vh3/fvq0fJuaVcLyiIBikwiHTKJ3rum
	dZK/xiuw780ML0JFxU/9ww7Dg8Uu1W3vUAUQH26Txt1e2bm+HxKRU+3eG3VQ3RT3
	FLrQ546jFHc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD9BEA2886;
	Mon, 30 Nov 2009 03:28:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 86F0CA2883; Mon, 30 Nov 2009
 03:28:22 -0500 (EST)
In-Reply-To: <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 30 Nov 2009 09\:04\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57D7F2C2-DD8A-11DE-A938-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134081>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Nov 30, 2009 at 08:59, Jeff King <peff@peff.net> wrote:
>> I mean, I would think that the "git_remote_helpers" directory contained
>> remote helpers of all sorts, not just the python ones.
>
> I don't think that's true, git.git currently does not have such a
> structure (everything is just dumped in the root directory). The only
> reason git_remote_helpers exists is to make it easier to create a
> python egg out of it and install that.

If that is the case, shouldn't each of the helper written in Python need
to have a separate directory, not just a single git_remote_helpers
directory shared among them?
