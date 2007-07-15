From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 18:27:41 +0200
Message-ID: <e5bfff550707150927l745926f0nab04ad82dff913@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	 <20070715104858.GG2568@steel.home>
	 <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	 <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	 <20070715083529.6855a858.seanlkml@sympatico.ca>
	 <e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
	 <20070715110415.33692142.seanlkml@sympatico.ca>
	 <e5bfff550707150858i1825e01clf0897ad4db319373@mail.gmail.com>
	 <20070715121600.792982ef.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 18:27:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA6wk-00055N-At
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 18:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761921AbXGOQ1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761915AbXGOQ1m
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 12:27:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:30363 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760970AbXGOQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 12:27:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1303117wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 09:27:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FrSU94Yhrl5GwBF515rfC+nKwunOAKvnbIxFgjx6MweI7/eZZTg7q+WPa6yMt6R7bDjPMdui/ZENCK56ZKrUwqVlPlBB8U6IrDnPLxDYb+e78Ox3bcQrKUC6aqW1NIxGUf9m0tVoH5McSfM6+MPWn7Upxg9hzCSbNtvyzGoib7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bfnkoVs829ffpGDKUL7FitiOYwnpS7uWgfstCcIYXp32rbCgm8sV648YDS9cXR4ZT1n35K5tVtwtvPCpwgTORGF1j+rQ5PK6U+f1P0aF/OeQJlktxiiAr6TMPELi7Hg54PDwJ6eWNB1gKiBgwY1WCoXCG9kKleKkKutLKjDtu/g=
Received: by 10.114.130.1 with SMTP id c1mr3398928wad.1184516861182;
        Sun, 15 Jul 2007 09:27:41 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 09:27:41 -0700 (PDT)
In-Reply-To: <20070715121600.792982ef.seanlkml@sympatico.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52570>

On 7/15/07, Sean <seanlkml@sympatico.ca> wrote:
> On Sun, 15 Jul 2007 17:58:21 +0200
> "Marco Costalba" <mcostalba@gmail.com> wrote:
>
> > What should I search for to find the revision boundary? "\n\0" ? is
> > this that you mean with ^\0
>
> Essentially yes.  That pattern will never appear inside the comment
> or patch text because both sections are always indented.  So in the
> example you cite, "\n\0" would match the proper terminator, and the
> "\n-\0" NUL would be ignored.
>

But your scheme does not fail if the patch is not \n terminated ?

It can happen if the patch adds lines at the end of a file and the
last line is not \n terminated.

In this case your scheme seems to miss the good next revision boundary.


Marco
