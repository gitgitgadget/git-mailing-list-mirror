From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git log --parents'
Date: Sun, 8 Jul 2007 12:33:08 +0200
Message-ID: <e5bfff550707080333k6a225c6p74a7b0042e5739c8@mail.gmail.com>
References: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
	 <7vps348qzi.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707070314q3b78ac65p9a8ff3130a7bfaef@mail.gmail.com>
	 <e5bfff550707071517o776db380v9f3a68c3e46d9d3c@mail.gmail.com>
	 <7vodin2unr.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707080232q3e27581t45c0e4c5a1ea3b0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 12:33:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7U56-0003sJ-4p
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 12:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847AbXGHKdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbXGHKdO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 06:33:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:26350 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbXGHKdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 06:33:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so977885wah
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 03:33:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XMSBzy5ONzNKizwTf3VsNQXwtZJmev5UNgCz0QskXZgCZT0OXVbMay1R3ILD7XAkLGiY1j1qrg45VJYU8vRhjOvhgKXcNHmzQXNGtqjD2SJAo9fYN8gnKEsG0aOLCTnFRmNyynycXu+lWAlB9hSs++I1DdSLknenabUuxeNE9Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UtAYTwEQSyRWf0yoVkxlA2sEtMKpOR/G1RjzuQpL0ze9z+FOPjuxv3CrwrnixJqK0nzs+Ge7s0XFiq555BSVbqXl6Y7dOLqq63lIW1wjRKRwDhTtpCFSdscjWTTbrdBKCZd2evnbwQgflO1mhkS6CFzAsSteHeaBijqZACS6ohk=
Received: by 10.115.76.1 with SMTP id d1mr2153543wal.1183890788126;
        Sun, 08 Jul 2007 03:33:08 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 8 Jul 2007 03:33:08 -0700 (PDT)
In-Reply-To: <e5bfff550707080232q3e27581t45c0e4c5a1ea3b0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51872>

On 7/8/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/8/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Match "log --parent" output to "rev-list --parent" output.
> >
>
> Thanks. It works for me.
>

Sorry, I have to correct, it does *not* work for me.

Please apply your patch and give a look at:

git log --parents -n1 addafaf92e -r -m -- diff.h

What seems to happen is that duplicated entries are not removed by
diff machinery.

Although duplicated parents are correctly removed from parent list as
in git-rev-list, probably we should consider that git-log has also the
diff machinery attached.

Marco

P.S: Hope this little issue does not make you revert the patch ;-)
