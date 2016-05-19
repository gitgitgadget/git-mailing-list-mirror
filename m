From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rerere: plug memory leaks upon "rerere forget" failure
Date: Thu, 19 May 2016 21:43:20 +0200
Message-ID: <573E1758.8090801@kdbg.org>
References: <xmqqpossi31p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 21:43:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Tr1-00029I-3C
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 21:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbcESTn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 15:43:27 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:36481 "EHLO bsmtp7.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbcESTn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 15:43:26 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp7.bon.at (Postfix) with ESMTPSA id 3r9hLx71FLz5tlF;
	Thu, 19 May 2016 21:43:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BF9445291;
	Thu, 19 May 2016 21:43:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqpossi31p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295094>

Am 12.05.2016 um 01:32 schrieb Junio C Hamano:
> +	if (unlink(filename)) {
> +		if (errno == ENOENT)
> +			error("no remembered resolution for %s", path);
> +		else
> +			error("cannot unlink %s: %s", filename, strerror(errno));
> +		goto fail_exit;
> +	};

If you haven't merged this topic yet, you might want to remove this 
superfluous empty statement.

-- Hannes
