From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Fetch from remote A, push to remote B
Date: Fri, 1 Jun 2007 15:51:26 +1200
Message-ID: <46a038f90705312051l663bc522r9c5c51bc803c2bc8@mail.gmail.com>
References: <46a038f90705302253s68b70311h3feac7404fa23933@mail.gmail.com>
	 <46a038f90705310028y6f180214s9018f8af5e71d0ed@mail.gmail.com>
	 <46a038f90705311737u7e9a118v9b9865f63a4c6951@mail.gmail.com>
	 <46a038f90705311852n136a2bfbwa943a65a43257a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 05:51:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtyAt-0004ld-A9
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 05:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXFADv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 23:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXFADv1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 23:51:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:30979 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbXFADv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 23:51:26 -0400
Received: by wx-out-0506.google.com with SMTP id t15so371887wxc
        for <git@vger.kernel.org>; Thu, 31 May 2007 20:51:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kNkegjqe0PhNDc1OKm80nRUTXjcVveB4/BZVTFwg0mdK8FW2pbcqCWNmnZGKzCaYbH7XEgT3wZvdyJZT4aHU7ny+Xuf+kKo3olqtWsREMp5X6JaJs67w1uKl1DqF8ujgJENleXW8lrLD8rZQdWPUUaDS7cdYiReWWwJ4z4hV31c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BV1kfEFzJ9HgLFtb9O1T3uVbw0Cb5uHCFaEM1d+XuGziWEwYaHIUcVW7g9n+qu2twwrvQ8eGs2vU8zb99OH8nxWvGITAqUj/qOY+EMshw/6CekCRmrwZB73yqY+U5tNgjjeqo/KnaABdOTThVSWfcP/tUGMEP9BOAkVyskm5/4g=
Received: by 10.90.83.14 with SMTP id g14mr1403402agb.1180669886245;
        Thu, 31 May 2007 20:51:26 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Thu, 31 May 2007 20:51:26 -0700 (PDT)
In-Reply-To: <46a038f90705311852n136a2bfbwa943a65a43257a6e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48840>

To finish off the soliloquy... effective mirroring with git

  git-clone --bare git://host/repo.git mirror.git
  git --git-dir=mirror.git config remote.origin.url git://host/repo.git
  git --git-dir=mirror.git config remote.origin.fetch
'+refs/heads/*:refs/heads/*'

  and now, on cron...
  git --git-dir=mirror.git fetch -u
  git --git-dir=mirror.git remote prune origin

(Thanks to Shawn Pearce for helping me figure out why it wasn't working for me!)

cheers



martin
