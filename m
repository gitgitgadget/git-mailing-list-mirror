From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 16:42:14 +0300
Message-ID: <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <alpine.DEB.1.00.0806241246500.9925@racer>
	 <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
	 <m3abhbkoe2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8nq-0001CL-1L
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 15:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758615AbYFXNmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758972AbYFXNmR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 09:42:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63265 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758644AbYFXNmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 09:42:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7664394rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OJjAJ8uS80GqdFVYSDpXxOBJUGgnFkTuTv2e43Trj0k=;
        b=k+FDDOCIwlnCSG7cqfPV1KVjc8cmwpOAzODs3PANvg1/eSBsBDCKzDx7P7HSE7vUau
         p0iclx4Fx50cVT4SzPHhDEVHhTqauS6Xt5rXhjurld3FPQ+PV9kNzZNaDwOQBy5WLwvg
         jgNNLakU/FgwUmWoB50lDauKu2UqP89mecwJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GUKJtKQtASlp7DVaF+Yc5/ZfwsP1uTFFf1JTRF5z57ngSq0ppCg96yXMtCM8qS4qI8
         o1O8WXeBWtaKW5L8bBMICtwrJoDujXy6sn/qHatsUuYraTbTS2rtQBms0qbxXjuQShPM
         TAhoLonXVEV0h64zld847YyXGjK84XDq66WZs=
Received: by 10.141.210.13 with SMTP id m13mr14829049rvq.25.1214314934677;
        Tue, 24 Jun 2008 06:42:14 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 06:42:14 -0700 (PDT)
In-Reply-To: <m3abhbkoe2.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86054>

On Tue, Jun 24, 2008 at 3:25 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Erez Zilber" <erezzi.list@gmail.com> writes:
>
>> I think that I'm using the right repository for git-clone because it's
>> the same path that I used for git push:
>>
>> [root@kd001 my_test.git]# git-push --all
>> ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
>
> [...]
>> looks like git-update-server-info did some work (added the refs file).
>>
>> Back to the client:
>>
>> [root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
>> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
>> Cannot get remote repository information.
>> Perhaps git-update-server-info needs to be run there?
>>
>> The path is the same path that was used for pushing the repository.
>> What did I miss here?
>
> First, obvious question: do you have web server enabled?
>

Yes

> Second, less obvious: how this server maps pathname information from
> URL into path in the filesystem?

I guess that the problem is that no proper mapping exists. That's why
I see the following in /var/log/httpd/error_log:

[Tue Jun 24 16:31:52 2008] [error] [client 172.16.0.7] File does not
exist: /var/www/html/pub

What do I need to add in /etc/httpd/conf.d/ in order to set the
mapping to /pub/git instead of /var/www/html/pub ? Is there an example
that shows how to map?

Thanks,
Erez
