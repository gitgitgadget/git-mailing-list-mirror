From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Cleaning up log messages
Date: Sun, 27 Jul 2008 13:50:58 -0400
Message-ID: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 19:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNAPo-0002vY-8A
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 19:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbYG0Ru7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 13:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbYG0Ru7
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 13:50:59 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:3797 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYG0Ru6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 13:50:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so849788and.103
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=oZqKN1PyxTBcVta4E90hz/7+iNNM61G6updx1/j0YDg=;
        b=DsyWL3BJ1yX1ki8F62O0VuqBkdfim3/h1b+0FUdGZ7RRYx4O4KtgNhOuobbcAocYFF
         oSGPuhZSTMc9riBKpw7UafBo8i7ihmwseNYoZ+4tbjPvN5YuGwFrKryLfzzjtEONNaFP
         ociUDBYJNFWgeNh4BddtWW4VrKleWTORqulPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Z9zkCq0iKNcCThkrtHvDZ3DyawCr/yUcYMC97CsXRzFzzXmj072QWqGPdWGS554kWG
         4aNDiHUWQduWewr23aXa0ZRi+Az7NMTRqpf/IfQ6pe/RF1CD4mTCFwQ1TgPKmH2+j/Lf
         TtCuBnDRWaL7vjevYdGZEYddjrj1/DmMLdeq0=
Received: by 10.100.124.6 with SMTP id w6mr4440090anc.92.1217181058053;
        Sun, 27 Jul 2008 10:50:58 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Sun, 27 Jul 2008 10:50:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90349>

I was playing around with git log for the kernel and observed that
there is a lot of noise when trying to do statistics on the number of
commits.

For example:

Author: Greg K-H <gregkh@suse.de>
Author: Greg KH <gregkh@suse.de>
Author: Greg KH <greg@kroah.com>
Author: Greg KH <greg@press.(none)>
Author: gregkh@suse.de <gregkh@suse.de>
Author: Greg Kroah-Hartman <gregkh@suse>
Author: Greg Kroah-Hartman <gregkh@suse.de>
Author: Greg Kroah-Hartman <greg@kroah.com>

I don't see an obvious way to do this with git, but it would be neat
to have a 'clean' option on git log that would take each email address
(author, signed-off, acked, etc) and map it through a table which
would convert old email addresses in to the current one and also
standardize the formatting of the names. A cleaned log would be
altered on display, but just don't clean it if you want the original.

Of course this initial map would need to be built by hand. New commits
could be checked against the map and the mapped updated if the person
really has a new email address. Checking new commits against the map
would help clean things up going forward. checkpatch.pl could also
validate against the mapping file.

No pressing need to for this, it would just be a nice toy.

-- 
Jon Smirl
jonsmirl@gmail.com
