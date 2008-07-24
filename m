From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Submodules: Publishing a locally created submodule.
Date: Thu, 24 Jul 2008 12:21:30 -0400
Message-ID: <BLU0-SMTP14B7D0278740B42D339433AE870@phx.gbl>
References: <18071eea0807240840g79da962ci8fbc65546d496323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3gP-0004VA-In
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYGXQ1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYGXQ1u
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:27:50 -0400
Received: from blu0-omc3-s12.blu0.hotmail.com ([65.55.116.87]:44283 "EHLO
	blu0-omc3-s12.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884AbYGXQ1t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 12:27:49 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jul 2008 12:27:49 EDT
Received: from BLU0-SMTP14 ([65.55.116.72]) by blu0-omc3-s12.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 24 Jul 2008 09:21:38 -0700
X-Originating-IP: [74.14.67.222]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.14.67.222]) by BLU0-SMTP14.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 24 Jul 2008 09:21:38 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1KM4V6-0000gJ-3d; Thu, 24 Jul 2008 13:21:12 -0400
In-Reply-To: <18071eea0807240840g79da962ci8fbc65546d496323@mail.gmail.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 24 Jul 2008 16:21:38.0218 (UTC) FILETIME=[593858A0:01C8EDA9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89901>

On Thu, 24 Jul 2008 16:40:43 +0100
"Thomas Adam" <thomas.adam22@gmail.com> wrote:

> Now:  I want to make mysubmoduleB a submodule which I can publish to
> the shared repository and when others pull, to see that submodule and
> be able to treat it as such.

Hi Thomas,

Submodules are very much fully formed independent repositories.   So the
first step is to create a new Git repo that holds the files you want.  Publish
this repo in a public place, presumably the same place you published your
other submodules.

In your supermodule use  "git submodule add" to include the new public repo
as a submodule in the directory of your choice.   After which you can commit
the change and push it out.  Other people will need to do "git submodule update"
to make their repos aware of the new submodule.

HTH,
Sean
