From: skillzero@gmail.com
Subject: Super module pointing to submodule branch instead of a specific commit?
Date: Wed, 15 Oct 2008 14:16:57 -0700
Message-ID: <2729632a0810151416l3a16f6d6x4e32e457d26496bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 23:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDkz-0002C1-Fn
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYJOVQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbYJOVQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:16:59 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:18195 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbYJOVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:16:58 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1347275rnd.17
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=dZkSNC3n9NspAtMp+IW6n2zYyqYwLwxPYCths5kEc5w=;
        b=E7RQkOmnU5Hh3ebFMJPy7mzDZGYK+gM6DqzwUrReNxyRi2MF2g6eZ0yGF5naCXIa9P
         Ll/SR4q6WlWDHSJ4KXRakzqs0BLJ+CcZiAGTQsuBietEsgYLlLR179O7efeIzhNx5W1L
         Ft0U67H5Kyxy5vsyFS1LtAHNF1JnkQZwHda0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Bh5pYAzx2tr6I7c3kJRClPWc7fvW1c1rHLhovsWk3waYXw+UIPbqvIrq9SxjEo34BA
         pYiQhn2DWEerUoSJ1MiCXg91Pmz2CWzufuUj0vLhdsnQCGy8VeZY3OIc1h4Nf3diD6xt
         I6V15XEWKRMvgGemTPwc732xS2zGlcjn4WoTs=
Received: by 10.150.143.5 with SMTP id q5mr2575028ybd.7.1224105417036;
        Wed, 15 Oct 2008 14:16:57 -0700 (PDT)
Received: by 10.150.145.9 with HTTP; Wed, 15 Oct 2008 14:16:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98329>

Is there a way to have a super module point to a branch of a submodule
instead of a specific commit ID? I have a repository of common code
I'd like to use with a several different projects (each project has a
repository of its own). I want those super repositories to reference
the "stable" branch of this shared repository so that whenever they
pull one of these super modules, they get any changes made to stable
branch of the shared repository. When creating a tag of the super
module, I still want it to tag based on the commit ID of the submodule
(like I think it does today).

>From what I can tell, I seem to have to commit to the submodule then
commit the new commit ID of the submodule to every super module it is
a member of. That's somewhat tedious, but the larger problem is that
not all everyone with commit access to the submodule will has access
to all the super modules (they may not even know they exist).
