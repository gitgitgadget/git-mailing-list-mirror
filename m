From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_cache: cast types from stat to ce_cache
Date: Thu, 10 Jun 2010 08:54:54 -0700
Message-ID: <7vmxv2nar5.fsf@alter.siamese.dyndns.org>
References: <a06cc84698f174d914350d6fd6e6b4739d22aa45.1276161176.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 17:55:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMk63-00076k-3a
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 17:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759446Ab0FJPzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 11:55:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0FJPzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 11:55:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDFEFBA0C4;
	Thu, 10 Jun 2010 11:55:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UIvEpAvKtvCz8gBCbYe67AYi2pM=; b=vQlEqXpq35vMvzQO9M4SllF
	mgUNfqy9vaumWb91Nzg+tcFBJIkAxrrTOSQsX+d//E3adhPcSBYOBjqeI2Nz0oQ7
	k5TP2p4f5aomSu82omQ/ACqYRgucFPsIqV+gg7mnvYszFaAQQh9bRBOG2GjDvbtC
	faVL0k8D7Lo2bQywumuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=L10mHgPkFIZWHgAJyeaJY1UFk40flA46/tnOuTuk+Y/Kpc7i/
	55qf3vso71zJCfuiiwqe3EmAJFBVN/ER9ohnPFpKyFAOX20jhuBUSSb8TvguSu5M
	F4xULdoh5XW+Ek+hqyawB2S2TvLI8Jp83C0HHEZOfSd6/kJH4aPNeZPB38=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46B60BA0C3;
	Thu, 10 Jun 2010 11:54:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93D3ABA0C2; Thu, 10 Jun
 2010 11:54:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85CCC9EA-74A8-11DF-B638-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148885>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -	ce->ce_dev = st->st_dev;
> -	ce->ce_ino = st->st_ino;
> -	ce->ce_uid = st->st_uid;
> -	ce->ce_gid = st->st_gid;
> -	ce->ce_size = st->st_size;
> +	ce->ce_dev = (unsigned int)st->st_dev;
> +	ce->ce_ino = (unsigned int)st->st_ino;
> +	ce->ce_uid = (unsigned int)st->st_uid;
> +	ce->ce_gid = (unsigned int)st->st_gid;
> +	ce->ce_size = (unsigned int)st->st_size;

I haven't had my morning coffee yet, but wouldn't the conversion be
automatic by assignment anyway?
