From: "=?ISO-8859-1?Q?R=E9mi_Vanicat?=" <vanicat@debian.org>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 17:44:05 +0200
Message-ID: <6b8a91420804170844t2776e8a7sf735e3f87a95298b@mail.gmail.com>
References: <87od88eslq.dlv@maison.homelinux.org>
	 <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 18:12:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmWIE-0001sQ-CD
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 17:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763599AbYDQPoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 11:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763512AbYDQPoK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 11:44:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:25344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763599AbYDQPoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 11:44:09 -0400
Received: by fg-out-1718.google.com with SMTP id l27so89998fgb.17
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=9aqDTB/leX6cTdjOYNVkUntajVB9R+wdvny7Je/TYU8=;
        b=OEoqEutr/3OJKdM73uxsOS8TTSfBaC//RhDxQq3bpk9QdK+UTOXHCPIpUlEXybAqFT18cnJ04W3CxX+dqzIEMpXwYQK+kk+VYFJNeP3dba+ZTH/lD7AYR1Tox7rrxUkJO4Y69X7i7d3OgINl6alZszIXJDflxMGgl+RRKaa58Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=d5v6DZZge2zbKekUfD2VRK1yit5O+jb5lw+afzlYqMBNjrgcKx4SE9Sd2Wi2paKqpNI3jzMKTdnnqnpAp0HmbH1q2hLr93LzEp+Fks7vac2WAedIgoDoe+kjDsWkwkgQS8oi2Ij24geVQYfyWmpAViKl0wkNCGArpOqvy6ZYw4U=
Received: by 10.86.90.2 with SMTP id n2mr2917226fgb.75.1208447045503;
        Thu, 17 Apr 2008 08:44:05 -0700 (PDT)
Received: by 10.86.84.17 with HTTP; Thu, 17 Apr 2008 08:44:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 691b1f56dbd90b3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79799>

2008/4/17, Linus Torvalds <torvalds@linux-foundation.org>:
>
>
>  On Thu, 17 Apr 2008, Remi Vanicat wrote:
[...]
>  > $ ./t4014-format-patch.sh
>  > [....]
>  > * FAIL 8: replay did not screw up the log message
>
>  Hmm. Doesn't fail for me.

[...]

>  I wonder if it is some shell-specific variable expansion issue. What's
>  your /bin/sh? (I assume, from your email address, that you're using
>  Debian, and I thought Debian used bash, but maybe that's not true).

Debian used bash, but I use dash as /bin/sh

>  What does
>
>         a="hello\nhi"
>         echo $a
>
>  result in?

here is the problem:

$/bin/sh
$ a="hello\nhi"
$ echo $a
hello
hi

Mmm, I Wonder what posix said about this, but it look like a bug with dash
