From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 13:57:17 -0500
Message-ID: <521f998d25eb4_174378fe7481879@nysa.mail>
References: <20130829180129.GA4880@nysa>
 <vpqli3kqqkp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7e6-0008JV-CD
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab3H2TMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:12:09 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:37375 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab3H2TMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:12:07 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so1137522oag.26
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=by0k3kVSZ4NwK70KQrBYM1lL/fPJWyVIuTr525mM9m4=;
        b=suoyDfdOMIWH+AywHphvcqYMFyArhiKnDxMpjueLO2Xh6TSIXanlrNcHzZDjsprNo3
         2npS6td5WayeYvAmVRyILiE4eyQb8gHtXxNGk4Re8xp67ZHnn6S+I6OWe5Jaqw4oN4A9
         EP8/ljhocsRnsI0St75tYu1HRIJckxU09GpOTSY45BSqYFhsAGvoE0m4mSVSNgBDlVf5
         JKm8FDHQRN4Xi52yr4IK8LhzRVkSStIFabVJiytWhDhnS6jP8oYXwukW/5dB0qyN6/H4
         iA/ySRnhwZFr6id9+XXg5lv0pFduDdGaH3PdEQ1HvKs3lwJCZyJuie5623rWP5DkHCsJ
         oQtA==
X-Received: by 10.60.43.169 with SMTP id x9mr1319056oel.88.1377803527325;
        Thu, 29 Aug 2013 12:12:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm22324984oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 12:12:06 -0700 (PDT)
In-Reply-To: <vpqli3kqqkp.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233343>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > It has been discussed many times in the past that 'index' is not an
> > appropriate description for what the high-level user does with it, and
> > it has been agreed that 'staging area' is the best term.
> 
> Thanks for working on this. No time for a really detailed review, but a
> few remarks.
> 
> > The term 'staging area' is more intuitive [...]
> >
> > The first step in moving Git towards this term, is first to add --stage
> > options for every command that uses --index or --cache.
> 
> These explanations make sense. I think it would be better to put part of
> it in commit messages, so that future contributors can "git blame" the
> doc/implem of these --stage and find them (i.e. avoid the
> misunderstanding that occured with "git stage" command which was
> proposed for removal).

Yes, but which commit? All of them? Perhaps it would make sense to add a link
to the cover e-mail, or add an explanation in Documentation/gitstagingarea.txt
or something.

> > Moreover, the --stage and --work
> 
> --work alone sounds weird. At least to me, it does not immediately imply
> "working tree". It is tempting to call the option --work-tree, but git
> already has a global option with that name (git --work-tree=foo bar).

Yes, --work sounds weird, but so does --cherry. I thought about --wt, but I
felt --work was more understandable, and --work-tree doesn't really give much
more value, except more characters to type =/

> > reset', and after these options are added, the complicated table to
> > explain the different behaviors between --soft, --mixed, and --hard
> > becomes so simple it's not needed any more:
> 
> I didn't understand the table, but yes, the --soft, --mixed, and --hard
> is terrible, I need to read the doc whenever I do something non-trivial
> with reset :-(.

Me too, I always got 'git reset --hard', now I get 'git reset', but that's
about it, for the rest I have to read the documentation. Also, 'git stage
reset' makes it even easier.

-- 
Felipe Contreras
