From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: New repo quickly corrupted
Date: Thu, 15 Nov 2007 16:59:33 -0500
Message-ID: <31e9dd080711151359y1504e58cp994e828d44660c7@mail.gmail.com>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
	 <7vejer41ib.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ismka-0007H7-TP
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbXKOV7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756463AbXKOV7f
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:59:35 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:19750 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbXKOV7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:59:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so807698wah
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XtnFk3cC7wKcqTgt3EpYn3zaNBphn1o4rya5zD9IKOI=;
        b=d30AxfPQ662tvG/wBKAmMQvkMKiOlVdEGxM0waLDCHiL7I+wBFGErC0XTUj6l5/s7PyPd/X8dHJnN+h+RrKep8hKdalcqAh+lCNZsSkOOKV/XGNzkKGAcoJ5awoSDVqZyGg7jLr2VMvpXGVqVqVAgPV/+7z1oZYuruwH2L3NGC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aE1qvItUxTm+LDR3M2U0GxBVAVMcNaOuTL9D88y4pxmtygpn8L3iz6Fqsx0RmjgtZW1vLCWPL7jKfmt0IY/pgsBSye3UbFLv9epOP12IzsBHaRZ77PI1s6rX8tbW/9Cxy3vnbe7C6/cyRda1NXg7zlE1CC4wpW4MRQ2wWBkz+D0=
Received: by 10.115.95.1 with SMTP id x1mr364766wal.1195163974057;
        Thu, 15 Nov 2007 13:59:34 -0800 (PST)
Received: by 10.115.76.19 with HTTP; Thu, 15 Nov 2007 13:59:33 -0800 (PST)
In-Reply-To: <7vejer41ib.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65167>

On Nov 15, 2007 4:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jason Sewall" <jasonsewall@gmail.com> writes:
>
> > find . -type f -exec dos2unix {} +
> > git commit -a --amend
> > [accept same message]
> > git fsck
> > [same error message as above]
> >
> > I just built my git today, unmodified:
> > git version 1.5.3.5.721.g039b
> >
> > What's going on?
>
> Carelessness is what is going on.
>
> Notice how nicely your "find . -type f -exec dos2unix {}" goes
> down to .git/objects and eats your loose objects
>
> You probably wanted to do
>
>         git ls-files | xargs dos2unix
>
> instead.
>

Sure enough. I'll chalk that one up to too many mind-numbing meetings today.

Thanks for the wake-up...
