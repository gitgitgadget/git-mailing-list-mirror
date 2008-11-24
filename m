From: "Oliver Charles" <oliver.g.charles@googlemail.com>
Subject: Best practices for maintaining a subversion mirror?
Date: Mon, 24 Nov 2008 10:55:55 +0000
Message-ID: <5641883d0811240255i21aef729ld202bd5a3211dad9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 11:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4Z7x-0005hh-E7
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 11:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbYKXKz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 05:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbYKXKz5
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 05:55:57 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:17053 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYKXKz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 05:55:57 -0500
Received: by qw-out-2122.google.com with SMTP id 3so339393qwe.37
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qBEuO4oO/eFVxIth2uvqb85dwifMDTerLgsTy7/txGM=;
        b=aQ0cETa96kA4WASZ305rPLBhWGNTavrMb99MPvegje3JmFafSXZOIqKVFzS0na+2hd
         NaBU7L+905JxBsJuP1CUok1fYk4313DsRXFLHcOZoKyF47Jj1MwMaVj7qe6MG/nJeOdW
         cqT5FwQz/Ub39aGYCwtN6z2qRedQOc4uh3adQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pnec8a/PSE+qpHuXJm/z1IAcNVXZrWkBmw9+KEzeaaVuzxyvoskibcutcC51KwRQCf
         jfmLLJ1DZ06dhB2mspa1bGMJhczqXMEnoKIbawilQEZJwMowhX8CziSpQkoL7ott1uzF
         qubpumrkH5+8m+Nl8b78ZgtlVoKsDM5HXqlNs=
Received: by 10.214.10.2 with SMTP id 2mr1834995qaj.266.1227524155881;
        Mon, 24 Nov 2008 02:55:55 -0800 (PST)
Received: by 10.214.183.9 with HTTP; Mon, 24 Nov 2008 02:55:55 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101598>

Hi,

I just got myself a new server, and as I'm the major Git-using person
at my work, I'd like to set a mirror of our Subversion repository up
to hopefully convert a few more people. At the moment, I've done git
svn clone http://svn..., and then git clone --bare to make a --bare
version of this clone.

Now that I have this mirror, I have this entry in my crontab to update
it hourly:

0 * * * * cd /.git && /usr/bin/git --git-dir=. svn fetch &&
/usr/bin/git update-ref refs/heads/master refs/remotes/git-svn

This seems to be working nicely as a readonly interface, but when I
clone this repository (git clone git://foo/repo.git) - served via
git-daemon - I can't seem to get svn rebase to work on it, which means
I can't dcommit my changes back to Subversion.

Am I doing things generally the right way, or am I doing it completely
wrong? :-) Any tips appreciated!

- Oliver Charles
