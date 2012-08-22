From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 11:24:50 -0700
Message-ID: <7v393e943x.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
 <7v628epzia.fsf@alter.siamese.dyndns.org>
 <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
 <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
 <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
 <7v4nnxld24.fsf@alter.siamese.dyndns.org>
 <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
 <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
 <7vvcga96n9.fsf@alter.siamese.dyndns.org>
 <003d01cd8090$214ca710$63e5f530$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Brandon Casey'" <drafnel@gmail.com>,
	"'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Fbv-00009C-Q5
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230Ab2HVSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:24:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933220Ab2HVSYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:24:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89970809E;
	Wed, 22 Aug 2012 14:24:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RSH0lhIWzAb4MyRw4L24PYDdikE=; b=iDBcCb
	sQS/ksdl0nB/dtrghEZpgrz/uT/Q0+QYXYkPqR/86I4fYX81KySAVPdjuHHGZfuR
	aKrUP2fnworq6FB4QsGpw16MtuKq+phlaKNTccO/aNp3wUhX4GDNYQUZdpPFIFC4
	T1U2aK7Syoal5nuldLC6XD12ZI8p/N2XRFatE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4h/bKASwu/DjM7EUfwoq5fvOUW3HKWe
	4YYMBH+EpNTlOdi2c5roKGbeAZr7REkkuI9BHrAytMODV9wrx62S/3zi9pWxWZ5Z
	c2Ke65z30fQv5WIESlxmCaSeb4hrtsiU67ikX5xDq7YrvUPRLlw513wadP0AipM1
	rhnPE8W/nFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 778D8809D;
	Wed, 22 Aug 2012 14:24:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAC98809C; Wed, 22 Aug 2012
 14:24:51 -0400 (EDT)
In-Reply-To: <003d01cd8090$214ca710$63e5f530$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 20:01:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9EBA5E6-EC86-11E1-B117-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204061>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> Nice.  And we have xmemdupz() would be even better as you followed-up.
>
> How's that one used?

I forgot that we frown upon use of any x<allocate>() wrapper in the
compat/ layer as J6t mentioned.

So probably something along these lines...

	int retval;
	char *dir_to_free = NULL;
	size_t len = strlen(dir);

        if (len && dir[len - 1] == '/') {
		dir_to_free = malloc(len);
                if (!dir_to_free) {
			fprintf(stderr, "malloc failed!\n");
			exit(1);
		}
                memcpy(dir_to_free, dir, len - 1);
                dir_to_free[len - 1] = '\0';
                dir = dir_to_free;
	}                
	retval = mkdir(dir, mode);
	free(dir_to_free);
        return retval;

It might be possible to for the error path to get away with
something like:

	if (!dir_to_free)
		return -1;

if we know the callers are prepared to see mkdir() failing with
ENOMEM, but that is not very likely.
