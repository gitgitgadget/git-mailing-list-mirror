From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] shell doc: emphasize purpose and security model
Date: Mon, 11 Feb 2013 10:32:47 -0800
Message-ID: <7vliaun1kg.fsf@alter.siamese.dyndns.org>
References: <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin> <20130211055752.GF15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4yBn-0008JX-3g
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 19:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758800Ab3BKScw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 13:32:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758620Ab3BKScv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 13:32:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84AF0BDFA;
	Mon, 11 Feb 2013 13:32:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrKRxSb1QcFWKWZ4ESDryGFBJaw=; b=NXBFUK
	RKFfDg9kf/CoOSkNzUksXZkQVmOnsevLBpS2Z/TCZ6Ny0MCZhDeEfDqMlblrg0ea
	xIGqkF9wrblGDR6Erukwjta/rcAz82DDMj/C7kBJKNvvMFBVTIMUeNP/Aro3nhjE
	2TCYzyQ3/amFMrOD6nTqQGtHQiFVfjD97xG9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qtOCRWY99Byj1fn/NtVZ5O6y9sgmR6om
	mGz33fSGmU0AwBgrh1hcXNfDZLAVkF8VbffuskCMwyP56JemdjZj1Pe0enEdx1Nd
	MylzruuEqsNyWEm7PHUTSrJ+MFko4k+SwHqLOni7VcuZMBGRQD/9PGMiVe17oLyt
	jJ17trV+xKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77203BDF9;
	Mon, 11 Feb 2013 13:32:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E27B8BDF7; Mon, 11 Feb 2013
 13:32:49 -0500 (EST)
In-Reply-To: <20130211055752.GF15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 21:57:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 705A5180-7479-11E2-BAD7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216072>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
> index 9b925060..4fe93203 100644
> --- a/Documentation/git-shell.txt
> +++ b/Documentation/git-shell.txt
> @@ -9,25 +9,61 @@ git-shell - Restricted login shell for Git-only SSH access
>  SYNOPSIS
>  --------
>  [verse]
> -'git shell' [-c <command> <argument>]
> +'chsh' -s $(which git-shell) git
> +'git clone' `git@localhost:/path/to/repo.git`
> +'ssh' `git@localhost`

I am wondering if we want to do the following instead of/in addition
to fixing the $(which git-shell).  It is not like we only allow a
single user and its name has to be 'git'.

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 4fe9320..6829ea9 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -9,9 +9,9 @@ git-shell - Restricted login shell for Git-only SSH access
 SYNOPSIS
 --------
 [verse]
-'chsh' -s $(which git-shell) git
-'git clone' `git@localhost:/path/to/repo.git`
-'ssh' `git@localhost`
+'chsh' -s /path/to/git-shell <user>
+'git clone' `<user>@localhost:/path/to/repo.git`
+'ssh' `<user>@localhost`
 
 DESCRIPTION
 -----------
