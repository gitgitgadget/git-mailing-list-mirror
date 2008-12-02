From: Josh Boyer <jwboyer@gmail.com>
Subject: Git as a BuildRequires (packaging)
Date: Mon, 1 Dec 2008 21:30:04 -0500
Message-ID: <20081202023004.GA30372@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skvidal@fedoraproject.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 03:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7L2w-0004l6-KN
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbYLBCaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbYLBCaN
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:30:13 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:49596 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYLBCaM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:30:12 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1100932yxm.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=qaxw9600Ouw6Uohg+dz27S+4bVgxO32euCMeoytOE5A=;
        b=PPtN2KzqPDtY/pj1fZZSyD9EhSNcHMeedkbHKwZ1nkGokkeigCFDjQ4mxIbdalPXjL
         oPZ5nA82Oy175FxutHNv2VvQu5OTmp14SNmk5SoSxIfAKKTEuyQv/2y4QgaH3F27TX/S
         TlMyROmOahTEi/bZgevoh9tHju2VQDBplx0Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=CvIMdGQpKthSNW6GLrwir/AglH3EVCEJB0WB3MAtD4pixQkdLCeUoDRB9gYukLKxtB
         g/jl4K52RQkNsauiHPRSu89y2lWhqZ+8iM3vF+RjySj9dbkqSo+znjBeuWb09UxWU2v0
         s2S72Pwak7NLlK4W1LQoTzmBgh4j4WOzXAnAI=
Received: by 10.150.205.21 with SMTP id c21mr16019576ybg.138.1228185010827;
        Mon, 01 Dec 2008 18:30:10 -0800 (PST)
Received: from zod.rchland.ibm.com (24-247-237-59.dhcp.aldl.mi.charter.com [24.247.237.59])
        by mx.google.com with ESMTPS id j13sm5653801rne.4.2008.12.01.18.30.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 18:30:10 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102106>

Hi All,

Recently we've hit an issue where a new package being reviewed for
Fedora (cgit) needs to build against the git headers.  The problem
is that these headers aren't typically installed with the git
package itself, and we have no git-devel subpackage either.  This
is mostly due to the fact that from what I can tell the upstream
git Makefile doesn't install the headers anywhere.

There are a few options here.  The first is to install the git
headers and create a git-devel subpackage.  That seems like
overkill, given that the git headers are generically named and
would have to be installed to something like /usr/include/git/.

The second option is to create a patch file that includes all
the needed headers and use that in the cgit package.  That is
sort of sub-optimal given that you'd have to keep checking
(and possibly regenerating) the patch for correctness every time
a new version of git comes out.

The third option is to include the entire git tarball as part of
the sources for the package.  That is pretty easily done with the
Fedora infrastructure, but isn't exactly clean from a packaging
standpoint.

So, what do the git gurus recommend?  I'm not sure if other
distros have tackled this problem before, but some kind of
commonality for the 'how do you package things that need to build
against git' question would be nice.

(Please CC me.  I can't remember if I'm still subscribed to the
git list or not.)

thx,
josh
