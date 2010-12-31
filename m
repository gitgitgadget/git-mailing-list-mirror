From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix expected values of setup tests on Windows
Date: Fri, 31 Dec 2010 14:30:20 -0600
Message-ID: <20101231203019.GC5898@burratino>
References: <201012302205.13728.j6t@kdbg.org>
 <AANLkTi=uCCfBFBpC=+V9RpaXRXiiPYp-tZXBxAVNB7+e@mail.gmail.com>
 <201012311711.06989.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 31 21:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYlco-0005ag-RW
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 21:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab0LaUac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 15:30:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54936 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0LaUac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 15:30:32 -0500
Received: by qwa26 with SMTP id 26so12139101qwa.19
        for <git@vger.kernel.org>; Fri, 31 Dec 2010 12:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wBHhkULyLCiom6fv7aPQSW3w71+Yj6f0L6ANuuH3xBc=;
        b=a0vv7hEXIyb4gkodr8L7zBLYKaaa8vkRROL+nspSA3hDSunv4G6lkyjwz3gfzDh1r2
         lKJVVHCoZzdXSlJbdpYGYAyE6RPbPHYbh7/vfhhpCraKLfPq27aZrFgd8RrG5Zl3JYHy
         UViGj9ujgZ7imqwg6y0zdAddUhr/udMN5SlX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BZ1eI6sBi8O+AhXcDm7jX4jGT9Sq7f6B8tOjFkp9nRP1iB3hXJMAqNlbpfjC2aA29t
         ldPRBPZjcKFkp8whvx4cES1kWT1X0uZO3lafBZLlTYMO3n/xuZ+rF6Cm03GA1svVbEJs
         hjKtPCo3XOTPVwdNcCM71WW9X85D/HI8JtNto=
Received: by 10.224.19.203 with SMTP id c11mr16937724qab.170.1293827431264;
        Fri, 31 Dec 2010 12:30:31 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id t7sm9104976qcs.40.2010.12.31.12.30.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 31 Dec 2010 12:30:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012311711.06989.j6t@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164396>

Johannes Sixt wrote:
> On Freitag, 31. Dezember 2010, Nguyen Thai Ngoc Duy wrote:

>> in your patch does not. Does bash auto convert value in
>> TRASH_DIRECTORY="$TE..." line?
>
> No. When this line is executed:
> 
> TEST_DIRECTORY=$(pwd)
> 
> $(pwd) still has its default behavior to return the POSIX style path. pwd is 
> redefined to pwd -W only later.

Would it make sense to change it to

 TEST_DIRECTORY=$PWD

for clarity and robustness against code movement, then?
