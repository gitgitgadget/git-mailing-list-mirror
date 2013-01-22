From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 17:51:44 -0800
Message-ID: <7vsj5uc7db.fsf@alter.siamese.dyndns.org>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
 <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
 <CACsJy8B1=3gMfGUf3kyea9TyZmr1J7dbM1_+huMNrep24hwuiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxT21-0004dk-0P
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 02:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab3AVBvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 20:51:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab3AVBvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 20:51:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBD9CC119;
	Mon, 21 Jan 2013 20:51:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dmGkPsbUVz4xdKjh9ppVjw/Pvfk=; b=x8DqCa
	YSVQ6+jfE9HfNyt4UPDMoNsqHtJAyl86RV6LV/fFPCIouk+J3VqmUJBzBA9NgArk
	dQponGp253i8K81feUyGv9D0gkS8J1hs1ionweI8PsBbcQKnLCO/yd+vZhblBCV4
	q9cJG3yUqsZljpsEUt1iBIJhUlpgAQ/i+0rWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s6nWBg6sj1qbfEvFFAmBilxUfGgqHrsj
	ZfXoHI5z4OsiGFuTlkXw3XzpxUwG9vXNKW57OkclHMdSsiQ4XO/oYHxFqdQ0Ywzs
	EmUUo//1uj1P20rwodSbSCYYGKZfFcftVgElIsb0Zd7IPt8nWHxIxaPSdQMkFrfv
	cKRvvkcnZe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0C5FC118;
	Mon, 21 Jan 2013 20:51:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D903C117; Mon, 21 Jan 2013
 20:51:46 -0500 (EST)
In-Reply-To: <CACsJy8B1=3gMfGUf3kyea9TyZmr1J7dbM1_+huMNrep24hwuiQ@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 22 Jan 2013 08:10:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47707464-6436-11E2-A93B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214186>

Duy Nguyen <pclouds@gmail.com> writes:

> What about 'grep' and 'clean'? I think at least 'clean' should go
> tree-wide default too. I don't mind grep go the same way either but I
> think people voiced preference in current behavior..

I think the major argument for "git grep" to be the way it is is
because people expect it to be extension of running "grep -r" in the
same directory ("git grep" excludes untracked ones so you do not
have to suffer from --exclude=.git and such unpleasantries).

Shouldn't "git clean" be an extension of running "rm -r" in the same
directory ("git clean" does not lose tracked ones but otherwise it
is a recursive removal)?
