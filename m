From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 12:18:31 +0100
Message-ID: <510F9907.7010107@drmicha.warpmail.net>
References: <1359901085.24730.11.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 12:18:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2K4c-0000mZ-C3
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 12:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab3BDLSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 06:18:31 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60196 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478Ab3BDLSa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 06:18:30 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 23F5420A0C;
	Mon,  4 Feb 2013 06:18:30 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 04 Feb 2013 06:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=W6f4DDcXTQaBY2OY8RLsnq
	1yLzo=; b=cdUH4ABkGdAm55siyWvT9yLjDl6hNWkAq6XxxC5KeivBq7FIQ11GaT
	XNxiyZXTI0H9Q2xoBFotH5vD3eM3JuIlcxxqkRo7A7BlgzoD6a8yGAEHyW0Xbmzr
	1sRIZmd3b4qBZUHpPKFprAVaBNWX33iiMwepFJZzbVLiA+fE9Fqss=
X-Sasl-enc: B0fU9uAnLuJjXhq9RlazB+qsCzBMN56wFqqUhMm6qOys 1359976709
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 936834825D3;
	Mon,  4 Feb 2013 06:18:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1359901085.24730.11.camel@t520>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215375>

Robert Clausecker venit, vidit, dixit 03.02.2013 15:18:
> Hello!
> 
> git currently has the archive command that allows to save an arbitrary
> revision into a tar or zip file. Sometimes it is useful to not save this
> revision into an archive but to directly put all files into an arbitrary
> directory. Currently this seems to be not possible to archive directly;
> the only way I found to do it is to run git archive and then directly
> unpack the archive into a directory.
> 
>     git --git-dir REPO archive REVISION | tar x
> 
> It would be nice to have a command or simply a switch to git archive
> that allows the user to put the files of REVISION into a directory
> instead of making an archive.
> 
> Thank you very much for your help. Yours,
> 
> Robert Clausecker

Sitaram has said much about the Unix philosophy already, and Konstantin
gave a variant of checkout. Just two more cents:

How would you copy a directory tree? I presume you wouldn't use "tar c .
| tar -xC gothere", but what would be your worklflow?

Depending on what you actually want to achieve, "git clone -b branch"
and removing the superfluous .git-dir might be a viable option. (Beware
the hardlinks, though.)

Michael
