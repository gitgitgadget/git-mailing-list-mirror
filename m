From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 01/14] submodule: don't access the .gitmodules cache
 entry after removing it
Date: Thu, 07 Nov 2013 23:27:06 +0100
Message-ID: <527C13BA.1030205@hvoigt.net>
References: <527BA483.6040803@gmail.com> <527BA4C7.4020700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:27:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeY2r-0008VM-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab3KGW1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:27:18 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:40039 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3KGW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:27:16 -0500
Received: from [77.20.34.36] (helo=[192.168.178.45])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VeY2d-0002QF-HX; Thu, 07 Nov 2013 23:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA4C7.4020700@gmail.com>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237442>

Hi,

it looks like there is a "From: Jens ..." line missing on top of this patch.

Am 07.11.2013 15:33, schrieb Karsten Blees:
> Commit 5fee995244e introduced the stage_updated_gitmodules() function to
> add submodule configuration updates to the index. It assumed that even
> after calling remove_cache_entry_at() the same cache entry would still be
> valid. This was true in the old days, as cache entries could never be
> freed, but that is not so sure in the present as there is ongoing work to
> free removed cache entries, which makes this code segfault.
>
> Fix that by calling add_file_to_cache() instead of open coding it. Also
> remove the "could not find .gitmodules in index" warning, as that won't
> happen in regular use cases (and by then just silently adding it to the
> index we do the right thing).
>
> Thanks-to: Karsten Blees <karsten.blees@gmail.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Cheers Heiko
