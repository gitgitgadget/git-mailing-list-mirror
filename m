From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass strbuf as base
Date: Mon, 01 Dec 2014 11:32:15 -0800
Message-ID: <xmqqk32bp3nk.fsf@gitster.dls.corp.google.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
	<1417338302-8208-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 20:32:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvWhs-0006Br-B5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 20:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbaLATcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 14:32:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753311AbaLATcT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 14:32:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E3E202C7;
	Mon,  1 Dec 2014 14:32:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wt6bz71YV3Se
	lDld7sg0XnYTWiM=; b=FH5nHFsTIJcmcQbXipsVq8OHhPX+uwnkoyaeRp3c8svI
	tXfrRen5hfTeMyu0nYasywXtL0F5Mj6l0fX8kAyUHpfXowVCrKk+7iKI30jb9yv3
	OEShXNITXUdSuzLdMpVpyP2ZFJ14cdFMp17CMHwOe7tJ+UAf4QK/8ghJigyfwws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DT2GNf
	BGEypZag2rM8j7NR2W4ZUjVKAtq4F4nTPA5eoXsdBQktKfwtdwPYbfxkPtezXdWZ
	RQ8QCqgH2eC4cGzmhF4bFGzwWhHxhhIkwrI/x97LxQOHrlzJINrPPF8XgT3pHdAL
	5yoHV5S1vTvThiE1vsmysm6Pz6LDJpU+TFk0A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD4C2202C6;
	Mon,  1 Dec 2014 14:32:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26720202C5;
	Mon,  1 Dec 2014 14:32:17 -0500 (EST)
In-Reply-To: <1417338302-8208-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 30
 Nov 2014 16:05:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C265F182-7990-11E4-BAF9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260507>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This allows the callback to use 'base' as a temporary buffer to
> quickly assemble full path "without" extra allocation. The callback
> has to restore it afterwards of course.

Hmph, what's the quote around 'without' doing there?
