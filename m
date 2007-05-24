From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 10/22] run-command: optionally clear git environment
Date: Thu, 24 May 2007 08:57:28 +0200
Message-ID: <81b0412b0705232357i535be2adl6570847942ecb9c0@mail.gmail.com>
References: <11799589913153-git-send-email-skimo@liacs.nl>
	 <11799589923790-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Martin Waitz" <tali@admingilde.org>
To: "skimo@liacs.nl" <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Thu May 24 08:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7GN-0007GE-KQ
	for gcvg-git@gmane.org; Thu, 24 May 2007 08:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbXEXG5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 02:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbXEXG5b
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 02:57:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52599 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbXEXG5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 02:57:30 -0400
Received: by ug-out-1314.google.com with SMTP id 70so825741ugb
        for <git@vger.kernel.org>; Wed, 23 May 2007 23:57:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T6vZzwFZ77XcEkuQqi5k89nJOB7O7eFvCB4H4aJ4ESu13vZ64vAUOoPFfBjdRqyh574uGbkl/0AYYDGPaPqO4NSWKe5S4DiEJx9sTK7U/jjhi4S4vlpJfNQLx3Evr6jyFyaOns7o1gOanJOHF14bUqS/qdKczHdqpTWlZYix2qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eOmYBsRPNSdnJdGBi8VUoXvud90STTC8A9uf4MwnovXALUQOJ0+1PhjGcVo8xNl3pWy+6HZk0QdS3ltGlqkHN8hdbR26ETiDieoUUKPC4NBJy4PSeFVe8nQ/V8vVI4O+o3BTHXYlXVUHKxOSYfHtxPytNhiYTiaKi4IhhEpv/+k=
Received: by 10.78.175.14 with SMTP id x14mr382940hue.1179989848542;
        Wed, 23 May 2007 23:57:28 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Wed, 23 May 2007 23:57:28 -0700 (PDT)
In-Reply-To: <11799589923790-git-send-email-skimo@liacs.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48225>

On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:
> +               if (cmd->clear_git_env) {
> +                       unsetenv(ALTERNATE_DB_ENVIRONMENT);
> +                       unsetenv(DB_ENVIRONMENT);
> +                       unsetenv(CONFIG_ENVIRONMENT);
> +                       unsetenv(GIT_DIR_ENVIRONMENT);
> +                       unsetenv(GRAFT_ENVIRONMENT);
> +                       unsetenv(INDEX_ENVIRONMENT);
> +               }

You might want to try the alternative approach from the recently
proposed patches to do the same, but more generic. Would
be less code, too.
