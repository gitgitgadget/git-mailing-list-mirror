From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git reset and ctime
Date: Mon, 6 Dec 2010 11:51:03 -0600
Message-ID: <20101206175102.GC6272@burratino>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
 <20101204005131.GB15906@burratino>
 <1291657037.30271.17.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ghazel@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:51:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfDZ-0006Yv-KE
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389Ab0LFRvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:51:11 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35933 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0LFRvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:51:10 -0500
Received: by vws16 with SMTP id 16so2759986vws.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aSmHfBb8X47VYrFK2KpqtH0Zxn3eQ2t4j5HrjZIhiv0=;
        b=AEKC4Q97ScX7Dzcb04KuQXqRIbcYCD48KTo8j+X0UJVG9nqvev2C/vwh02j+AEa7oI
         gNvcmp8cdGoJZgRmczq6vgRz1/LA93qrMIjfu5p3pW66HE6lzxgMnlQvPakh97dcLseK
         /hC2Vt7JU6sBa4oplNw+m1YAR3uVazRS/FvBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uLOuLBPNTUtuymYQGGtYTsx8Dz3bG4LGHrMoAtxI4BHGbexYGSlVsgaPyx0zhKWsZM
         rPWkLMsBMn7E5MuGveB+8eR8RD3kCkuoyvETR9atqXLHLX+Fuq0UDb4YLI3NcNZxad8n
         AHVMn5bZEY1GHOia1RBsDyLcDrmDcgIrfqHsw=
Received: by 10.220.201.76 with SMTP id ez12mr1548014vcb.201.1291657869660;
        Mon, 06 Dec 2010 09:51:09 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id j22sm576056vcr.7.2010.12.06.09.51.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:51:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291657037.30271.17.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163011>

Drew Northup wrote:
> On Fri, 2010-12-03 at 18:51 -0600, Jonathan Nieder wrote:

>> Interesting.  Setting "[core] trustctime = false" in the repository
>> configuration could be a good solution (no performance downside I can
>> think of).
>
> It is worth noting that many file-based backup systems which do "online"
> backups (such as in use where I work) restore the atime by default at
> the expense of the ctime (logic being that the atime may have had value
> and the ctime changes either way--which may or may not be true) on unix
> style filesystems.

So have you tried putting "[core] trustctime = false" in /etc/gitconfig?
This is exactly what the setting is for, after all.

Ideas for making this easier to find (FAQ on the git wiki?  advice from
porcelain when ctime-only changes happen?) would be welcome, of course.
