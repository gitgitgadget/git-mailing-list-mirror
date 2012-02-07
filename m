From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 7 Feb 2012 12:41:00 +0200
Message-ID: <20120207104100.GA24828@redhat.com>
References: <20120207070628.GA24698@redhat.com>
 <m362fjklb7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 11:41:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuiTx-0007bV-5l
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 11:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab2BGKlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 05:41:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47907 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746Ab2BGKk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 05:40:59 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q17AewUd030486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 7 Feb 2012 05:40:58 -0500
Received: from redhat.com (dhcp-4-60.tlv.redhat.com [10.35.4.60])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id q17Aeu6W016978;
	Tue, 7 Feb 2012 05:40:57 -0500
Content-Disposition: inline
In-Reply-To: <m362fjklb7.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190161>

On Tue, Feb 07, 2012 at 02:08:33AM -0800, Jakub Narebski wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > I have a tree where I checked out a remote, without
> > creating a local branch, this detaches the HEAD:
> > # git branch
> > * (no branch)
> >   master
> > #git log|head -1
> > commit cec64082f689f949a397cb9b39423dc41545fa0e
> > #git log master..HEAD|head -1
> > commit cec64082f689f949a397cb9b39423dc41545fa0e
> > 
> > 
> > Now if I try to clone it:
> > #git clone -n lab:/home/mst/scm/linux
> > Initialized empty Git repository in /home/mst/scm/linux/.git/
> > remote: Counting objects: 1693446, done.
> > remote: Compressing objects: 100% (277054/277054), done.
> > Receiving objects: 100% (1693446/1693446), 418.16 MiB | 7.63 MiB/s,
> > done.
> > remote: Total 1693446 (delta 1414353), reused 1681280 (delta 1402358)
> > Resolving deltas: 100% (1414353/1414353), done.
> > error: Trying to write ref HEAD with nonexistant object
> > cec64082f689f949a397cb9b39423dc41545fa0e
> > fatal: Cannot update the ref 'HEAD'.
> > 
> > Looks like a bug, doesn't it?
> 
> Which git version?  IIRC there was some bugfix recently in that
> area...

Sorry, forgot to mention that. It's pretty recent:
$ git --version
git version 1.7.9.111.gf3fb0


> -- 
> Jakub Narebski
