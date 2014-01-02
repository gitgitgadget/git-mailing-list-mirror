From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 19:11:42 +0100
Message-ID: <52C5ABDE.1010006@gmail.com>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 02 19:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VymkN-0002EX-Da
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 19:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaABSLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 13:11:51 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:38711 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaABSLu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 13:11:50 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so4575764bkh.23
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7tNQjdUnHbbk2ZuPdGx9rQBH2GOzYHKAj3wagqAKqk0=;
        b=sYtXpe6D9C28M+CVdFhEqm0d3PpWvz52pZBruSk8Dk82zzWwsJyQud9L2rZk6OLojl
         seN4TWCjABz4qI9ZPAutrtQP8A7ZF88e3KV8h81Z8FOFULnRoM4uNBVCEyF/x6onTEL+
         dluYysi1wr4a9+pu1rZgIm99QrV+f+evb6rL5tDH+fpi4Mw2UqZEmWsZDqG4nwFYEkup
         d5krSY4QWAQxniTDJab47R0Vj9LsvXTlthn5Ae+9/fBNUYfd8vACU7ufMooUB9mAuOlh
         IrTxvkpHZzI5P/qRHcGZn+svfM9Ri6d26v+KAK46uNmkJXvmpRS7Qy0H+KfioJ+qdr6e
         BILg==
X-Received: by 10.205.15.7 with SMTP id ps7mr197375bkb.106.1388686309672;
        Thu, 02 Jan 2014 10:11:49 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id np8sm42527546bkb.11.2014.01.02.10.11.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 10:11:48 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239863>

On 02.01.2014 18:33, Johannes Schindelin wrote:

> -- snip --
> On Linux, we can get away with assuming that the directory separator is a
> forward slash, but that is wrong in general. For that purpose, the
> is_dir_sep() function was introduced a long time ago. By using it in
> safe_create_leading_directories(), we proof said function for use on
> platforms where the directory separator is different from Linux'.
> -- snap --

While I'd be fine with this, I do not think we really need it. As you 
say, is_dir_sep() has been introduced a long time ago, so people should 
be aware of it, and it should also be immediately clear from the diff 
why using it is better than hard-coding '/'.

That said, I see any further explanations on top of the commit message 
title is an added bonus, and as "just" a bonus a link to a pull request 
should be fine. You don't need to understand or appreciate the concept 
of pull requests in order to follow the link and read the text in there.

-- 
Sebastian Schuberth
