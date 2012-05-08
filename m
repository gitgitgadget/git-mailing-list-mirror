From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 08 May 2012 09:29:00 -0700
Message-ID: <7v4nrqy6ur.fsf@alter.siamese.dyndns.org>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, j.sixt@viscovery.net,
	schwab@linux-m68k.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:29:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnHi-0003ro-6L
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab2EHQ3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:29:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969Ab2EHQ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:29:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41DF364FF;
	Tue,  8 May 2012 12:29:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SSgiPXsNFKJQLvBmvbT81Nwsmy8=; b=Eo52ax
	jLYxJKQVaNq1b/gPBmGcqeLIvM/sltt86jfHOhbCrEF8rV2GjdWrb3jDLvZDp8CT
	Mhwc8Jetu/P58Ic3GZ7y2pWo2660uGmQeAQVwUnC6N6SDmkVwaS1Mca6UGybzpxF
	qZiUIvit4nYElPoNbRVzA8UC8nc96pAJYooNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CErTa6GkKarrkAyV6FT16G73klql//9n
	qw0dXp9MvasKIKTLODK40by5IU/v1FcFhgNJ37drEsdeKTkSodfRCIhuC/PKEAgL
	GTSWyTeOGgwQF6jroQDvVuSLjcr11RSwCqESS9kaDE5cjlKjiuI5IVj3FlPvDkzQ
	QYjck/f9ZdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37DC264FE;
	Tue,  8 May 2012 12:29:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B874064FD; Tue,  8 May 2012
 12:29:01 -0400 (EDT)
In-Reply-To: <1336493114-4984-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 18:05:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB911BAC-992A-11E1-8DC6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197386>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> In abe1998 ("git checkout -b: allow switching out of an unborn
> branch"), a code-path overly-optimisticly assumed that a
> branch-name was specified. This is not always the case, and as
> a result a NULL-pointer was attempted printed to .git/HEAD.
>
> This could lead to at least two different failure modes:
>  1) The CRT formated the NULL-string as something useful (e.g
>     "(null)")
>  2) The CRT crasheed.

Just a quick question.  What does a cathode ray tube have to do with this
(or "are people expected to know what CRT you are talking about?")?

Otherwise the explanation, the patch and the added test makes sense.

Thanks.
