From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 18:18:49 +0200
Message-ID: <e5bfff550706130918k47b2d58dq73216732c90f65ce@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	 <20070612135303.GT6073@spearce.org>
	 <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com>
	 <e5bfff550706130544m40e2f210p2412ef7fde2867a1@mail.gmail.com>
	 <Pine.LNX.4.64.0706131344430.4059@racer.site>
	 <e5bfff550706130708k601514c9o1ba2747582027699@mail.gmail.com>
	 <Pine.LNX.4.64.0706131553390.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVYg-00017y-I2
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758484AbXFMQSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbXFMQSu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:18:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:42773 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbXFMQSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:18:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so304556wah
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 09:18:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dX2t/VR7QbfGhMW6d0SaUykJ4aAQwLUicfCYjg4tm52WpJVJiqnkO2zU/Jm1yDgKrgwQa/fUYcyxNy3bKrW5SRjHnOVox4Z1VmN+zu0TVb1M94u3ThetPy+sFcjvxvDo9fjFpuz+MI49yRSJfpzpkCtLi3+QuT2P128EcRFRh/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W1B9lkF6Nx1Me6N3SQpNdjoPnhd5foFVwLA4Mq9tOQvjbcmbDt+LfPdRB7RsKJLfm5b/dV/zi8d++aVNb/aGV8gK3egvRmrNOzaWJv5ciwCNsT6eaFwDF+9qxCMj8qtwnPtuXKlMmpDTcJna2wVgYMfLiG+ddkZcQLPrXpK1mUY=
Received: by 10.114.174.2 with SMTP id w2mr759962wae.1181751529313;
        Wed, 13 Jun 2007 09:18:49 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 13 Jun 2007 09:18:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706131553390.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50087>

On 6/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
> I just tested on cygwin. The funny thing is, I never get anything like 8
> seconds (this is on git.git itself).
>
> For me it is
>
> ~1.0s   rev-list _without_ --pretty=raw
> ~1.6s   rev-list _with_ --pretty=raw
> ~1.4s   log _with_ --pretty=raw
> ~3.5s   log _with_ --pretty=raw _and_ -z (!)
>
> So, your delay could stem from -z doing weird things.
>

Yes.  I can confirm that without -z the speed is more or less the same
of git-rev-list.

I've tested with cygwin installation of git *.exe files.

>
> Draw your conclusions, gentlemen.
>

Something slows down terribly git-log under Windows when -z option is
given, expecially on cygwin.


Some idea, sir?


Thanks
Marco

P.S: I really would need a zero terminated record for parsing reasons,
and git-rev-list prints a zero terminated output too with --header
option and it works correctly.
