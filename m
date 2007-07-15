From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 14:29:04 +0200
Message-ID: <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	 <20070715093529.GD2568@steel.home>
	 <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	 <20070715104858.GG2568@steel.home>
	 <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 14:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA3Dv-00005n-1b
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 14:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbXGOM3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 08:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755702AbXGOM3K
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 08:29:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:39354 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbXGOM3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 08:29:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1249695wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 05:29:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=scj02L6dBZFQ6TRNz1vzcKFWP81+J94oQ5VpgIscWgM08cs8N3U54FzQAnFfmW2SDmo5bRhHSUdKKszlmXNFzuOEYc92dAY064YeUdHWN4VfUmfqXtVnK4ECPQiZ7PX4+/YvrtPOHAF53af9/mUBoHlQJGC05vIuKw7R5ck4iO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dD4q8k2wfFwoVhlJDVZ6gOVtvwhQCvJOfaSr8DJMyxSZ4PzM6nzmnGHusCPIEzNUVKt6P1tuZ18JyJ3Gc23qrIkhn5Z+5cRnvI8bw/cuaS79cs+8umvNoBqUnok+w0h+An823C6HNkntKDPRxLrUdiwgUOdsyBs1dv/nnN+KLSs=
Received: by 10.114.154.1 with SMTP id b1mr3267710wae.1184502544697;
        Sun, 15 Jul 2007 05:29:04 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 05:29:04 -0700 (PDT)
In-Reply-To: <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52548>

To further push for git patch, please check this from current linux tree:

git log --parents --pretty=raw -z -r -p c4201214

As you can see the diff contains a '\0' value (actually removed by the patch).

qgit of course fails, as any tool based on parsing '\0' delimiting
character records. If the size of the patch was explicitly given
instead no fail will occur.

Marco
