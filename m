From: "Holding, Lawrence" <Lawrence.Holding@cubic.com>
Subject: RE: Mixing and matching multiple projects
Date: Mon, 20 Feb 2012 13:17:23 +1300
Message-ID: <A5E8E180685CEF45AB9E737A010799802D972E@cdnz-ex1.corp.cubic.cub>
References: <7vhayptght.fsf@alter.siamese.dyndns.org> <7v39a9tf45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 01:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzH8h-0003Ge-KP
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 01:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190Ab2BTA3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 19:29:54 -0500
Received: from exprod6og108.obsmtp.com ([64.18.1.21]:45984 "HELO
	exprod6og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751840Ab2BTA3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 19:29:53 -0500
X-Greylist: delayed 745 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Feb 2012 19:29:53 EST
Received: from bb-corp-outmail1.corp.cubic.com ([149.63.70.140]) (using TLSv1) by exprod6ob108.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT0GUAFxeh+9sX3vgIS8NWL2qAFNNDZ+Y@postini.com; Sun, 19 Feb 2012 16:29:53 PST
Received: from bb-corp-ex4.corp.cubic.cub ([149.63.2.70])
	by bb-corp-outmail1.corp.cubic.com (8.13.1/8.13.1) with ESMTP id q1K0HQe7013706;
	Sun, 19 Feb 2012 16:17:26 -0800
Received: from cdnz-ex1.corp.cubic.cub ([172.19.33.136]) by bb-corp-ex4.corp.cubic.cub with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 19 Feb 2012 16:17:26 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7v39a9tf45.fsf@alter.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mixing and matching multiple projects
Thread-Index: AcztrmLVYIezIN5rTaCUQVMTGhS8oQBtBwsw
X-OriginalArrivalTime: 20 Feb 2012 00:17:26.0466 (UTC) FILETIME=[06610A20:01CCEF65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191032>

Junio C Hamano <gitster@pobox.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But I wonder if we can do without forking the /s/xyzzy/os/.git
submodule?
> >
> > If we *could* do this:
> >
> > 	cd /s/xyzzy
> >       mkdir os/drivers/frotz && populate the directory with sources
> 
> A crucial step was missing here for my story to make *any* sense.
Sorry.
> A step to create a repository at /s/xyzzy/os/drivers/frotz/.git must
be
> here, like this:
> 
>         (cd os/drivers/frotz && git init && git add . && git commit)
> 
> And then that is added as a submodule to the superproject.
> 
> >       git add os/drivers/frotz ;# to the top-level superproject!!
> >
> > to add the "frotz driver" submodule directly to the superproject,
then we
> > could leave /s/xyzzy/os/.git intact, letting it follow the open
source
> > world. Because the superproject must be forked in order to keep
track of
> > what happens in the appliance that supports the "frotz" driver
anyway,
> > this could result in the minimum amount of forking from the end
user's
> > point of view.
> >
> ........
> >
How about 
- creating a "driver" project in the superproject, 
- add a .gitignore or .git/exclude entry for the
/s/xyzzy/os/drivers/frotz folder into the os project
- symlinking the /s/xyzzy/os/drivers/frotz folder to the
/s/xyzzy/driver/frotz folder

some of this can be automated in the post checkout script of the
superproject.
