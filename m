From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 12:23:24 -0700
Message-ID: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net> <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com> <4D948105.3050009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:23:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5NTA-0004g2-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab1CaTXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:23:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222Ab1CaTXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:23:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B0E73B41;
	Thu, 31 Mar 2011 15:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w2bUC/T92PtljVxX0w4EGMp5/F8=; b=gmG3vN
	phu0yV0wjZQz/G9PEPIgjyGmTWkvt9eFqIw9tWDwvdWqPV59Geo+aZiOzhbbjAHY
	39q9JQobQ64DV26EGsn8vJ9kWUF/uBljXqzEAtxR5bjAdi+MWxK/Vbfh9CUYjqll
	DBudCojwhflXKoSui8+XAoh4knUKoaKq9jL/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q1HdSPibNpTj6b0yxeF+yJ/EYZCVGJtt
	G4Vyp9HFoEmyzsGhcSYQ+4E3Uoi8FuOBU+OST0cIoxwQzSFjyyYd6ykOzEHO6soD
	h7NnJwZk8kf9flTSud8st6VNYNyBoZzfebZtCqQnOQKfCCnwkOizgS+o7hymuuqv
	Pgf0XlE4Bu8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 163153B40;
	Thu, 31 Mar 2011 15:25:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B1B823B3F; Thu, 31 Mar 2011
 15:25:15 -0400 (EDT)
In-Reply-To: <4D948105.3050009@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 31 Mar 2011 15:26:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E66A550-5BCC-11E0-A0DF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170520>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Tests please?
>
> Heck, we don't have any to begin with, and this is marked RFC. Given our
> usual reluctance to change even undocumented behavior I'm not going to
> bother with tests for an RFC.

Quite the contrary, a well written test is a concise and readable way to
illustrate what behaviour the proposed change is making, and helps judging
if it is going in a good direction.  So if it is an RFC, a test would help
very much, especially if there isn't any in the area currently.
