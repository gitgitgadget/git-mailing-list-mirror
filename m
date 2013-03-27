From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 15:15:44 -0700
Message-ID: <7vobe4jxpr.fsf@alter.siamese.dyndns.org>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <878v58worp.fsf@linux-k42r.v.cablecom.net>
 <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
 <20130327220723.GR2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Matthew Blissett <matt@blissett.me.uk>,
	David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKydl-0005T8-DW
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab3C0WPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:15:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753994Ab3C0WPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:15:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D40A7F7;
	Wed, 27 Mar 2013 18:15:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MFPUGkRGOijfp1A/SsR0TU5WLmQ=; b=M1VX2K
	Wq0SWokZfn6rfhoh804oEHpsUDvwM0FU2H4t3h0taxOY6FU6xX52Zcchhijl1qmn
	5eYLPQC4jjwRief4HkvTbx54aOFMiPdi73bkeFRbMmz2U+XpG2X6qCT82J3yhygU
	WbAT8951osDUFtkkfuyqCsd6FkJQw5HiUlaUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0OMMuxc3s6i8kwU9S9uV9vQZ/NMVpKU
	O0hIZr6mg+26SdxwUmpMbe+iz/udAAEpyqoDscpSvi3wPfP7MIISRmTXPK9Q3Fs2
	PY5ch7a+RuzGh0BWK0epThlio3STIz9oPdaq1HUmJY0oToleJ9VeRKF2IxlQyuHZ
	ImmAL73QoP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD120A7F5;
	Wed, 27 Mar 2013 18:15:47 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29BFBA7E9; Wed, 27 Mar 2013
 18:15:46 -0400 (EDT)
In-Reply-To: <20130327220723.GR2286@serenity.lan> (John Keeping's message of
 "Wed, 27 Mar 2013 22:07:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0000BCC-972B-11E2-96F2-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219340>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Mar 27, 2013 at 02:47:25PM -0700, Junio C Hamano wrote:
>> > * jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
>> >   (merged to 'next' on 2013-03-19 at e68014a)
>> >  + difftool --dir-diff: symlink all files matching the working tree
>> >  + difftool: avoid double slashes in symlink targets
>> >  + git-difftool(1): fix formatting of --symlink description
>> 
>> I lost track of various discussions on "difftool" and its "symlink
>> so that the user can edit working tree files in the tool".
>
> Would it be easiest if I send a new series incorporating
> jk/difftool-dirr-diff-edit-fix and the proposed change to not overwrite
> modified working tree files, built on top of t7800-modernize?

I am somewhat reluctant to rewind a topic that has been cooking in
'next' for over a week (the above says 19th).  Rebuilding the
style-fixes on top of the above is fine---that topic is much
younger.
