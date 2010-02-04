From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
 count in bytes
Date: Wed, 03 Feb 2010 20:38:03 -0800
Message-ID: <7v7hqtty38.fsf@alter.siamese.dyndns.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NctU0-0005F3-BJ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 05:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312Ab0BDEiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 23:38:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182Ab0BDEiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 23:38:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7209697A49;
	Wed,  3 Feb 2010 23:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=12f0d2r4k9KbuMTkDJVFh2wGDw0=; b=P6GkrQ
	ccm8n5kM22eHZJ033KRBNVvNCs6T+xT3FlNJVpKJBksgPMe3I2EgYmAQLthjm/Kh
	lcjm32keEREZ+LQwB1/9HKniOZ4SKJRHe8a/A4C5+Em4JWCV5/nB02QPpj9dXl6V
	NlX+TwNcmQB4fRm7mVBJ/5qiRkOLK+20kxFRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTBIfxTY8Kzf6K8SJ0ikT3Et0B+jibPA
	CjsmBSjV5eDXgh5mnlUiysi1IwQGnad7ZfFz79TJbCPUAYvtTd5H543PSTSHqEDO
	RP3Qa86MV40qLVyn8kwL8qc9TuWZEi2t7CIFggg4zmpeERfgOCub6VPAhVDUO0C5
	JddngXcX30U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3316697A47;
	Wed,  3 Feb 2010 23:38:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51D0897A44; Wed,  3 Feb
 2010 23:38:05 -0500 (EST)
In-Reply-To: <20100204040046.GR14799@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 3 Feb 2010 20\:00\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18DA9214-1147-11DF-B068-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138949>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nicolas Pitre <nico@fluxnic.net> wrote:
>> The value passed to --max-pack-size used to count in MiB which was
>> inconsistent with the corresponding configuration variable as well as
>> other command arguments which are defined to count in bytes with an
>> optional unit suffix.  This brings --max-pack-size in line with the
>> rest of Git.
> ...
>>  Documentation/RelNotes-1.7.0.txt   |    8 +++++++-
>>  Documentation/config.txt           |   11 +++++++----
>>  Documentation/git-pack-objects.txt |    5 +++--
>>  Documentation/git-repack.txt       |    8 +++++---
>>  builtin-pack-objects.c             |   11 ++++++-----
>>  t/t5300-pack-object.sh             |   14 ++++++++------
>>  6 files changed, 36 insertions(+), 21 deletions(-)
>
> Shouldn't we also change fast-import.c ?

Surely; could you do the honors?  I cannot really decide how big the deal
would be to break backward compatibility for max-pack-size myself.
