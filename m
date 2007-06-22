From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 09:23:49 -0400
Message-ID: <799406d60706220623r17c0e3c6rca86a33d01ee6c7e@mail.gmail.com>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 15:23:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1j7H-0005fr-5P
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 15:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXFVNX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 09:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbXFVNX5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 09:23:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:48628 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXFVNX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 09:23:56 -0400
Received: by wx-out-0506.google.com with SMTP id t15so813105wxc
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 06:23:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GZw6Wj8DbeJllN7JQEI0tHaW/7H3KyHraEUBhZpp0W5aRl0w3m6DAXhbUGRqhkcxeTBt6SX/y5n+opSALniy5cOR+3VxyssIw4stoi1aPsoQ6Ilz7ZfmxI4LRymSSSuIQPckIlp8RaNHfROgx8cvS0Ul9CyTrSNucUhd6Oj4Ieg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EXuKbaLDItoGQqA1NyUb1Z4NLxaQSpMvIEybu/d8y4DGfZrt9uqsVWFzdWUtKrUFvVnTIrzKmz6tWwdpmKkzFeSwENGXiMv4y6P3gvKBYBFgjEaZq0hEedJpQoU3FMnZTpNI6ivdYz3MeRTGpe7WV/q5pUm7ZLGpb6qJyqjDuOs=
Received: by 10.90.104.14 with SMTP id b14mr2556953agc.1182518634383;
        Fri, 22 Jun 2007 06:23:54 -0700 (PDT)
Received: by 10.90.28.17 with HTTP; Fri, 22 Jun 2007 06:23:49 -0700 (PDT)
In-Reply-To: <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50695>

On 21/06/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Adam Mercer" <ramercer@gmail.com> writes:
>
> > [ram@skymoo glue]$ git push
> > ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git
> > bash: line 1: git-receive-pack: command not found
> > fatal: The remote end hung up unexpectedly
> > error: failed to push to
> > 'ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git'
> > [ram@skymoo glue]$ which git-receive-pack
> > /Users/ram/opt/git/bin/git-receive-pack
> > [ram@skymoo glue]$
> >
> > git-receive-pack is in my $PATH so why can't it be found when trying to push?
>
> Check your ssh and ssh server settings.  Often the process
> invoked from non-interactive ssh connection (such as the attempt
> to invoke receive-pack) would not get the PATH you set up in ~/.login
> or ~/.bash_profile.
>
>         $ ssh newberry.ihepa.ufl.edu sh -c 'echo $PATH'
>
> may be a good starting point to test this, and the first step
> to fix it would be
>
>         $ man ssh
>         $ man sshd

Thanks Junio thats the problem my path isn't being set correctly on newberry

[ram@skymoo ram]$ ssh newberry sh -c 'echo $PATH'

[ram@skymoo ram]$ ssh newberry
[ram@newberry ram]$ which git-receive-pack
~/opt/git/bin/git-receive-pack
[ram@newberry ram]$

Cheers

Adam
