From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: [PATCH v2] urls.txt: document optional port specification in git URLS
Date: Wed, 4 Feb 2009 21:02:55 +0000 (UTC)
Message-ID: <loom.20090204T205910-325@post.gmane.org>
References: <7vr62et6p4.fsf@gitster.siamese.dyndns.org> <1233780575-20125-1-git-send-email-stefan.naewe+git@gmail.com> <7vvdrpore9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 22:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUovC-0002xR-Q1
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 22:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbZBDVDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZBDVDH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 16:03:07 -0500
Received: from main.gmane.org ([80.91.229.2]:40913 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbZBDVDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 16:03:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUotj-0003uM-R4
	for git@vger.kernel.org; Wed, 04 Feb 2009 21:03:03 +0000
Received: from dyndsl-095-033-043-081.ewe-ip-backbone.de ([95.33.43.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 21:03:03 +0000
Received: from stefan.naewe+git by dyndsl-095-033-043-081.ewe-ip-backbone.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 21:03:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.33.43.81 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081202 Firefox/2.0.0.6 (Debian-2.0.0.19-0etch1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108436>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Stefan Naewe <stefan.naewe <at> googlemail.com> writes:
> 
> >  ===============================================================
> >  - rsync://host.xz/path/to/repo.git/
> > -- http://host.xz/path/to/repo.git/
> > -- https://host.xz/path/to/repo.git/
> > -- git://host.xz/path/to/repo.git/
> > -- git://host.xz/~user/path/to/repo.git/
> > +- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
> > +- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
> > +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> > +- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
> >  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
> >  - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
> >  - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
> 
> Do you know if these port specifications do actually work?  Just double
> checking.
> 

A quick test with 'netcat':

In xterm 1:

$ nc -l -p 8080


In xterm 2:

$ git clone http://localhost:8080/foo/bar/baz.git

Back in xterm 1 I get:

GET /foo/bar/baz.git/info/refs HTTP/1.1
User-Agent: git/1.6.1.2
Host: localhost:8080
Accept: */*


More testing needed ?

Regards,
Stefan
