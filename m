From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] index-pack: eliminate recursion in
 find_unresolved_deltas
Date: Mon, 09 Jan 2012 14:10:51 -0800
Message-ID: <7vzkdwcys4.fsf@alter.siamese.dyndns.org>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkNQh-000524-04
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab2AIWKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 17:10:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101Ab2AIWKx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 17:10:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83FFA7C6F;
	Mon,  9 Jan 2012 17:10:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2tR5g6zacGAI
	x4A9BTca0NjTfAk=; b=rr7rDZs9mxSZlJD21nMldS8B6AFggIsd4uQ1u7D2HEIM
	GJpQVUMEHbnO4rxdMXqLPQizjNiXQ2+0NkIrMiBLei+Z/IP2QdS2etqYp6MXlUDT
	0Z0PCO1CDbmgO9J6fwnE1xN6TpyLfZtSOvKtSFmD02qc9jo4ufzbaoqI5MIjytU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S4yt5G
	/JLC/cBS9kuNl90ijsniiwNwB0FyMEP44qa1glj6W2s+St/P7yITxfNd1vOht/no
	d5jU0XBel62Bx84/FCSwD43E5Av2aA97YFCYN4J2gggrTdzDAlfNwhtWOQYuOI0/
	R9I89W45Gk1J2w5oWNbCUMzTC9iWkpomapIDc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B0827C6E;
	Mon,  9 Jan 2012 17:10:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DE397C6D; Mon,  9 Jan 2012
 17:10:52 -0500 (EST)
In-Reply-To: <1326081546-29320-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Jan
 2012 10:59:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBAF8AD2-3B0E-11E1-9F0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188194>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

I find both the original and the updated code rather dense to read with=
out
annotation, but from a cursory look all changes look good.

Thanks.
