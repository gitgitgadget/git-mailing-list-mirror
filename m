From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/25] path.c: make get_pathname() return strbuf instead of static buffer
Date: Wed, 19 Feb 2014 12:28:59 -0800
Message-ID: <xmqq7g8q9790.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDlX-0007kp-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbaBSU3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:29:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbaBSU3F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:29:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D27306DA8B;
	Wed, 19 Feb 2014 15:29:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MN91f1xKhDae
	dujs8A6IZdyR1E8=; b=THLW4n8LSB1rBFcCJkIqGK9L+NfADWkWZa25QcEoEI0R
	Nkuf1QBwwRPH6TyV1BrBw0CKXaPMbmPnfZ58ox7ZPouTc82yWJi5KWpoNVACCBMC
	iFyp3s/cbCtOBuhb47AbtbNVHrzx3BfwJPuWt6p+lrDa88m5Wr5whtLOspnHEpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tT39+t
	36SQDtnYoQYLEQXysQ/bCNzJaAXUUmN9Aj62oZRNv5FtslQA51JW3qOBBleexc/e
	V9XH+YOnW6P101t4IKR8vcaDvkEwl5GMVJGv+tq0Ntbvm2LwNLgR8aL6bY7qTsLz
	B1S5aSBzFSr3kU+g1ghvrPe2WX9xbLJcRI0b4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 556426DA85;
	Wed, 19 Feb 2014 15:29:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81C946DA81;
	Wed, 19 Feb 2014 15:29:02 -0500 (EST)
In-Reply-To: <1392730814-19656-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 786E11BC-99A4-11E3-8404-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242407>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

(Only nitpicks during this round of review).

> -static char *get_pathname(void)
> +static struct strbuf *get_pathname()

static struct strbuf *get_pathname(void)
