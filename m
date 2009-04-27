From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [spurious parallel build bug] make -j fails with: "mv: mv:
	cannot stat `perl.mak': No such file or directory"
Date: Mon, 27 Apr 2009 20:34:51 +0200
Message-ID: <20090427183451.GA23862@elte.hu>
References: <20090427094843.GA5849@elte.hu> <7vk5563ua8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:35:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVgD-0005rv-LF
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759301AbZD0SfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758856AbZD0SfK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:35:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46678 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758593AbZD0SfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 14:35:08 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LyVfP-00074J-74
	from <mingo@elte.hu>; Mon, 27 Apr 2009 20:35:07 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 4CEB13E2138; Mon, 27 Apr 2009 20:34:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5563ua8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117703>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > I got this when i built v1.6.3-rc3 for the first time:
> >
> > $ make -j
> > [...]
> >     CC builtin-annotate.o
> >     CC builtin-apply.o
> >     CC builtin-archive.o
> >     CC builtin-bisect--helper.o
> > mv: mv: cannot stat `perl.mak': No such file or directory
> > mv: cannot stat `perl.mak': No such file or directory
> >     CC builtin-blame.o
> > mv: cannot stat `perl.mak': No such file or directory
> > mv: cannot stat `perl.mak': No such file or directory
> > cannot stat `perl.mak': No such file or directory
> >
> > a plain 'make' worked.
> >
> > Interestingly, a second attempt to reproduce it after a 'make 
> > clean' failed to trigger the bug. So it's either timing 
> > sensitive or there's some other weirdness that caused this.
> 
> I've seen this a few times on the master machine at k.org but 
> haven't seen it elsewhere, perhaps because I do not have an access 
> to 8-way parallelism anywhere else.

btw, this happened on a plain dual-core box. But i couldnt reproduce 
after that.

	Ingo
