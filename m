From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 19:01:57 +0100
Message-ID: <200911301901.57652.johan@herland.net>
References: <20091130075221.GA5421@coredump.intra.peff.net> <200911301159.23383.johan@herland.net> <7vvdgrordj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFAZz-0001PA-G5
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 19:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZK3SCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 13:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbZK3SCN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 13:02:13 -0500
Received: from smtp.opera.com ([213.236.208.81]:32896 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbZK3SCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 13:02:12 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAUI0LKr025281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Nov 2009 18:00:27 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vvdgrordj.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134123>

On Monday 30 November 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > We _could_ split up the "git_remote_helpers" package into a
> > "git-remote-hg"- specific package, and a "git-remote-cvs"-specific
> > package, but that would mean either having two copies of the
> > current support code. Alternately, we could create a _third_
> > package containing the common support code, that each of our hg/cvs
> > support packages would in turn depend on. I don't think we want to
> > go there, at least not yet.
>
> I think that is typically done by the distros; in the longer term it
> would be nicer to them if we did so in our build structure, but I do
> not think we are there yet.

Agreed.

> > Also, to prevent this misunderstanding, we could create a "python"
> > subdir in git.git, and move the "git_remote_helpers" into there.
>
> If (and this is a big if, as we are not migrating to Python) the use
> of Python proliferates over time, a single "python" subdir to hold "a
> common library" to create the third package will not make sense in
> the longer term, as different services written in Python will have
> different set of common supporting code, so there will be multiple
> common libraries and you would need multiple third packages.  You
> would probably need multiple directories there, perhaps as
> subdirectories of that single toplevel directory you called "python",
> so that scripts written in Python would say "import
> pythonGit.remoteHelper" or something like that.

Yes, I agree that if we get multiple Python support packages, it makes 
sense to create a "python" subdir, and store each package as a 
subsubdir of "python". Still, I don't think we need to plan that far 
ahead now. We can do that restructuring when it becomes necessary. If 
there are no more objections, I vote for keeping the current structure 
for now.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
