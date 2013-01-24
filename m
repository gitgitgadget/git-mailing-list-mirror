From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport.txt: cvsps-2 is deprecated
Date: Thu, 24 Jan 2013 12:58:02 -0800
Message-ID: <7vmwvy9u3p.fsf@alter.siamese.dyndns.org>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
 <20130123211237.GR7498@serenity.lan>
 <7vip6ndveb.fsf@alter.siamese.dyndns.org>
 <20130124191845.GS7498@serenity.lan>
 <7v7gn2bb5w.fsf@alter.siamese.dyndns.org>
 <20130124201330.GT7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:58:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyTsT-0005e9-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 21:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab3AXU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 15:58:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755701Ab3AXU6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 15:58:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8CBECB7B;
	Thu, 24 Jan 2013 15:58:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KtdNWpvwwcLu6jiVflvkK7KW4Co=; b=ycx1c4
	Kx1arWRGmwd4vrJ3gVn6k7e+V0r69L6/a6ViJ3/8i+yd8BrIWq2BHH0Mp7BBsFYO
	4hxpQijt+9CVrjmy2PafLWFYizMHFkiOAHmbDN1ugoEEpNvN8k7379LPNx4UfMFo
	Wj1rUiqny0r7QOK5yIh1Vu9FNKCo2CLQQvbPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVLOo2XPvc/DeC48MzrQOlAYiHsjtWEq
	u5/by0YFst3GI5imb5GqExdCubm5hyKYKZwNYUsHR0VzIxADGj2PABTYYiitQKXg
	P5Jj/CA5TRJZpCOQcdhPt75bF+XBs40Bp/q2B+p4upxJmagGo8jTMZM1ASL/5+LG
	dNNvGAphA90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA33ECB79;
	Thu, 24 Jan 2013 15:58:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4011CB75; Thu, 24 Jan 2013
 15:58:03 -0500 (EST)
In-Reply-To: <20130124201330.GT7498@serenity.lan> (John Keeping's message of
 "Thu, 24 Jan 2013 20:13:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BED410A4-6668-11E2-9B6E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214455>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Jan 24, 2013 at 12:04:11PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > git-cvsimport relies on version 2 of cvsps and does not work with the
>> > new version 3.  Since cvsps 3.x does not currently work as well as
>> > version 2 for incremental import, document this fact.
>> >
>> > Specifically, there is no way to make new git-cvsimport that supports
>> > cvsps 3.x and have a seamless transition for existing users since cvsps
>> > 3.x needs a time from which to continue importing and git-cvsimport does
>> > not save the time of the last import or import into a specific namespace
>> > so there is no safe way to calculate the time of the last import.
>> 
>> Isn't the whole "and git-cvsimport does not save the time..."  part
>> something that can be fixed in the new cvsimport that reads the
>> output from cvsps3?
>
> Yes it can be fixed there (and I have patches to do that) - my argument
> here is that there cannot be a seamless upgrade for people who are
> currently using git-cvsimport incrementally.  If you don't have that
> file then how do you create it to reflect the current state of your
> repository?

I am not disagreeing with your patch text to warn the current users
that cvsimport will be made unusable if they lose cvsps2, and they
are better off using other tools when doing a whole-history import.

I was trying to make sure that my understanding of the current
situation and future possibilities matches yours.

Thanks, I think you clarified the situation better with your
response.
