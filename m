From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] "git apply --threeway"
Date: Thu, 10 May 2012 08:26:37 -0700
Message-ID: <7vzk9gnjki.fsf@alter.siamese.dyndns.org>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
 <vpqtxzobigw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 10 17:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVGQ-0003Ul-IF
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760090Ab2EJP0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:26:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759186Ab2EJP0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:26:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4649361B8;
	Thu, 10 May 2012 11:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zei1MwF7StB6Hyr17cROY3r12FU=; b=urtQ/R
	/Q5Fzwz7dhB9QGAcUnbws2jSd7Q7pGVqOk56/DWcy1RXaoETNipBB7TFls6/bm9v
	UlhvS3SkkLM8+ApXfOud+MzdFkIzs2CF9pwqdt1OzW/6gI5yZNF3tKZWBogcbMoi
	XDUvTJn62YNd9nKbSApbu5LdWDHQsAMVuanUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RoDn4UsneTUMrzulUE1Ajz5hFwwIFIQ6
	6eglJ/BoN6FCwqpRqw/28QfwkgXUv4tbts56sqv3Q3L38Fx+AkKYgtW3i6brzQ2j
	w/O5qNtArD6/kQG+A9E+A7qJw/LhLf5M511UyjV++WMx4bJPjhk+2dyUg85N3Jdj
	RV78k9ixeZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DBFD61B7;
	Thu, 10 May 2012 11:26:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8C1861B5; Thu, 10 May 2012
 11:26:38 -0400 (EDT)
In-Reply-To: <vpqtxzobigw.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 10 May 2012 09:31:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 896E4D60-9AB4-11E1-A2FC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197582>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  - After trying and failing to apply the patch text, we inspect our object
>>    database and see if there is a blob object that matches what is
>>    recorded on the "index" line of the patch as its preimage.
>
> Just being curious: why is it called "index"?

I don't remember exactly, but I think it has something to do with the
"name"-ness of the hexdigit strings that can be used to identify objects
in the object store, i.e. the object names serving as indices.

  http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9794
