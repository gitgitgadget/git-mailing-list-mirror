From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Tue, 07 Oct 2008 08:18:11 +0200
Message-ID: <48EAFF23.1020607@viscovery.net>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com> <20081007032623.GX21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Juran <jjuran@gmail.com>,
	Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:19:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5un-0001xA-2h
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYJGGSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbYJGGSN
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:18:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59650 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYJGGSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:18:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kn5tb-0006sJ-EW; Tue, 07 Oct 2008 08:18:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 328AC54D; Tue,  7 Oct 2008 08:18:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081007032623.GX21650@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97671>

Dmitry Potapov schrieb:
> +#if defined(_WIN32) || defined(__CYGWIN__)

I think that for consistency you should use __MINGW32__ instead of _WIN32.

> +	/* On Windows, file names are case-insensitive */
> +	case 'G':
> +		if ((rest[1]|0x20) != 'i')
> +			break;
> +		if ((rest[2]|0x20) != 't')
> +			break;

We have tolower().

-- Hannes
