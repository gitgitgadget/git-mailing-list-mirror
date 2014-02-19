From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 25/25] gc: support prune --repos
Date: Wed, 19 Feb 2014 12:22:35 -0800
Message-ID: <xmqqd2ii97jo.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-26-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDfP-0005ET-SE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbaBSUWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 15:22:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975AbaBSUWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 15:22:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84F4E6D750;
	Wed, 19 Feb 2014 15:22:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pnwZsFWAM6xYKq2QH+c9qA+5sfg=; b=aM3+Bd
	kxZvQ79NnZj19o6GeuvpuKfM18LL/N5rJcW/2lvaDQf4TwRqW8M6+VAd2nPM0nNP
	mREorasIUn5q9N2b444yil8WxIiHVMNehphM688tK0d2cw/eUlXrnqEvHfxRm/ZS
	iUSXpZJa64jNEUsHqxPK3cFrBMKZX3FfDySwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PNYPwiLn+d61hItMvwiO7rQcFo8ft0bh
	GBLV1t+JXppbYjeOkB+x/a6Jzp+yKYqRpKeCCgyg7SDj6cNydEshMHQ5HOdpqa1z
	t/dbMefNbhIIQ1ondKYNBmJJoWzMWd+bv3lviM+ljBM2dcntpOdVYiTVkbmXZLI5
	SUPGQxGvCi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EA6D6D74B;
	Wed, 19 Feb 2014 15:22:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C114B6D740;
	Wed, 19 Feb 2014 15:22:37 -0500 (EST)
In-Reply-To: <1392730814-19656-26-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 931B7CA8-99A3-11E3-B470-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242406>

(Only nitpicks during this round of review).

> @@ -274,6 +284,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
>  	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
>  	argv_array_pushl(&prune, "prune", "--expire", NULL );
> +	argv_array_pushl(&prune_repos, "prune", "--repos", "--expire", NULL );

No SP before closing ")".
