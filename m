From: Junio C Hamano <junkio@cox.net>
Subject: gitweb "tag" display
Date: Sat, 06 Aug 2005 11:27:54 -0700
Message-ID: <7vacju9az9.fsf_-_@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<20050806033654.GA27953@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 20:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1TP2-0003Mt-1K
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 20:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVHFS15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 14:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbVHFS15
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 14:27:57 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47790 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261204AbVHFS14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 14:27:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806182754.NOAU1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 14:27:54 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050806033654.GA27953@vrfy.org> (Kay Sievers's message of "Sat,
	6 Aug 2005 05:36:54 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A git tag object can have its own text contents, but I do not
see how I can get to it from gitweb.  

For example, I have "junio-gpg-pub" tag in my git.git
repository.  This is a tag to a "blob" which is my public GPG
key.  The "tag" object itself says:

    object b92c9c07fe2d0d89c4f692573583c4753b5355d2
    type blob
    tag junio-gpg-pub
    tagger Junio C Hamano <junkio@cox.net> 1123226972 -0700

    This is the GPG key I use to sign GIT releases.
    ...

to tell people that they can use it to verify the tags signed by
me.  I would appreciate that this description is visible
somewhere from gitweb.  Clicking on the link just spews out the
blob contents, which is the ascii armored public key.

Of course I _could_ add textual description outside the ascii
armor in this particular case, but that approach would not work
in general --- my next funky tag _could_ point to a JPEG picture
with the tag description that says "my beautiful wife" ;-).

I realize that I am going tangent, but it would be very cool if
gitweb understood a tag payload that said something like this:

    object b02c0c07fe2d0d80c4f602573583c4753b5355d2
    type blob
    tag my-beautiful-wife
    tagger Junio C Hamano <junkio@cox.net> 1123226072 -0700

    object-content-type: image/jpeg
    Here is a textual description of the blob being pointed at
    by this tag.  For this example, it should say "this is my
    wife's picture" or something like that.

No, I am not going to create that tag.
