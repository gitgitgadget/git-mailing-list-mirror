From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Encrypted repositories
Date: Thu, 06 Sep 2012 12:49:30 -0700
Message-ID: <7vmx132aph.fsf@alter.siamese.dyndns.org>
References: <e1f18eed-1096-4121-879a-4dd78627a4ba@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Thu Sep 06 21:49:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9i57-0003it-SO
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 21:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759650Ab2IFTte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 15:49:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759629Ab2IFTtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 15:49:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 748149A99;
	Thu,  6 Sep 2012 15:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GIPiz7NFQFBzLV/bP8MBU+MiFGA=; b=L5Fwu/
	Hgh/QhfDnzvgMglEzb6tlt1V5ms8RjLTFOfAkb6tCr5BQ7OKf0hsNxA75BeOTFBg
	sBJndbicsfckXyKE1yzLPMoqt2kBee0WMp3FPIonpkIWHMGB3OhVsR0KQR48vx4i
	A6tuDHzeWVuDruSICvMfRE1eD2XAWMoCeNV8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XkprBeKIVbWi0wO2QYhP4U4O0fi8YOlh
	k94zRkqA0a88JXiDbM0Oj8Am3fGeJNBN8WxyigtZPnSSsEw3RKyjBGlf3tF/s0Hy
	B0OOnmL8ak5eyJKC/VI5FH15zIaXsdHIurxWISIb6hFNlat9ruUkAJJo8ri/GxEZ
	ROf8hnM4IPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B6C9A98;
	Thu,  6 Sep 2012 15:49:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5A289A95; Thu,  6 Sep 2012
 15:49:31 -0400 (EDT)
In-Reply-To: <e1f18eed-1096-4121-879a-4dd78627a4ba@zcs> (Enrico Weigelt's
 message of "Thu, 06 Sep 2012 15:56:29 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA050410-F85B-11E1-803B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204917>

Enrico Weigelt <enrico.weigelt@vnc.biz> writes:

>> Enrico Weigelt <enrico.weigelt@vnc.biz> writes:
>> 
>> > * blobs are encrypted with their (original) content hash as
>> >   encryption keys
>> 
>> What does this even mean?
>> 
>> Is it expected that anybody who has access to the repository can
>> learn names of objects (e.g. by running "ls .git/objects/??/")? If
>> so, from whom are you protecting your repository?
>
> Well, everybody can access the objects, but they're encrypted,
> so you need the repo key (which, of course isn't contained in
> the repo itself ;-p) to decrypt them.

So, in short, blobs are not encrypted with the hash of their
contents as encryption keys at all.

>> How does this encryption interact with delta compression employed
>> in pack generation?
>
> Probably not at all ;-o
>
> For the usecases I have in mind (backups, filesharing, etc) this
> wouldn't hurt so much, if the objects are compressed before encryption.

For that kind of usage pattern, you are better off looking at
encrypted tarballs or zip archives.
