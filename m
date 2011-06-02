From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 12:28:47 +0100
Message-ID: <BANLkTimJQPvJ2oJh9BbcoZ-1ktSdAzTm2g@mail.gmail.com>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
	<20110602103833.GA4709@Imperial-SSD-Overlord>
	<BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
	<20110602105223.GB4709@Imperial-SSD-Overlord>
	<BANLkTik-o=h05=d5JH_LirYQkNzgdYaZxg@mail.gmail.com>
	<20110602111825.GC4709@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Guirgies <lt.infiltrator@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 13:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS658-0000f5-3A
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 13:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab1FBL2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 07:28:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38250 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab1FBL2s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 07:28:48 -0400
Received: by gxk21 with SMTP id 21so281572gxk.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2Kjl3xoua9WataL4an74hDQ1IutyQyriFpyqRSoI9t8=;
        b=Yn360TfJw8JYCT/mDh/A7/A9yZlGZdW7DGEPW8IM3K3CW39DRaHy+dC63lZvsUO7kM
         igp4KHSyxPp0jH0DpF1lX1DULWc4XfNuLXHhdp2je/gqWzTNR0ClifHKd7EJdKbPLWPj
         xJoKhlVqz1DGI/H2i3kj1AEvFcBXg73wemPYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=L/8d5d+QDlyq9dCbeI0w2lIw6attgWbGKQ3Fd2QPaSs+g8pIN0ByeAeCsXlslkwyhO
         Lbwzies581SL3GRzppWuOlM4fA9Fx/QIhLeMuRMuz3+1wtwW2/plLmM+aGk2pAZWBamp
         atzcQwjwu/kNu/7qyZaXkEAZDaV/w6EFy1AaQ=
Received: by 10.91.163.28 with SMTP id q28mr539139ago.165.1307014127498; Thu,
 02 Jun 2011 04:28:47 -0700 (PDT)
Received: by 10.90.116.15 with HTTP; Thu, 2 Jun 2011 04:28:47 -0700 (PDT)
In-Reply-To: <20110602111825.GC4709@Imperial-SSD-Overlord>
X-Google-Sender-Auth: UJF-PoDRphBMFMbR23JNpSNd76Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174944>

> Can you please also point out which section of the doc caused you
> confusion?
>
>

Ok... this is exactly my situation (and solution)

"First let=92s assume your topic is based on branch next. For example, =
a
feature developed in topic depends on some functionality which is
found in next.

    o---o---o---o---o  master
         \
          o---o---o---o---o  next
                           \
                            o---o---o  topic
We want to make topic forked from branch master; for example, because
the functionality on which topic depends was merged into the more
stable master branch. We want our tree to look like this:

    o---o---o---o---o  master
        |            \
        |             o'--o'--o'  topic
         \
          o---o---o---o---o  next
We can get this using the following command:

git rebase --onto master next topic"

However, I didn't look at the HEADs (seems stupid now). What I was
aiming for was (simply) for 'master' to have the 'topic' branch
changes (the delta between next and topic being applied to master if
you will). The only outstanding step was to checkout master and merge
topic (which will always bee fast-forward, of course).

It's the topic branch that gets rebased - obvious (now) but I
interpreted it as the master branch getting modified (--onto master
i.e. play the changes 'onto' master and modify master).

I didn't read it carefully enough - makes sense now.
