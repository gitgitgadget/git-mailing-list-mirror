From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Thu, 8 Aug 2013 16:35:39 -0500
Organization: Exigence
Message-ID: <20130808163539.0b59b20a@sh9>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
	<1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
	<alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, avarab@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:35:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Xs3-0001NC-52
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966738Ab3HHVfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:35:43 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:65416 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966734Ab3HHVfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:35:42 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so6112521oag.35
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=hYS2V7PTwVsfaMung0gesmjcyXLiceLCqQrroUWxi5o=;
        b=WNiFE2sFc6UqzdqvlLandaDm8flUaexySXAl9tSXMoYZvJe1s4zXGq8GAOMBZ4R/H0
         vzQ40iaw23WWKjIfkCnmLDA07Eslp4jHQUPf4rIw7c+WZrqpgElvqIl2xSGR5I8ebsY0
         cQfJLIJA4ykz0DZwFyjPSwvZKJ010fu0azmMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=hYS2V7PTwVsfaMung0gesmjcyXLiceLCqQrroUWxi5o=;
        b=E3uOvyxaBW/I39S6cDonXhdTI44lEqzg+bqLzQHQXea/uJViJXPAGV8iQII5ovr72W
         U1GZ4zy5yDZqnRRurfsGPr3CkjvkMK/n0KuOzJjWG9WqmAFy4Dc1QII1v2sf3UgDhvEI
         wFuI9pjdttVZIkFwpIGJodz2J9wRyC2MV8C6EZP1WaLgiz8ramkGt0jBroIF7tEoGwun
         ty5uPcPSbm1tOeyOlz6nI0imGlwJGsgrfWflR7vCfRmnEc2fu3hYeOSiwIXz58Vjdcnm
         L1azuPt1dLDBVBHIxtgWExvf0XeZ5/e9sW9a8Om34hZZ1y0QmGEXM5NJ4jcVQtF/EhXO
         Ko/g==
X-Gm-Message-State: ALoCoQmzI3DTUaqwODHiODTFhyI7IVnUmZOIHTuq1RspGeiJt0sMqXHurbzpr1V1aiuMTvI0efj6
X-Received: by 10.60.145.241 with SMTP id sx17mr5827245oeb.57.1375997742041;
        Thu, 08 Aug 2013 14:35:42 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id g1sm15828208oeq.6.2013.08.08.14.35.40
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 14:35:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231937>

Hi Johannes,

> This should probably be added to config.txt and
> Documentation/git-pull.txt, too, right?

Yep, I meant to note that I'd do that after getting an initial
confirmation that the pull.preserve-merges was the preferred approach.

(I was being lazy and didn't want to write up docs only to switch to
overloading pull.rebase or what not.)

But I'll go ahead and do that.

> 	https://github.com/msysgit/git/commit/b733454b

Interesting!

> Feel free to play with it if you want!

I'll poke around out of curiosity, but no promises, as, yes, this is a
tricky bit of functionality that can quickly lead to a lot of lost
sleep. :-)

- Stephen
