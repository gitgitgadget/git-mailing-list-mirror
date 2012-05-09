From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compiling git on Solaris. Recipe included.
Date: Wed, 09 May 2012 10:45:41 -0700
Message-ID: <7vd36dtfi2.fsf@alter.siamese.dyndns.org>
References: <CADmdEsnSt5Do+EuJHzfGxNY6aCnGA6AF6fbEETAGpoL6p7Nuwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Ashley <mark@ibiblio.org>
X-From: git-owner@vger.kernel.org Wed May 09 19:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAxc-0000de-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760645Ab2EIRpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:45:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760635Ab2EIRpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:45:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C6AD6A70;
	Wed,  9 May 2012 13:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rIRNXlFVLfhD4VPUsC3PRIdTFN4=; b=EkUgq9
	NeawpE3n4DFN4MFqvqwGCo+t6IZUXgKMnPkshezLFtigrEYPt8jVTy3WWEbAjkMW
	EPUuIhxPjaN7QPxe2bDfZAWoavEDmmnQ/dhfMB0IXXe/2QOUol6ol71N2MBh5wDf
	XhAj6ha7TbVVAR96nnpqLWdPXpW5EG4l3kYRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V8incRgNIBY4QeXQeqTdNN/PdctKtX7D
	jAACvT7+cT3PObqA8xnGQiHiHKqbXAW9d8i4SFfilau1ieYhjtNSaMcbcdijIacU
	8ZTHmLw5lBiJ1HnCDTWZeUt202AnA9talWem6eUldei/LijH5hAsamrPf1NYfBi+
	Sr0cq4DO/UE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C5B6A6F;
	Wed,  9 May 2012 13:45:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFDCF6A6D; Wed,  9 May 2012
 13:45:42 -0400 (EDT)
In-Reply-To: <CADmdEsnSt5Do+EuJHzfGxNY6aCnGA6AF6fbEETAGpoL6p7Nuwg@mail.gmail.com> (Mark
 Ashley's message of "Wed, 9 May 2012 13:11:30 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC7C73D6-99FE-11E1-8D0C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197484>

Mark Ashley <mark@ibiblio.org> writes:

> I'm compiling git on Solaris 10 and 11 SPARC and X86 using the Sun Studio
> 12.x compilers.
>
> git doesn't compile out of the box, there are (see below) lots of tweaks to

Thanks for an interest in Git, but I am somewhat dissapointed by your
message.  As our Makefiles strive to offer necessary knobs to tweak from
the command line for platform-specific glitches, from "Recipe included" on
the subject, I think people would have expected to see something like:

    gmake   VAR1=VAL1 \
            VAR2=VAL2 \
            VAR3=VAL3 ...

or perhaps:

    cat >config.mak <<-EOF
    VAR1=VAL1
    VAR2=VAL2
    ...
    EOF

and not a sequence of commands to rewrite files in-tree.

Other people have built git on Solaris but probably not many people have
done so recently.  The platform specific knobs in our Makefiles may have
to be extended to accomodate newer version of Solaris.  So the "Recipe"
may not be just the series of make variables, but needs a patch or two to
the Makefile to enhance the tweaks.

See 614dd90 (Makefile: SunOS 5.6 portability fix, 2010-05-14) for an
example of such a patch.

Thanks.
