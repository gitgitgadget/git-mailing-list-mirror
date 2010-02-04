From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 04 Feb 2010 13:07:25 -0800
Message-ID: <7vwrys7lrm.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vpr4lhsfu.fsf@alter.siamese.dyndns.org>
 <7v4olxhrti.fsf@alter.siamese.dyndns.org>
 <201002041821.22864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:07:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd8vR-0002fO-6U
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 22:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0BDVHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 16:07:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0BDVHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 16:07:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FEF97DDD;
	Thu,  4 Feb 2010 16:07:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C7H5r9NB638HoiR6SAjGy3TnB8Q=; b=I/TmFL
	SIkDVu9pE3LL+3BZhdIXOozF4CPXrpHoPuLB77ttvdwrWtsCCOB81EPPm/mdp5wj
	iEPYzcAvd0gaCvO+jRtdM2vYm+jZs6fnxqtFSspe0bq4vqZ8iOF4W99XG2OkZ88W
	+9XjkJHcHzFF1LHcNqcAKjuwYwP37QLGk2VUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WwqflRAdvKx8/Dq0pO3VBA79fIoaemkj
	zr33LloIW8AP74YAAM0UTxMywhxCu6+QByypng2n5p3wvFPLAw63xVnBAGx2z32/
	1L7XvAaBcBd3u+7RjNM+PqZx1EmSwOSeZ0EWDuVD0Hkrt/DEOk9xOTIx+0N0UFCz
	V0slmfSaf0Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0424897DDC;
	Thu,  4 Feb 2010 16:07:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D30C097DDB; Thu,  4 Feb
 2010 16:07:26 -0500 (EST)
In-Reply-To: <201002041821.22864.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 4 Feb 2010 18\:21\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50707ED4-11D1-11DF-B68A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139004>

Jakub Narebski <jnareb@gmail.com> writes:

>> IOW, the code should be reading output from:
>> 
>>     GIT_NOTES_REF=$note_ref git show -s --format=%N $co{'id'}
>> 
>> as the notes tree may not be storing notes in a flat one-level namespace
>> like you are assuming.
>
> First, for some mechanism of deployment (IIRC Apache's mod_perl) changes
> to environment variables from CGI script are not passed to invoked
> commands (I guess for security reasons).

I do not believe you are unable to spawn

	open $fd, '-|' 'sh', '-c', "GIT_NOTES_REF=$note_ref git show ..." 

and read from it ;-).

For possible enhancement to make notes easier to use, see the other
response.
