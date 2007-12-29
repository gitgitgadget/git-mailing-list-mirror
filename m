From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sat, 29 Dec 2007 21:39:47 +0100
Message-ID: <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 29 21:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8iTe-0003xP-3S
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 21:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXL2Ujs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 15:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXL2Ujs
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 15:39:48 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:3258 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbXL2Ujs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 15:39:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3969601rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 12:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VmcbceF5v7n52z2W2+3aiWeVcP3QDLwQrHUrkIY8o1Y=;
        b=cjaQ/7SvqUaU3edv3sd/P/vZjMz2/x++voQkCwTmgLAhWo8WZmBN1v6AQCj/OviaEDUOC1Be7cvmY0aNmdp6vyduCFftGDVA/7ghlQkIHq+Wxwhfs9ya+n34lBeOLN3Hoic26bxS1TgD3ENsrf5AFdksCiOrccEU4OUndNCatiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=krxt+tmpoh9K9PdZV/COyP/Tx74DogTmAzetJNwPq3CBlpojxQS3pN0XxwCgMM4kD5CxemS9AV4HUTzVGgQNm+SQMg1wPx5qyCMVpKsgLRBOIaFp0qSudn7YhAGDEhqG0PYjgstyID2CYcypip4dAb6eSa5dfC1rcrRv53vKZ7A=
Received: by 10.141.206.13 with SMTP id i13mr5561589rvq.100.1198960787687;
        Sat, 29 Dec 2007 12:39:47 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 12:39:47 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69330>

On Dec 29, 2007 8:22 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>         Not only does it avoid the strlen() call also for longer prefixes;
>         it also avoids a C++ comment.
>

Avoiding a C++ comment is good ;-) sorry, it slipped to me.

What your patch does not seem to avoid is a segfault if prefix or str
are NULL pointers.


Marco
