From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Decoding git show-branch output
Date: Fri, 19 Jan 2007 15:13:30 +0100
Message-ID: <8aa486160701190613j6493daccofc259a8b17c0f1d1@mail.gmail.com>
References: <17840.50115.999227.260259@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 15:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7uUu-0007Al-Ax
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 15:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbXASONc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 09:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbXASONc
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 09:13:32 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:14363 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbXASONb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 09:13:31 -0500
Received: by an-out-0708.google.com with SMTP id b33so227143ana
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 06:13:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ofBOGc8vsm3RVvbydv5oi0yKb91KyVcdMTsmoetIP2kMDSZkR5ew2DMRERYgXXByM5qQwbKeyaISfFajk8UQarfLlZmsaGNP3b8Y+S6eQcdthIq6hrYvHrXANKbasLNWHdKy7WwR0V+hViWnb22NTKCCeUyjU79o7AWC+1ywCVo=
Received: by 10.78.118.19 with SMTP id q19mr2135451huc.1169216010204;
        Fri, 19 Jan 2007 06:13:30 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 19 Jan 2007 06:13:30 -0800 (PST)
To: "Bill Lear" <rael@zopyra.com>
In-Reply-To: <17840.50115.999227.260259@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37185>

On 1/19/07, Bill Lear <rael@zopyra.com> wrote:

[...]

> I'm very confused by the syntax above.  What does "[master^2^]" mean?
> Ditto with things like "[master~3^2^2]" and "[master~3^2~2]".

They explain the relation between commits:

^ -> first parent
^n -> n-th parent
~n -> <n>th generation parent, following only the first parent.

See the manual page of git-rev-parse (or the tutorial for some simple examples).

>  Why is the order
>
> [master]
> [master^2]
> [master^2^]
> [master^]
>
> ?  I would have thought [master] would be followed by [master^], not
> [master^2].  Obviously I'm confused.

The order of the parents is not important.

> I'm used to visual representations that show things in chronological order,
> from left to right, say as
>
>                                    H---I---J  second
>                                   /
>                          E---F---G---K---L  first
>                         /
>                        /       O---P---Q  third
>                       /       /
>          A---B---C---D---M---N  master
>
> or:
>
>                                    H---I---J  second
>                                   /         \
>                          E---F---G---K---L---R  first
>                         /                     \
>                        /       O---P---Q  third \
>                       /       /         \         \
>          A---B---C---D---M---N-----------S---------T  master
>
> (third merged onto master, second onto first, first onto master)
>

Then, use gitk to visualize the graph.

> Again, apologies if this is not the appropriate forum.

Your are welcome.

Santi
