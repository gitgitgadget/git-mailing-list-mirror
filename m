From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 21:57:05 +0300
Message-ID: <37fcd2780803211157n15cec620gb5ab1d3e57ccd37b@mail.gmail.com>
References: <47E3DD28.4030302@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank <streamlake@tiscali.it>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:58:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcmR3-0007lL-V9
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbYCUS5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbYCUS5I
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:57:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:46494 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbYCUS5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 14:57:06 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1659354wff.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qU1OwWL9k+dTm0OhVB39vnGu+mT83gP8hO0vKK+TTj0=;
        b=Yvnc9WMdTfxqk6DmSyCs+gQjMNwJ+2rxARwOmohXH5XfFaqZOkAp9/NhfSje6+bzaVq9qqYYT6228PXi67uVdfLz/Az2S4JtI40usQ7wRED7UXmNC3BnT6AdN+v4orShQAqb76Lus9Dqqtwhkd5TU/xcrcSb2mC1UWsxX0manL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=scUfqJ1P4U3jRuxdm6p1MZDyH12Lzll/pdFUgkOnpme7Zlv5rSAmtQuSo89t3uRGBha1mLbmGIKaoz9k0S1G9Cz0LAunft6iYhLO9arw5wbcRIP/muJ0No+U9zqa1ApCtO5lTAipNfHBaMisXCjhdNO17bVXhB9ru0rdHoDKIqg=
Received: by 10.143.9.5 with SMTP id m5mr2619994wfi.94.1206125825101;
        Fri, 21 Mar 2008 11:57:05 -0700 (PDT)
Received: by 10.142.81.18 with HTTP; Fri, 21 Mar 2008 11:57:05 -0700 (PDT)
In-Reply-To: <47E3DD28.4030302@tiscali.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77759>

On Fri, Mar 21, 2008 at 7:07 PM, Frank <streamlake@tiscali.it> wrote:
> Hi,
>  Don't know exactly if this is a bug or a feature or something in the
>  middle, but I have a lot of problems while changing just the casing of
>  file names and using git mv und cygwin. Here's a test case:
>
>  mkdir testrename
>  cd testrename
>  git init
>  echo "AAA" >aaa.txt
>  echo "BBB" >bbb.txt
>  git add aaa.txt
>  git add bbb.txt
>  git commit -m "First commit"
>  git checkout -b new_branch
>  git mv aaa.txt ccc.txt
>  git commit -a -m "Moved file"
>  echo "NEW AAA" >Aaa.txt
>  git add Aaa.txt
>  git commit -m "Added Aaa"
>  #aaa.txt exists in master, Aaa.txt in new_branch
>  git checkout master

I wonder do you really need to have two files on different branches whose
name only differ by case, especially when you work on case insensitive
filesystem? I suspect the answer is no. In this case, you can choose one
policy for file naming and stick to it. For instance, that all names should
be in low case except Makefile, or something like that. This policy can be
enforced using pre-commit hook.

Dmitry
