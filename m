From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: chdir now properly sets PWD environment variable in msysGit
Date: Tue, 5 Aug 2008 10:24:22 +0200
Message-ID: <200808051031.00121.simon@lst.de>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com> <7v7iaxu7i1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Robert Blum" <rob.blum@gmail.com>, shausman@trolltech.com,
	marius@trolltech.com, hanwen@google.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 10:32:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQHxk-0001jo-Mm
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 10:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbYHEIbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 04:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbYHEIbJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 04:31:09 -0400
Received: from hoat.troll.no ([62.70.27.150]:34002 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755456AbYHEIbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 04:31:07 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9C63F209F9;
	Tue,  5 Aug 2008 10:31:00 +0200 (CEST)
Received: from rhea.localnet (rhea.troll.no [10.3.4.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 8F7EB209CA;
	Tue,  5 Aug 2008 10:31:00 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.24-18-generic; KDE/4.1.0; x86_64; ; )
In-Reply-To: <7v7iaxu7i1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91433>

On Sunday 03 August 2008 23:13:42 Junio C Hamano wrote:
> "Robert Blum" <rob.blum@gmail.com> writes:
> > P4 on Windows expects the PWD environment variable to be set to the
> > current working dir, but os.chdir in python doesn't do that by default
>
> Missing full stop at the end of sentence aside, this comment makes me
> wonder if there is an optional way to have it set it, as opposed to the
> inconvenient way it behaves "by defualt".  If there is none, I think your
> patch, even though it looks ugly, is the least evil approach.  Another way
> might be to wrap callsites of system() by introducing a "run_p4" function,
> like:
>
> 	def run_p4(arg):
>         	os.environ['PWD'] = os.getcwd() if os.name == 'nt'
> 		return system(arg)
>
> > ---
> >
> > Pushing it out to the list since I'm not entirely sure who the git-p4
> > owner even is. CC'ed likely suspects for ownership ;)
>
> Thanks.  I've been waiting for an Ack from somewhere or success reports
> from p4 users on Windows.

Acked-by: Simon Hausmann <simon@lst.de>

It may not be the prettiest solution, but I agree it needs to be solved :)

Simon
