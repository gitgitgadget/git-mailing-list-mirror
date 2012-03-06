From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/11] parse_object: special code path for blobs to
 avoid putting whole object in memory
Date: Mon, 05 Mar 2012 16:57:33 -0800
Message-ID: <7vty22wnpe.fsf@alter.siamese.dyndns.org>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
 <1330919028-6611-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:57:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4iis-0001ke-F7
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 01:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674Ab2CFA5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 19:57:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932608Ab2CFA5g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 19:57:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB01E67B1;
	Mon,  5 Mar 2012 19:57:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=CjOvOBeK0UBAoFGMaFVq1kAnp
	nc=; b=SIxPKFVYXhtqSr6X8P/ycQbniNPeSbZ5Y7X5bxp7dXyX+WeaVhTEFEQC4
	Zkg/CCb32COTBMQefvUhm+B9P1rTxvj+5gfeftwUjbfraswOszQqqetHc+8OZoCL
	Knn0eImz/j84+xuMvllLvnk3a+S3FccDv9XIE3IZcAIMqfXRPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=uHxSyoZgUfdCrwsBYTN
	NfzDtRE81r9t3Tn1UR+7+3TOs7sdY6o8n1ospSfGfjXgI/BaHbC7EVzzxUqsXndn
	BNQ2hzBpXuWUzBLSZ/zKZzImIkD2vlERGlEQA65qoQ6oM8uDMDf0L6DRKox8b2jD
	INfslbfTaeTt5gzPPWtLwaIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB95067A7;
	Mon,  5 Mar 2012 19:57:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5499567A5; Mon,  5 Mar 2012
 19:57:35 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CA59A88-6727-11E1-A128-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192292>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The code looks OK but the updated API into check_sha1_signature()
needs to be explained both in-code comment and the log message.

I'll push out an updated version later on 'pu'.
