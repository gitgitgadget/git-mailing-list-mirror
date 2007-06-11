From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Mon, 11 Jun 2007 07:45:51 +0200
Message-ID: <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jun 11 07:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxcj4-0006eg-NU
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 07:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXFKFpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXFKFpx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 01:45:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:48103 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbXFKFpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 01:45:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1970319wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:45:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kl+VMxRWZnQZiEth6YNhxTqV9un6IxBFcD7Ryl2rTLSt5+XLZleKfv5w9rrX2dkcVADZ09qTc9MHB4w74eIN26DQ4/ATV9MntrNGECDj/XNyA8jhvjV+ikgE1QyydXAM8R7ZKM2kRy0Hx/5BxoAtHP9Djo2wG3oDHqKwmFLv2RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cn5CMs4j8nBpmCmFe/CqaJb424k/2guUt0f2pA2vbLQyUzgLlFLVanx2rmZWavdGMS8O8hGA5HOSSK8jDmdKqBPUOE7gFlD2BpIPzrL0fGtRc/8oYGfx+JSYIcvZnf4A4WCvGIqakwHh9IyKqvW8EYj0qrUa1QlHnr6p461VHDk=
Received: by 10.114.173.15 with SMTP id v15mr5185546wae.1181540751857;
        Sun, 10 Jun 2007 22:45:51 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 22:45:51 -0700 (PDT)
In-Reply-To: <20070611044258.GJ4084@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49819>

On 6/11/07, Jan Hudec <bulb@ucw.cz> wrote:
>
> I think I mostly understood it now. Thank you.
>

Anyhow I think this could be useful to you:

	/*
	   getAllRefSha() returns the list of sha of a given
	   type, where type is a mask of Git::RefType flags
	   see src/git.h.
	   In this case we want the sha of the current branch
	*/
	QStringList revs = getAllRefSha(CUR_BRANCH);
	
	if (!revs.isEmpty()) {

		// all the sha info is stored in this QGit::Rev
		// class defined in src/common.h
		const Rev* r = revLookup(revs.first());

		// short log (title) is
		r->shortLog();

		// message body is
		r->longLog();

		// etc....
	}
