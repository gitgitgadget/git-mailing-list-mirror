From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Tue, 18 Jul 2006 09:38:10 +0000
Message-ID: <f36b08ee0607180238i34cde4deib17426f121ae269e@mail.gmail.com>
References: <20060706055729.GA12512@admingilde.org>
	 <87fyh1ncm0.fsf@mid.deneb.enyo.de>
	 <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
	 <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com>
	 <Pine.LNX.4.64.0607171431010.2478@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 18 11:38:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2m1y-0003ZS-1z
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 11:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWGRJiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 05:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWGRJiM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 05:38:12 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:49186 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932105AbWGRJiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jul 2006 05:38:10 -0400
Received: by py-out-1112.google.com with SMTP id c39so1849983pyd
        for <git@vger.kernel.org>; Tue, 18 Jul 2006 02:38:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h4ewO8XYP/n2/Z3FrDxqkkIT3aC3oruOqZVaQYNLR71RuwqrPAuOdZk+TMUWEyZxMnwUcbdFC0lCL+kdDLkv4q7+aGAk0wR8fUNa6dzXMX3CWJqvc/CrJB0Qp0ck+MXqbhQxNFB3WBwvxmmRTSuoJf9Q1cvp477i9K3IkgamUg0=
Received: by 10.35.111.14 with SMTP id o14mr5258267pym;
        Tue, 18 Jul 2006 02:38:10 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Tue, 18 Jul 2006 02:38:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0607171431010.2478@evo.osdl.org>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23992>

Linus Torvalds <torvalds@osdl.org> wrote:
> Well, the thing is, you really _do_ want to mmap as much as possible of
> the pack-file as possible, if mmap() works.

Juergen Ruehle <j.ruehle@bmiag.de> wrote:
> I did some
> quick performance check and the NO_MMAP code path seems to be as fast
> as the mmap one (even much faster in some cases). So the combination
> of windows' memory management and git mmap usage doesn't seem so hot

How about making this parameter (do-use-mmap  vs  not-use-mmap)
a *runtime*  parameter  ? (Env. var. $GIT_MMAP or $GIT_USE_MMAP ?).
What do you think ? I see two benefits:
(1) much easier to benchmark two methods against each other
(2) will always work on cygwin (automatic fallback to working
    method at runtime; say depending on filesystem)

What do you say ? (Only in case when MMAP is enabled at build-time, of course)

Yakov
