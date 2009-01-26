From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Mon, 26 Jan 2009 22:32:37 +0000
Message-ID: <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
	 <20090126210027.GG27604@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 23:34:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRa1t-0000fr-Ne
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 23:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZAZWck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 17:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZAZWck
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 17:32:40 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:41012 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbZAZWcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 17:32:39 -0500
Received: by qyk4 with SMTP id 4so6796845qyk.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 14:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nRO+pG9t0N0g9ygNCs26L67mSsNtg+ljaZM3NBeQ4ps=;
        b=K9n636R/M/xeC/E4Z9fz7676TAJdq+XJ1KMnhHcb6SU7BJh1w6WsFpAUSFxA7wn1/E
         +8/wm+sdLO0i8PuEtysW27UqSZZe3XsiYmdYfrvUyKDaFtSkVPk9dqWcnhiHUJ+glLFm
         0L6DT5q3cmPuvcGjqwPNjC2Iio2jWIQTSYIiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SzCAq/TiwO2bpAzUJO13tBblJbLlxFQwdrDgCtfkMrGzomjNTIwZM7iSxJThAzYqDW
         /gI3FX14cj1hXhvTe4L+9sOGOmaHQfTl9huG8TccS+XbuSu0wYYZaCjMjXcDWjzzbKpW
         YHA3AfiAem+Gvo7TUC7Bkl9P/2k84d58vpDdg=
Received: by 10.214.59.5 with SMTP id h5mr2931666qaa.181.1233009157423; Mon, 
	26 Jan 2009 14:32:37 -0800 (PST)
In-Reply-To: <20090126210027.GG27604@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107292>

2009/1/26 Jeff King <peff@peff.net>:
> [cc-ing Mike Ralphson, our local AIX expert]

Bless you!

> On Mon, Jan 26, 2009 at 02:02:15PM -0600, Perry Smith wrote:
>
>> I tried building git 1.6.1 on AIX 5.3 as an "out of tree" build and it
>> does not seem to be set up to do out of tree builds.  If that is not
>> true, please let me know.
>>
>> The install process wants to call install with a -d option.  AIX has two
>> install programs but they are pretty old -- neither takes a -d option.
>>
>> Is there a GNU install program I can get?  I've not been able to locate
>> one.
>
> It's in GNU coreutils:
>
>  http://www.gnu.org/software/coreutils/
>
> I don't know what Mike uses to install on AIX; you can see his config
> setup here:
>
>  http://repo.or.cz/w/git/gitbuild.git?a=tree;f=mr/aix;hb=platform
>
> but I don't see any override of install.

I've got the AIX Toolbox for Linux applications[1] installed and ahead
of /bin and /usr/bin on my PATH. Beware that some of these don't
function as well as the stock AIX utilities and should normally be
removed. I've posted about this on what is ostensibly a blog but which
is really just a post-it note I'm less likely to lose[2].

Failing that, many programs which are primarily configured using
autoconf will ship with an install shell script which you can co-opt,
some apache stuff does too[3].

Any other questions, don't hesitate to ask.

Mike

[1] http://www-03.ibm.com/systems/power/software/aix/linux/index.html

[2] http://mermade.blogspot.com/2008/04/aix-toolbox.html

[3] http://svn.apache.org/repos/asf/tcl/websh/trunk/src/unix/install-sh
