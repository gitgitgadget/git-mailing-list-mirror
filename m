From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] ls-files: support -o --max-depth (more of a hack as
 fill_directory should support this)
Date: Thu, 07 Jan 2010 10:01:28 -0800
Message-ID: <7vljg94ww7.fsf@alter.siamese.dyndns.org>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
 <1262884076-12293-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwg6-0004eh-O8
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab0AGSBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 13:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037Ab0AGSBn
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:01:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab0AGSBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 13:01:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB858EE71;
	Thu,  7 Jan 2010 13:01:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=W1+NZbF/xKDHVkumKf/a4lX+4
	+M=; b=pDIclT+1AdaCPxqPV6s6ouIgx5mNm1vDc82YjOspi1F7KA2QGzuGqZKTH
	ZjTY78IZhSYSegfeIuDAcrpGz7sosREDSLvnrPsKDgtEWdF0KWJ1B7JOLab4F9dA
	+UZCOmt7lJdZG7OviLHO2Muf6Ju3O7o7bTT+r/WZviyfpfIApI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=hHLKQYMVjts9AGZlb0G
	KqtUVaq4/rVocQZS46waxpP/zp9FE7NPKdGsV8cYOFY97ij+0VuTIXTy4QNBD957
	QrCbSzXvUP3KRovDYRNYkxBUFGHbdvEk2yEv++TIhQCG+ThM6qPkuv9DwB2SJIan
	BNngOo5MNNudQpXbQXxO54wI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B2798EE6F;
	Thu,  7 Jan 2010 13:01:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B116D8EE6E; Thu,  7 Jan
 2010 13:01:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B022820E-FBB6-11DE-B061-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136370>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Subject: Re: [PATCH 2/3] ls-files: support -o --max-depth (more of a ha=
ck
as fill_directory should support this)

Perhaps you would want to look at how builtin_grep()'s walker and the
walker in dir.c can be consolidated?  The former has support for
max_depth.
