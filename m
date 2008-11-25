From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 12:10:43 -0800 (PST)
Message-ID: <m3skpfk1mp.fsf@localhost.localdomain>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com>
	<alpine.LNX.1.00.0811251327480.19665@iabervon.org>
	<200811252001.37259.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gary Yang <garyyang6@yahoo.com>, git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L54GR-000693-5c
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 21:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYKYUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYKYUKr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 15:10:47 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:60995 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYKYUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 15:10:46 -0500
Received: by rn-out-0910.google.com with SMTP id k40so160445rnd.17
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=z4Xfo6wsrebgptpYFlMBn6VNQvX7OWwsVmKe1xvvZ70=;
        b=dXf9lLdAj4krniTTlE2nEMoUVxzjbxZPS6VPb2dG8ujSVqqIwP3bQHvxvDRl+P3xiD
         pLupI9MF9CUjtXdpIad9xwa7yRwcuFXYXKAee0GD6irM9UDb9KFf4cIF09oFmcW4E00+
         d+2c/eIykv+CmwA1jBVlmOs50bgMwnN+SLeAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Mbv88pQoqFbtvfCRwR7ZZ6BaM6PiYbFVSBTrh4FncpEHR+ntXYeJzBkPZ/efp+NVi8
         f8DYMf+1Qc7lqIaCtKQv+QXluGy194Zn8V+BHeNUCy7iEVWrK8bXktrGphuRs4Grbp1L
         6AFtBMBKdJsUHG71JDJ4ApMUCvSrgNEazs3Aw=
Received: by 10.103.222.1 with SMTP id z1mr1771098muq.51.1227643844233;
        Tue, 25 Nov 2008 12:10:44 -0800 (PST)
Received: from localhost.localdomain (abvl147.neoplus.adsl.tpnet.pl [83.8.209.147])
        by mx.google.com with ESMTPS id g1sm5007667muf.47.2008.11.25.12.10.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Nov 2008 12:10:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAPKAf3j030149;
	Tue, 25 Nov 2008 21:10:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAPKAcrx030146;
	Tue, 25 Nov 2008 21:10:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200811252001.37259.thomas@koch.ro>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101678>

Thomas Koch <thomas@koch.ro> writes:
> Am Tuesday 25 November 2008 19:38:02 schrieb Daniel Barkalow:
> > On Mon, 24 Nov 2008, Gary Yang wrote:

> > > Do I have to create two git servers? One is for public to download the
> > > released code. For example: gitpub.mycompany.com:/pub/linux/kernel.
> >
> > The public can't generally use this URL, because it's an ssh URL, and they
> > won't be able to connect with ssh. They can only really use
> > git://gitpub.mycompany.com/pub/linux/kernel or something similar.
> >
> > The normal pattern is to have R/W access with ssh and anonymous read
> > access via git://...; you can then have multiple repositories on the same
> > host, with the git server only serving the public one. All of them will be
> > accessible to the ssh methods (restricted by the user's UNIX permissions
> > on the files in those directories).

To control access via SSH protocol (which can be used both for
fetching and for pushing), you can either configure accounts and
user/groups permissions on repository directories, or you can use
external tool like ssh_acl or Gitosis.

To control access via HTTP you can employ authorization and
authentication from your web server; for push this would be matter of
setting up WebDAV.

To control access via anonymous git:// protocol, you can use whitelist
and blacklist mechanism built in git-daemon; by default only
repositories with git-daemon-export-ok in them (in .git) are exported,
if I understand correctly.


Additionally, if protocol is authenticated you can use hooks mechanism
like example contrib/hooks/update-paranoid to restrict access (and
with finer granularity too).

> Do you now of a way to show public repos with gitweb to the public and
> private repos to the staff with the same gitweb installation?

You can quite simply restrict access to some directories/repositories,
or the fact that they are listed in list of all projects for _all_
clients quite easily (see description of GITWEB_EXPORT_OK in
gitweb/README and gitweb/INSTALL).

If you have something more fancy, check out newest gitweb and take a
look at gitweb/INSTALL: you can now, thanks to commit dd7f5f1 by
Alexander Gavrilov, see
  http://permalink.gmane.org/gmane.comp.version-control.git/99962

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
