From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 18:43:57 -0700
Message-ID: <7vwrvxtyjm.fsf@alter.siamese.dyndns.org>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
 <87vdbitu9v.fsf@frosties.localdomain>
 <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
 <87aastx6sa.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 24 03:44:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5UPs-00007H-LG
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 03:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab0DXBoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 21:44:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0DXBoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 21:44:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 833EEAD834;
	Fri, 23 Apr 2010 21:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NnUJKeaPDsP9WQlaYGo8bNMm4Uk=; b=WcW71E
	LiYLScOeO5EWQPDbkhb6wrYK8+MvDbXmZD1xInJtOngtgAmZrdJ66GapATCoSaC6
	0Nar/wOvJ7NIU3uKZhCgDPV+WE5XVaKBjRp+7MIxTvfgtHoxrGPe54k9BJmdh+rW
	E9YwGyjSJ9QwhXmrbyIPTnq3Zc3UfIQnYuVDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pziNCznEo2s3cL44Ov4qMTVil+aqBwum
	astc9gQd2V0uNmhhoJhOQYoql0YpMukWitLLHssbYV+Z/pKd2fWyxBZHysae4zoo
	sxicsmiAO7HjUgcCIqE+KBL8d+16PX434RXPqZrZ4L3kJ9PJfUsIwYRvdW/JOgic
	5cTrDAXkcWM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D79EAD832;
	Fri, 23 Apr 2010 21:44:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17DCCAD829; Fri, 23 Apr
 2010 21:43:58 -0400 (EDT)
In-Reply-To: <87aastx6sa.fsf@frosties.localdomain> (Goswin von Brederlow's
 message of "Fri\, 23 Apr 2010 22\:17\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE53EE6C-4F42-11DF-B3D7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145653>

Goswin von Brederlow <goswin-v-b@web.de> writes:

> But you are already rejecting it in the design phase before there even
> is a patch.

We do review both the design and the implementation on this list, and it
actually is a *good* thing if a proposal is rejected when its design is
flawed at the conceptual level.

A perfect implementation of an undesirable design is just as undesirable
as a buggy implementation of the same design.  It is a change that we do
not want to have in the system.

As to this particular proposed change to commit everything only when there
is no change between the index and the HEAD, I think it is a bad change.
As several people have already said, it adds unnecessary complexity to the
end user's mental model.
