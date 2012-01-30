From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [PATCH v4 1/2] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Mon, 30 Jan 2012 10:52:52 +0100
Message-ID: <20120130095252.GA6183@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
 <20120129160615.GA13937@server.brlink.eu>
 <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 10:52:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrnum-0008Bb-S8
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 10:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab2A3Jwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 04:52:38 -0500
Received: from server.brlink.eu ([78.46.187.186]:54081 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab2A3Jwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 04:52:37 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrnub-0005ZQ-Pi; Mon, 30 Jan 2012 10:52:33 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrnuu-0001qf-SB; Mon, 30 Jan 2012 10:52:52 +0100
Content-Disposition: inline
In-Reply-To: <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189334>

* Junio C Hamano <gitster@pobox.com> [120129 22:06]:
> > @@ -2864,6 +2873,10 @@ sub git_get_projects_list {
> >  				}
> >  
> >  				my $path = substr($File::Find::name, $pfxlen + 1);
> > +				# paranoidly only filter here
> > +				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
> > +					next;
> > +				}
>
> When you find "foo" directory and a project_filter tells you to match
> "foo", because $path does not match "^foo/", it will not match (even
> though its subdirectory "foo/bar" would)?

Yes, for consistency with what would be shown with a project list file.
(And that it would only show projects which would have a link to this
directory in their breadcrumbs (with 2/2)).

> Perhaps that is the topic of your second patch. I dunno.

Yes, that is what the second patch does.

        Bernhard R. Link
