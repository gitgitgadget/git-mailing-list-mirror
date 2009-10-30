From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Fri, 30 Oct 2009 12:00:33 -0700
Message-ID: <7viqdwlnam.fsf@alter.siamese.dyndns.org>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
 <7vws2d4y3d.fsf@alter.siamese.dyndns.org>
 <b48ea8a00910300101i38f2e4a8q2c2e014d2df1a150@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:00:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wiR-0003zX-2E
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbZJ3TAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbZJ3TAl
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:00:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbZJ3TAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:00:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C34DB8CDD0;
	Fri, 30 Oct 2009 15:00:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xCqWpDZAxQOpsouJ2DrJTAtsr2k=; b=xxXlPS
	wmgSE8n8Mhg5NAy8qeadS+OabpLDcCliAiuuhJyyQMG1Dbs2LxjFat+IohRynINc
	mNOHJlOC5Z0Ithb48iwpzxdMWo6wNXZ6P51VRRbIgkYa+nyyLW6ZRTjVNrNPlgxM
	zV3aIlrl7EZPIjdOVgxiBGrvT+kPc0j75c04o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gU4JydiLETkHUvC5VrsxV6JdZoPnyyjt
	vkDusdKjVOKqQx32UBC/fnAE1pHyrD41eorIonipavDe/19sRNBQOdjTxviToUF9
	GXjkP32Bt6CXVb7esaOsYDOnhmMVjCxKJ3vNdaLo+/trtJDNOiAgS3cqxEOVaFmy
	i/6+MGuwbWg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3FE78CDCF;
	Fri, 30 Oct 2009 15:00:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ABE3C8CDCD; Fri, 30 Oct 2009
 15:00:35 -0400 (EDT)
In-Reply-To: <b48ea8a00910300101i38f2e4a8q2c2e014d2df1a150@mail.gmail.com>
 (Gisle Aas's message of "Fri\, 30 Oct 2009 09\:01\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85A5B822-C586-11DE-8CB7-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131729>

Gisle Aas <gisle@aas.no> writes:

> On Thu, Oct 29, 2009 at 23:47, Junio C Hamano <gitster@pobox.com> wrote:
>> Gisle Aas <gisle@aas.no> writes:
>>
>>> Also make the examples show what 'git describe' actually outputs
>>> currently.  I guess the default --abbrev value has been changed from 4
>>> to 7 at some point.
>>
>> Some are good changes, but I do not think the example with --abbrev=4 is.
>>
>> $ git describe 975bf9cf5ad5d440f98f464ae8124609a4835ce1
>> v1.3.2-216-g975bf9c
>> $ git describe 975b31dc6e12fba8f7b067ddbe32230995e05400
>> v1.0.0-21-g975b31d
>>
>> Next time somebody adds a new object whose name happens to begin with
>> 975b3 you would need to update the example output.
>
> Yeah, I know, but I don't think that's a big deal.  So do you want an
> updated patch for that?  We could either simply remove this example or
> make it use --abbrev=10 or something like that.

Not touching the example would be the simplest.

Adding an explanation like this so that nobody will be tempted to "fix"
the example would be the best, I think.

     [torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
     tags/v1.0.0-21-g975b

     Note that the suffix you get if you type this command today may be
     longer than what Linus saw above when he ran this command, as your
     git repository may have new commits whose object names begin with
     975b that did not exist back then, and "-g975b" suffix alone is not
     sufficient to disambiguate these commits.
