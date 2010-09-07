From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: move RelNotes into a directory of their
 own
Date: Mon, 06 Sep 2010 21:42:00 -0700
Message-ID: <7vzkvup3l3.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1009062026330.19366@xanadu.home>
 <20100907020109.GI1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 06:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osq0s-0000nq-JY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 06:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab0IGEmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 00:42:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0IGEmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 00:42:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98595D3A83;
	Tue,  7 Sep 2010 00:42:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s0MS2Ym3vcWq2QQKWy7o8YH+cbE=; b=qrsOQD
	Zh4nNAf2az/uZBX9CcyWKS4eOKYQ6tMXAQDJO+jWZWrUx1qoAs+PSLDzpX3v2h8A
	ja3IcHYWn0DFEyzMPcziVOLRF8GzhxF7/avj6qxzXMnDjRnlCLiMboubVUZncQEy
	Xo2NbJCjXts7rDSa7ru3l0/u5J6cm9Cdn6HqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqfriwLEW9u1boxr4j7Qsdj4k3gXi39h
	v443/vviXml2tkYm5u6MVzgtk+img2y+IHBM8tFxnu/NyrDfMhXto0LYoJ+HvkZW
	y+zpIJOudy+Z1KppBs5HfglA5vDOQ63qfnToLz+euHEGZI8N4MMBXdRC9Tzyi+bL
	6S8W0d2hh/g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 617F9D3A82;
	Tue,  7 Sep 2010 00:42:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 741EBD3A7D; Tue,  7 Sep
 2010 00:42:14 -0400 (EDT)
In-Reply-To: <20100907020109.GI1182@burratino> (Jonathan Nieder's message of
 "Mon\, 6 Sep 2010 21\:01\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C339BD2-BA3A-11DF-8BEA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155672>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nicolas Pitre wrote:
> ...
>>  .../{RelNotes-1.5.0.1.txt => RelNotes/1.5.0.1.txt} |    0
>>  .../{RelNotes-1.5.0.2.txt => RelNotes/1.5.0.2.txt} |    0
> [...]
>
> Junio: Because of
>
> 	for th in \
> 		"$T"/*.html "$T"/*.txt \
> 		"$T"/howto/*.txt "$T"/howto/*.html \
> 		"$T"/technical/*.txt "$T"/technical/*.html
> 	do
> 		h=`expr "$th" : "$strip_leading"'\(.*\)'`
> 		case "$h" in
> 		index.html) continue ;;
> 		esac
> 		test -f "$h" && continue
> 		echo >&2 "# rm -f $th"
> 		rm -f "$th"
> 	done
>
> this would invalidate old URLs like
>
> 	http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.2.3.txt
>
> , no?  Is there some easy way to set up the appropriate HTTP 301
> responses?

True, I failed to spot that one.  Although I noticed that Nico didn't
touch the RelNotes symlink at the top ;-).
