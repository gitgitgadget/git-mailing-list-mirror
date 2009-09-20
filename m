From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Usability question
Date: Sun, 20 Sep 2009 22:54:15 +0400
Message-ID: <20090920185415.GA6988@dpotapov.dyndns.org>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com> <vpqy6odhn0d.fsf@bauges.imag.fr> <513ca40e0909191921k1b7b14b5j7cfd8734441397d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Rob Barrett <barrettboy@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 20:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpRYH-0001XO-IZ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 20:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbZITSyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 14:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZITSyQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 14:54:16 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43755 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbZITSyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 14:54:15 -0400
Received: by bwz6 with SMTP id 6so1563842bwz.37
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EmmP80VKmlPvafe4t4gBUtY9R3RoNSxsR2ISE39a3yQ=;
        b=R109jajflKiLY8KRtQLyraRZ8RXThQGh0mnNMUnecE6xobbTpoKnuzP2AC/o/ZeC1K
         UT/ujJiHUIEyDSp2QLsWB6NrBLy63Lm9a5XMyAJ/iAczkDfTsv4QaqOUpJqPMqMJcBFB
         IqlQNlg23hMfKqU8wQUj9y5KROx+AfXg+INAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YR1fyVe6l/vPef6AA8/tPGpotQoG+USd+zoSg4LfGF3OgyZxxLv0clUl7D4/UY5hod
         LlHqWlranQSvbJ3PgFGmXljFMucSA3Zlec14DLWYQTN3lBpozSFk0LYhorFgEwfPXbXW
         hf8j0cXOJoy2dkpVUO3SYsbXEEGWoaepAofX8=
Received: by 10.204.7.144 with SMTP id d16mr3419904bkd.209.1253472858099;
        Sun, 20 Sep 2009 11:54:18 -0700 (PDT)
Received: from localhost (ppp91-76-17-42.pppoe.mtu-net.ru [91.76.17.42])
        by mx.google.com with ESMTPS id 21sm4670280fks.9.2009.09.20.11.54.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 11:54:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <513ca40e0909191921k1b7b14b5j7cfd8734441397d9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128857>

On Sun, Sep 20, 2009 at 12:21:38PM +1000, Rob Barrett wrote:
> On Thu, Sep 17, 2009 at 8:41 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Well, if you want to get rid of subcommands, why not get rid of
> > commands, too?
> >
> > git --commit
> > git --status
> > git --svn --rebase
> >
> 
> Well, granted, that's a sort of heavyweight consistency, but all we
> should need to do is to help reduce a _new_ user's confusion about
> when the word after a subcommand gets a '--' prefix and when it
> doesn't.
> 
> And do it in a way that's backwards compatible so it doesn't affect
> the usage patterns of seasoned users, existing scripts, crons etc.
> 
> Will patch and see how it looks..

It will be horrible broken... Do you realize that there is a bigger
difference between commands and options than just that commands are
written without a '--' prefix? Take a look at the following commands:

$ git -p log
$ git log -p

There are completely difference because in the former case the -p
option modifies 'git' behavior while in the later case 'git log'.

If you change commands to options, you are going to break everything.


Dmitry
