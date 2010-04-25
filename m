From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 18:13:47 -0700
Message-ID: <7voch8mj04.fsf@alter.siamese.dyndns.org>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <20100424164247.GM3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 25 03:14:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5qQY-0005i7-9z
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 03:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab0DYBOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 21:14:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab0DYBOJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 21:14:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CFD8ADF81;
	Sat, 24 Apr 2010 21:14:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IbdZz6BcJIG+
	bumzDAky9uF8xns=; b=nl20Qg9bvAZjFPLWMdR4RPHksJYWCnXzkYVP5IDixxNl
	rTMdzy6YqxZXQYYasfRG+5Opyj2gyVu1IQOJwiOok92TLanHbeb+amA7d5vuHtG3
	uaQ46rFnX2aE4hgcjJuTCKsWyPMd/tBg7k8wzwx86Z/Ymk7Icje1PbJQwnrFJdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FMAItA
	rYdBNSQy396nwFSUUvDxhY46BI29OtJkp/Y21rfegtelJC3Ei9DEAtIGh+OdgfJX
	NewbbiTnJJjX7ejqkb2tIdnvzTRdGnnxCRybdQrBzhfiUVprZa0ha219a5D5x3cu
	nkcxMe9iyXcN8Xh2kkzfcKhDnskf/pu7K+7TQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BC5EADF7D;
	Sat, 24 Apr 2010 21:13:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74AC1ADF7B; Sat, 24 Apr
 2010 21:13:49 -0400 (EDT)
In-Reply-To: <20100424164247.GM3563@machine.or.cz> (Petr Baudis's message of
 "Sat\, 24 Apr 2010 18\:42\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2B9AC02-5007-11DF-8CC0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145714>

Petr Baudis <pasky@suse.cz> writes:

> On Sat, Apr 24, 2010 at 01:10:24PM +0200, Wincent Colaiuta wrote:
>> El 24/04/2010, a las 11:40, Jakub Narebski escribi=C3=B3:
>> > I'd like for 'git commit -a' to *fail* if there are staged changes=
 for
>> > tracked files, excluding added, removed and renamed files.
>
> Thanks for this suggestion, this is exactly what I wanted to propose!

I am somewhat torn.

I have made mistake of running "commit -a" after I spent time sifting m=
y
changes in the work tree.  I can see that I would have been helped by i=
t
if the safety were there.

But at the same time, I also know that my development is often a cycle =
of
change then diff then add (to mark the part I am happy with), and when =
I
am happy with the output from diff, I conclude it with "commit -a" to
conclude the whole thing.  I can see that I would be irritated to if th=
at
final step failed.

But I suspect the irritation would be relatively mild: "ah, these days =
I
shouldn't use 'commig -a' to conclude these incremental change-review-a=
dd
cycle; instead, I should say 'add -u' then 'commit'".
