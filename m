From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-p4: Fix empty submit template when editor fires up
Date: Sun, 10 Jan 2010 05:14:40 -0600
Message-ID: <20100110111440.GB19612@progeny.tock>
References: <1262235876-1239-1-git-send-email-kevinlsk@gmail.com>
 <20100110111153.GA19612@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	gitster@pobox.com
To: Kevin Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 12:14:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTvkk-0006sH-Bm
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 12:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829Ab0AJLOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 06:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720Ab0AJLOe
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 06:14:34 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:35803 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0AJLOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 06:14:34 -0500
Received: by iwn32 with SMTP id 32so4068033iwn.33
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 03:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QXmFnIfTrbPKloskfLNVXENY7E+FAuVjY1tRQ/Q9dto=;
        b=gJh8ouis7ipQxKiG5U9G5gRNfEnvUv8K4Rk9ExZYtW6Er8DXZa+BfrqkSaS4UcDiyW
         JlrEmqISAkVvbBeJHIUviB6OfVmq0m48o43Ffm6Vs+VfFOZx8eQyKehkMPSfb+7tqZ0C
         nZe/pU/GDCSUO0X5Mpuj8hLjlOTRzW+c5SmNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iZ61rQVQZxPGnteXCJV4Rf6DqjqOyxNFyh0R3kr8rR5dCiUrO1sLv1ztuFdU8GZ+4D
         Bs6MbwCZvINYR0Z6t7Zz5JYjc6ZXM9v9bIJfYR4ygIh5F2DKy5TwNHpie18GVWqOVA6J
         wBt7EsNlA9nOvkkGd9muUEvCuZb6HGS9lE/9I=
Received: by 10.231.120.90 with SMTP id c26mr2968217ibr.1.1263122071063;
        Sun, 10 Jan 2010 03:14:31 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2682013iwn.14.2010.01.10.03.14.30
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 03:14:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100110111153.GA19612@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136567>

Jonathan Nieder wrote:
> Kevin Leung wrote:
> > read_pipe() returns "\n". We need to remove it before passing it
> > to system().
> > 
> > Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
> 
> If I understand correctly, this is a cosmetic change:

... and of course I didn't the subject.  Sorry about that.  Thanks
for cleaning up my mess.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

> What is the rationale for the rewritten system() line?  I would have
> understood a change to
> 
> 	os.spawnlp("sh", "-c", editor + " \"$@\"", fileName)

I am still curious about this, though it is not so important.

Jonathan
