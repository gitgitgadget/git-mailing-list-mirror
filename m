From: "Luiz Fernando N. Capitulino" <lcapitulino@gmail.com>
Subject: [ANNOUNCE]: PyGit and libgit-thin
Date: Mon, 23 Jul 2007 09:35:47 -0300
Message-ID: <e28f90730707230535q33658efevf665d795cf1df87c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 14:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICx8j-0007bI-EV
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 14:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbXGWMft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 08:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXGWMft
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 08:35:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:49613 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbXGWMfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 08:35:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1974101wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 05:35:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cOwPNs2kTDd6Kc3ELycVPM+1MRMsK8GUvVl2M3RQ9So+v3z4QfKLbjKir3OZ/6oJRCtemu+ha0z/2SN878uq7BeUZ0lqQgr4BVFX8caDSd4eeByxbRb5XjT5IvEutQF/EJOapL4sUSojk6kNHVx6z0+SSduqMHWcL+61lS8xQS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Kb2OG5ur0jiXGUrnvxYlxaYN7+ll+k+bgdvs2G9F4zcZzyppTgMvEsgrNX1Dxtc1LbDmfk2X5C5/oLU1gdTEXkfvgxe9yfYhOV42ggfiTpa13mie4krEpYT69KSHur2mqhMM2D+e5ZXbMFGlwjb6PSHyOv4xuY06ZcHIbQcXP+U=
Received: by 10.114.14.1 with SMTP id 1mr2956848wan.1185194147273;
        Mon, 23 Jul 2007 05:35:47 -0700 (PDT)
Received: by 10.114.103.17 with HTTP; Mon, 23 Jul 2007 05:35:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53433>

Hi there,

I'm the student working on the gsoc libfication project with Shawn and it
has reached the point where I need some feedback in order to decide
what to do next.

The project's goal was/is to change what is needed in GIT in order to make
it easier to use as library. This is useful for 'external'
applications which wants
to be able to perform GIT operations w/o having to fork-exec GIT process (and
also w/o having to parse git's programs output). Example of such applications
are language bindings and IDEs' plugins.

However, the need for this is not a consensus. Some disagree (Linus included
I think) and IIRC Junio has stated that he'd probably be against a stable API.

So, in order to make things simple and have a clear separation of what is
additional interface not needed by GIT we (Shawn and I) have decided to work
on a new library which uses git's low-level interface.

That library is called libgit-thin and currently it's capable of
revision listing,
commit parsing and some other things.

To demonstrate how to use the library, I've also written a python module which
exports to python all the library's functionality.

Now I need to know whether this' really useful to other people and if so, what
would be missing for you to start using it.

The project can be found at:

http://repo.or.cz/w/git/libgit-gsoc.git

Look into the 'libgit-thin' directory. Note that it's a fork of
Junio's tree, so if you have
his repository around do:

$ git clone --reference /path/to/junio/repo git://repo.or.cz/git/libgit-gsoc.git

A demo of the python's module is available here:

http://repo.or.cz/w/git/libgit-gsoc.git?a=blob;f=libgit-thin/pygit/demo.txt;h=f4f9cb726e06ac18a3bf125f3caa7c50dd095361;hb=HEAD

Please, keep in mind that the library's code is still experimental and most of
the python module's code is untested.

It's also important to say that there's no much documentation
available, you'll have
to know a bit about git's implementation for this stuff to be useful for you.

 Thanks a lot for reading this and any kind of feedback is welcome.

-- 
Luiz Fernando N. Capitulino
