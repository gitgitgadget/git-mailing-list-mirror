From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: Re: [PATCH] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 17:05:48 +0400
Message-ID: <530F382C.2030101@yandex.ru>
References: <530F1DED.50308@yandex.ru> <530F248B.6030506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 14:17:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0pl-0004hP-5G
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbaB0NRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 08:17:00 -0500
Received: from forward4l.mail.yandex.net ([84.201.143.137]:57232 "EHLO
	forward4l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbaB0NQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 08:16:59 -0500
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 08:16:59 EST
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [37.140.190.29])
	by forward4l.mail.yandex.net (Yandex) with ESMTP id 8AF421440FD9;
	Thu, 27 Feb 2014 17:06:31 +0400 (MSK)
Received: from smtp4o.mail.yandex.net (localhost [127.0.0.1])
	by smtp4o.mail.yandex.net (Yandex) with ESMTP id 2FAF923213DD;
	Thu, 27 Feb 2014 17:06:31 +0400 (MSK)
Received: from unknown (unknown [31.181.12.71])
	by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id mqsDdEQp8s-6U88CED9;
	Thu, 27 Feb 2014 17:06:30 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: e4dcdc3b-20c0-42ac-8099-af4d03947580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393506390;
	bh=FYTOfI9Rr9qducVSNlaNuD4lDSITlr31UN0fo0+ziJ4=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=wTio6KRmnZJ+e+3iJ47Ui63hwCOh6c5YMdUiAk5ftjx/wxNXVeoh/OT4RQxQJ/gEz
	 CQ0N9rk7n1hDt+b46LzuWKT9TdoF4yMUIduf43urxqh/a/hpToUb/4SK35mH8BRKlX
	 8O7MmuXh5rTF5WRwIia6ZThut9FcWbdfsF/wxTzY=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <530F248B.6030506@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242819>

Michael,

Thank you for your remarks.

> If you look at what skip_prefix() and starts_with() do, I think you will
> find that you are doing too much work here.

How about this one?

	const char *shortname = skip_prefix(remote, "refs/heads/");
	int remote_is_branch = shortname != NULL;
