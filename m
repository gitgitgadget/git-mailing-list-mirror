From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: allow to clone from .git file
Date: Sun, 21 Aug 2011 11:54:02 -0700
Message-ID: <7v7h66y4s5.fsf@alter.siamese.dyndns.org>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 20:54:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvD9w-0002x8-JF
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 20:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1HUSyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 14:54:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab1HUSyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 14:54:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF2DC4A1B;
	Sun, 21 Aug 2011 14:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2H5rYdYXfIBPVzkI0TKr9q7r+
	1s=; b=L8HWcChgpdPxUSgcWqQRMBzjTyoqgiu33VdBlGWp+Eh218pdwc765co4z
	lofRZ6YwN3F1gXpNjNW6auUnXe50wznULHouHlYYM+RXrPJL+GqGpPhBAr6wcDrk
	Os4+SckOrWp9Vs6dBwjIHuNWEN5bJ7TWSbeMzJbTFIO7anVcv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SCmLyDtR1rhmXk3wP8r
	dLDXqG+qPaGRXUbtWmP9AAnRSrM2/j1oEAkIr3AFV7VQwigWvBW2XaFBkxaAwJt0
	4YCsUC9T3gnIQpsI2niQqY+halS3sS96XAsa10jNr//mHmtAMtcIbziEMLfpxolu
	cMFJ+jpOsN0bbzrtXJkx7a4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71354A18;
	Sun, 21 Aug 2011 14:54:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DD254A17; Sun, 21 Aug 2011
 14:54:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0E220C8-CC26-11E0-8C82-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179807>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +		else if (S_ISREG(st.st_mode) && st.st_size > 8) {
> +			/* Despite the name read_gitfile_gently can be
> +			   cruel on non .git file, check for signature
> +			   ourselves */

Didn't somebody add "is this '.git' thing a valid git metadirectory?" A=
PI
quite recently for exactly this?
