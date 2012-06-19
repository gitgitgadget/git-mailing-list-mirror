From: Ryan Lortie <desrt@desrt.ca>
Subject: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 10:51:39 -0400
Message-ID: <4FE091FB.7020202@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 16:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgztT-0007VM-3h
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 16:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab2FSO6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 10:58:54 -0400
Received: from manic.desrt.ca ([207.192.74.61]:43797 "EHLO mail.desrt.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab2FSO6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 10:58:54 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2012 10:58:54 EDT
Received: from [172.16.0.159] (173-230-190-244.cable.teksavvy.com [173.230.190.244])
	by manic.desrt.ca (Postfix) with ESMTPSA id 3145F12CD23
	for <git@vger.kernel.org>; Tue, 19 Jun 2012 09:51:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200205>

hi,

After helping someone on IRC who got themselves into a bit of a problem, 
I have a feature request for git.

In this case, the user wanted to checkout a branch of a module.  They did:

   git clone git://git.gnome.org/gtk+
   cd gtk+
   git branch gtk-3-4

Obviously this is a user error, but it's a pretty innocent one, and puts 
the user in a bad state.  When they figure they should have typed "git 
checkout gtk-3-4" it is already too late -- they will be taken onto 
their locally-created copy of the master branch.

So feature request: 'git branch' should not allow creating a local 
branch that has the same name as a branch that already exists on 
'origin' (or any remote?) without some sort of --force flag.  It could 
instead helpfully say:

   """

     The branch you are trying to create already exists on the origin.
     Are you sure you don't want to checkout this branch using
     'git checkout gtk-3-4'

  """

or something like that.

Thoughts?
