From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Fri, 21 Jan 2011 16:30:34 -0800
Message-ID: <7vvd1hn5jp.fsf@alter.siamese.dyndns.org>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 01:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgRNW-0000gY-Tr
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 01:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047Ab1AVAas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 19:30:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab1AVAas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 19:30:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 209B63EAC;
	Fri, 21 Jan 2011 19:31:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=O/R9JHdSFMf8ZEfQfWS24c5xH0w=; b=gbFKprMdGwnvBFXj9k8e3J+
	5Qz1B4ApYqMxug0iauf0dD90msMVNDYtiYq26Pb/HnrlJC1EeOK/ViWGtEtntLYo
	ddeaf8edTiaiz3uuBYaW+cqwa74u92cwf/NLJt+NVjpAEl1GFdJQjC4vAgn7Fa7B
	WzakAqVhhO2kE126mmdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OJKY0UDBQCcwTttwxBocp0Zgvx8CPoj8Vltun1+MbW8e753Hj
	k4UQWi2ZqP8V2ajNYkcy4jEOc9DMNnwi+JYKzG+nvRxzzy6DTvUrvgjZLIdXty5s
	wKZZmDdgv7Bfd4tMePqFhrpoDme8xXxm0T3nObfOtH1all6gX/oKeZJPFs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C685C3EA9;
	Fri, 21 Jan 2011 19:31:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4C9D13EA6; Fri, 21 Jan 2011
 19:31:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3F07EAE-25BE-11E0-A934-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165404>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +				buf = read_sha1_file(spec->sha1, &type, &size);
> +				if (!buf)
> +					die ("Could not read blob %s",
> +						sha1_to_hex(spec->sha1));

Style; no SP after "die", as it is a function, not syntactic elements like
if/switch/while (look everywhere).
