From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 16:53:00 +0300
Message-ID: <ce513bcc0806240653i45044297t3b963940c5b3daf0@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Robert Haines" <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8yQ-0005CH-K1
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 15:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbYFXNxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYFXNxD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 09:53:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:5493 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYFXNxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 09:53:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7668488rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9+w7Xkt6FoxVjbyGWfL3Wkc2qU5v/l2NnQ6djE/EQBc=;
        b=A6x/SJoaSqLuc6cz303//cIcDIDmZEBaSQbiQfOattqU/f1yzpCxXiDfkYN3+tMJ8k
         tSsOwS+TDAmplkU8i4g9+svqTZUIh7wrE2eSx0D1vXcXNwpG0BjdVIoH7ldMJE+TvIA7
         fOM6AED70wYU6bZM/4btL2v0/eEpS1uwtZMy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NNZ0SpWu6VeyZ57X6IxQ/moeOgBDFIixntc65e0Zzre9RYVZRpvjRoIhFyFQv1E1yz
         RShpuo5Lw8rlKnVY9AnCD6XNXIEJv6u+eB9R482ALu9ZIBhLTqERD0snhHMnp/urxQB2
         N7B7RhdEV3UflgYTfHU9WH9aI9o6mQUZg0p3o=
Received: by 10.141.3.17 with SMTP id f17mr14799195rvi.180.1214315580436;
        Tue, 24 Jun 2008 06:53:00 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 06:53:00 -0700 (PDT)
In-Reply-To: <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86055>

On Tue, Jun 24, 2008 at 3:35 PM, Robert Haines <rhaines@manchester.ac.uk> wrote:
>> I ran git-daemon on the server side like this:
>>
>> sudo git-daemon --base-path=/pub/git/ --export-all --listen=kites
>
> So your clone address for git:// is wrong, you don't need the /pub/git:
> git clone git://erez.zilber@kites/erez.zilber/my_test.git
> As you've moved the root of the filesystem as far as git-daemon is concerned
> to /pub/git with the --base-path option.

I understand. However, when I try to run it according to your suggestion:

[root@kd001 t]# git clone git://erez.zilber@kites/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
fatal: Unable to look up erez.zilber@kites (port 9418) (Name or
service not known)
fetch-pack from 'git://erez.zilber@kites/erez.zilber/my_test.git' failed.

I also tried to run it without "erez.zilber@":

[root@kd001 t]# git clone git://kites/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
kites[0: 172.16.1.11]: errno=Connection refused
fatal: unable to connect a socket (Connection refused)
fetch-pack from 'git://kites/erez.zilber/my_test.git' failed.

Is there any log file on the server that can help me trace this
problem (something like /var/log/httpd/error_log but for the git
protocol)?

Thanks,
Erez
