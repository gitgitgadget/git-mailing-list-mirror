From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH] lockfile: show absolute filename in unable_to_lock_message.
Date: Wed, 06 Jan 2010 19:50:18 +0100
Message-ID: <4B44DB6A.2050804@kdbg.org>
References: <1262797288-23004-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSaxj-00085O-3I
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 19:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0AFSuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 13:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584Ab0AFSuW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 13:50:22 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:64268 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756066Ab0AFSuV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 13:50:21 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 634EA10020;
	Wed,  6 Jan 2010 19:50:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262797288-23004-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136287>

Matthieu Moy schrieb:
> -		    path, strerror(err));
> +			    make_absolute_path(path), strerror(err));
>  	} else
> -		strbuf_addf(&buf, "Unable to create '%s.lock': %s", path, strerror(err));
> +		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
> +			    make_absolute_path(path), strerror(err));

Since these are merely informative, wouldn't it be more suitable to use 
make_nonrelative_path()?

-- Hannes
