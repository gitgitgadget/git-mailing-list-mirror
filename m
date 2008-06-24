From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 17:45:07 +0300
Message-ID: <ce513bcc0806240745l365b2d22ga007deb01a93e4b6@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk>
	 <ce513bcc0806240653i45044297t3b963940c5b3daf0@mail.gmail.com>
	 <BC8F2A2A-9817-401B-BAC3-F36ED42976E5@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Robert Haines" <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9nQ-0002XV-2d
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758959AbYFXOpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759126AbYFXOpN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:45:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:39366 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758080AbYFXOpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:45:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7688103rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L5+3kyIvhgUoX6EROFesZygEsc94Xg9qCOukzgMX+kE=;
        b=Xo0xZ//3WTM4vOf8Vy2WlTv3Ew+a/hhFR3vewcfvQygNLtRQSJJ9sPgcda4h+jWgne
         dZW1n8HTY/5tS8GoExXDsEtCQ+aQcZ1vgb2xcrSe76XRsp/tG2DxbAvzIRaEsle8XARE
         RqWPpRSfVKfRAdI6H0Ae1wNgCz3bnX/QcBXf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ah8/JCr+Tm1NrbpeZTHJji7ksG2IQPcimyZZOHWowFb51wG0GhCTJBEFB1mhq/NuRv
         tiZh+j9kIh/Mppa1IyA/KjF8Tto6hfuUsq3Aj4yUBBVs4sraQUznCVyazictki40UxP9
         ST2BYYCWL5lICCiRLj47kBpygQKGty5qgoEs4=
Received: by 10.141.42.10 with SMTP id u10mr3072379rvj.292.1214318707063;
        Tue, 24 Jun 2008 07:45:07 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 07:45:07 -0700 (PDT)
In-Reply-To: <BC8F2A2A-9817-401B-BAC3-F36ED42976E5@manchester.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86066>

On Tue, Jun 24, 2008 at 5:08 PM, Robert Haines <rhaines@manchester.ac.uk> wrote:
>>> So your clone address for git:// is wrong, you don't need the /pub/git:
>>> git clone git://erez.zilber@kites/erez.zilber/my_test.git
>>> As you've moved the root of the filesystem as far as git-daemon is
>>> concerned
>>> to /pub/git with the --base-path option.
>>
>> I understand. However, when I try to run it according to your suggestion:
>>
>> [root@kd001 t]# git clone git://erez.zilber@kites/erez.zilber/my_test.git
>> Initialized empty Git repository in
>> /home/erez.zilber/work/tmp/t/my_test/.git/
>> fatal: Unable to look up erez.zilber@kites (port 9418) (Name or
>> service not known)
>> fetch-pack from 'git://erez.zilber@kites/erez.zilber/my_test.git' failed.
>
> That error is saying that the name of the service is wrong, so you're right
> to do it without the "erez.zilber@" bit.
>
>> I also tried to run it without "erez.zilber@":
>>
>> [root@kd001 t]# git clone git://kites/erez.zilber/my_test.git
>> Initialized empty Git repository in
>> /home/erez.zilber/work/tmp/t/my_test/.git/
>> kites[0: 172.16.1.11]: errno=Connection refused
>> fatal: unable to connect a socket (Connection refused)
>> fetch-pack from 'git://kites/erez.zilber/my_test.git' failed.
>
> This looks like that either there is nothing listening (if you're running
> though xinetd have you restarted it? And have you added the right bits to
> /etc/services?) or there's a firewall in the way... git defaults to 9418 so
> check that it's open.

The problem was that it listened to requests coming from the local
machine. Now (after fixing that), everything seems to work. Thanks for
the help.

BTW - I'm currently running git-daemon in the following way:

sudo git-daemon --base-path=/pub/git/ --export-all

Is there any advantage to run it through xinetd? How do you run it?

Thanks,
Erez
