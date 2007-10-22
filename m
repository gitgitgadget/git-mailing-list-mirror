From: "Eric Merritt" <cyberlync@gmail.com>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Mon, 22 Oct 2007 12:25:21 -0700
Message-ID: <f69c840c0710221225u5df73cf9x7f95ea3bd530c160@mail.gmail.com>
References: <20071022170148.GB29642@srparish.net>
	 <20071022190102.GA23714@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Scott R Parish" <srp@srparish.net>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik2u7-0006kI-KL
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbXJVTZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbXJVTZX
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:25:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:58420 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbXJVTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 15:25:23 -0400
Received: by nz-out-0506.google.com with SMTP id s18so526983nze
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4QilpJblzsOsuZi9/y8BTE7aTecP+V+9Hg0PUXcLZs0=;
        b=mYIaMvKbcJiMY5oc7dXeSutqz6D0VzZKcyiRukHx32rNHEF5jEU5zIsvqYozZi2iWG0pfanRMZC5yZGUTu5/kJ47Snm8Pe0DsMSBYI5Ya2Q81zKCDhgSDdQPXyJAAW2V+OfycXW6g9ouOcjN0vXHk90bmv69wD9qmrhnxIa1ies=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWVYyqEkZne/gfD3XWtm8cl98KuK2iQsA019+97NzxJ80c31z2Y/wfn40FpFOW5Po/7GOMSY9bcaKi0P5F3nZAr8v3iMNM7BTYLU1hvM5frhe7mxI2c73+pHMuNg4dysoJxPOSOl5f6nQTAyXRcqLppLXCFStodONnLkKz5ABEM=
Received: by 10.114.153.18 with SMTP id a18mr2516887wae.1193081121127;
        Mon, 22 Oct 2007 12:25:21 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Mon, 22 Oct 2007 12:25:21 -0700 (PDT)
In-Reply-To: <20071022190102.GA23714@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62037>

> the default PATH is platform-dependent. Git is multi-platform.
> You should consider putting the path list somewhere in Makefile,
> config.mak or configure.

This static configuration that you describe is one of the things this
patch is designed to strip out. Compile time configuration breaks down
completly if you don't deploy to the path defined when the system was
compiled. Thats a problem.
