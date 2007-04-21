From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 18:58:29 +0200
Message-ID: <e5bfff550704210958j5506d533wa20834b9862457fd@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
	 <200704211608.06171.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 18:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfIuw-0005NA-3l
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 18:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbXDUQ6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbXDUQ6b
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 12:58:31 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:61547 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbXDUQ6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 12:58:30 -0400
Received: by nz-out-0506.google.com with SMTP id s1so974417nze
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 09:58:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rzTE/u2fRmUGG7ma+g922hbFG4gXI19ZxLOLWQFCJ60ohyWmOCiJCM1cQB0chTsidN7b2EKbeZWZactjOACbv/ZYMO7llWDnZjlDsNnhrLzZbS/hrQpYsqGC7PWuOiFy2ZqwItfmNxyOXcLMXXprGZtY/UuOj6G3BjKFOBm409I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QzLgrSgpggE/Y9PjqMJbMbiC5Y/rDI/PkVcRxKG/qarZXMoCtAOIfAJFgtKaBRTLosxWfvZ9EM1ibfhzbCW/QI2U2rT7Usb6gSjMCkpHlf5fE9YzxZ13yZt25tnDoCtdv0hyf8XQ1yDzTs89PT8mDZJQcCzENTh/0jjKPvX/YIM=
Received: by 10.114.111.1 with SMTP id j1mr1787681wac.1177174709707;
        Sat, 21 Apr 2007 09:58:29 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 09:58:29 -0700 (PDT)
In-Reply-To: <200704211608.06171.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45179>

On 4/21/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Saturday 2007, April 21, Marco Costalba wrote:
> > Well, why to store always the full length SHA?
>
> Well apart from being easier than working out the optimum size for every
> single object write, one really good reason would be that there is no
> way to predict that an object in the future won't have a conflicting
> SHA - every object /has/ to be stored with its full hash, because you
> are preventing conflicts with everything object now, in the past and
> all possible futures.
>

Well, this is true also with 40 bytes sha, also if less probable.

Apart from this, when, in the future you are going to add an object
that conflicts with an existing one you will handle that situation for
the *new* object, as example storing with longer sha, without touching
the existing one anymore.

Well I admit I don't know exacting what I'm saying, but sometimes
ingenuity (a kind word to say ignorance) could lead to some surprises.

Marco
