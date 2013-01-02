From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 2 Jan 2013 00:45:48 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102054548.GA13483@thyrsus.com>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
 <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dan@archlinux.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 06:47:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqHAK-00033q-FO
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 06:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab3ABFqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 00:46:34 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33508
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3ABFqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 00:46:33 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 64EA54415C; Wed,  2 Jan 2013 00:45:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212492>

Junio C Hamano <gitster@pobox.com>:
> Dan McGee <dan@archlinux.org> writes:
> 
> > A test case snuck in this release that assumes /usr/bin/python is
> > python2 and causes test failures. Unlike all other tests and code
> > depending on python, this one does not respect PYTHON_PATH, which we
> > explicitly set when building git on Arch Linux due to python2 vs
> > python3 differences.
> 
> I had an impression that you are not supposed to run our scripts
> with python3 yet (no python scripts have been checked for python3
> compatibility), even though some people have expressed interests in
> doing so.
> 
> Eric?

Yeah, git's stuff is nowhere even *near* python3 ready.

I have it on my to-do list to run 2to3 on the in-tree scripts as a
diagnostic, but I haven't had time to do that yet...mainly because
cvsps/cvsimport blew up in my face when I poked at them.

Now I need to go beat parsecvs into shape and run both it and cvs2git
against the CVS torture tests I'm developing, so the 2to3 check won't
happen for a week or two at least. Sorry.

As in a general thing, I wouldn't advise worrying too much about python3
compatibility.  That version is not gaining adoption very fast, mainly
due to the rat's nest around plain strings vs. UTF-8 which can make
code conversion a serious pain in the ass.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
