From: Perry Smith <pedzsan@gmail.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Mon, 26 Jan 2009 16:57:16 -0600
Message-ID: <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com> <20090126210027.GG27604@coredump.intra.peff.net> <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 23:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRaPp-0000Yi-4B
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 23:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZAZW5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 17:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZAZW5V
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 17:57:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:42680 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbZAZW5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 17:57:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2949102qwe.37
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=YcoMSvCt3X2Uy9F9fbgJlPimfD6M8UXCyA+dp2eGFS0=;
        b=nilQbf8his6mGvobS8loZbOnPNu787jeTxZ5nDj4pAglk+6SFnnlBEGXOaM7XRrL89
         qViioyoB4R+Bn2AhgOqT313jzPnp3CCpzOKXTg4OdlfV+qtolOUdn7TlZGVOKJ3cVvc6
         U8T7Eilx/mzdLIUgL/9rGSgZ9VTabxmjuNyLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=q5ewzWNeZyS5I7VQwkJaniFiL2WUIpoflametW1nqCoyd7xfYrdJB0+1iSqomkHI+K
         tO73gh3DdJNdulnXXv2pb1M53tPM2qMEyk32f/vCNjrfMcEVm8hWNMGvaaPekx/s/sTz
         H6PRsdTlS80cqyLwFYUTTSvoOfgvaPTHku1Xk=
Received: by 10.214.243.9 with SMTP id q9mr2518852qah.61.1233010639049;
        Mon, 26 Jan 2009 14:57:19 -0800 (PST)
Received: from NewToy.austin.ibm.com ([32.97.110.64])
        by mx.google.com with ESMTPS id 7sm6503492qwf.27.2009.01.26.14.57.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 14:57:18 -0800 (PST)
In-Reply-To: <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107293>

On Jan 26, 2009, at 4:32 PM, Mike Ralphson wrote:

> 2009/1/26 Jeff King <peff@peff.net>:
>> [cc-ing Mike Ralphson, our local AIX expert]
>
> Bless you!
>
>> On Mon, Jan 26, 2009 at 02:02:15PM -0600, Perry Smith wrote:
>>
>>> I tried building git 1.6.1 on AIX 5.3 as an "out of tree" build  
>>> and it
>>> does not seem to be set up to do out of tree builds.  If that is not
>>> true, please let me know.
>>>
>>> The install process wants to call install with a -d option.  AIX  
>>> has two
>>> install programs but they are pretty old -- neither takes a -d  
>>> option.
>>>
>>> Is there a GNU install program I can get?  I've not been able to  
>>> locate
>>> one.
>>
>> It's in GNU coreutils:
>>
>> http://www.gnu.org/software/coreutils/
>>
>> I don't know what Mike uses to install on AIX; you can see his config
>> setup here:
>>
>> http://repo.or.cz/w/git/gitbuild.git?a=tree;f=mr/aix;hb=platform
>>
>> but I don't see any override of install.
>
> I've got the AIX Toolbox for Linux applications[1] installed and ahead
> of /bin and /usr/bin on my PATH. Beware that some of these don't
> function as well as the stock AIX utilities and should normally be
> removed. I've posted about this on what is ostensibly a blog but which
> is really just a post-it note I'm less likely to lose[2].
>
> Failing that, many programs which are primarily configured using
> autoconf will ship with an install shell script which you can co-opt,
> some apache stuff does too[3].
>
> Any other questions, don't hesitate to ask.
>
> Mike
>
> [1] http://www-03.ibm.com/systems/power/software/aix/linux/index.html
>
> [2] http://mermade.blogspot.com/2008/04/aix-toolbox.html
>
> [3] http://svn.apache.org/repos/asf/tcl/websh/trunk/src/unix/install- 
> sh


Thanks guys.  I picked up coreutils version 7.   I didn't
install them but just moved ginstall over to /usr/local/bin.

A few other comments:  I had to add in the --without-tcltk flag.  I  
don't have
tcl installed but the config did not autodetect that it was not present.

I can't tell if make test is happy or not.  The output looks like its  
happy
but the exit code is 2.

Below is my "configure" script if anyone is interested.

#!/usr/bin/env bash

export CONFIG_SHELL=/usr/local/bin/bash
export LDFLAGS='-L/usr/local/lib -L/usr/local/ssl/lib'
export CFLAGS='-I/usr/local/include -I/usr/local/ssl/include'
export CC=gcc
echo CONFIG_SHELL set to ${CONFIG_SHELL}

${CONFIG_SHELL} ../../src/git-1.6.1/configure --without-tcltk

#
# Note that to install you need to do:
# make INSTALL=ginstall install
# to use GNU's install program
