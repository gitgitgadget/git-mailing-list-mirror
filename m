From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 15:07:37 -0700
Message-ID: <7vty9rv9p2.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:07:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqXz8-0000jw-Vl
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab1HHWHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:07:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab1HHWHk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:07:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 574995997;
	Mon,  8 Aug 2011 18:07:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=82fU+qKLKMfu98H/yh4wj/JB5so=; b=wpOUHb
	7KKkQVFoRYpfXi0S1MkC/ZjpNjeaZV/cu/etK1u3YPhipB10wHRhjhnbSYGBa8ef
	cwmhwuvuS0l3SpsRk6wwdgxySSfXubEMLFEPsb4vJfFPS/ys0ylZVShHDcyKTBZ5
	0lNx2lYk9hiG6JDa+It3o/He9N+KPnAfOiq04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKYHKA08qczSwao01U21Nhi2H99HhbmI
	YdetrQiixbTv5DFCUfRSTWOl9ZC097zhhWdeUuDe8CfjGZ1PLEzPI/4P672S+pp6
	llDwCH8IvtfyWDqfPbyVXOfWMWxOtnQ9rQEUl94YQnRNyNMkAQIOxsXQdGmSnKPK
	NHUbkR+/nxc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E4B35996;
	Mon,  8 Aug 2011 18:07:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B14785995; Mon,  8 Aug 2011
 18:07:38 -0400 (EDT)
In-Reply-To: <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 8 Aug 2011 23:27:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D44214E4-C20A-11E0-9E22-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178992>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Nobody needs the stuff you mentioned right now.

Wrong.

"diff ^C A B" is a bug, isn't it? And that is a bug in the current code.

>> I would be reluctant to accept a myopic hack that is only good for one
>> caller and that needs to be ripped out and re-done, especially when we
>> already know other issues that can be solved cleanly if you go a little
>> further in the initial round.
>
> While I understand this reluctance, remember that this "one caller" is
> required to fix a bug in the current code.
