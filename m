From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: rc3 gitweb is broken, won't deliver snapshots
Date: Wed, 25 Jul 2007 09:27:55 -0400
Message-ID: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 25 15:28:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDguI-000548-SD
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 15:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbXGYN16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 09:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbXGYN16
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 09:27:58 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:9910 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbXGYN15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 09:27:57 -0400
Received: by ik-out-1112.google.com with SMTP id b32so138181ika
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 06:27:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p8FgGtmDy5byQXhPu8aJD3Je8SI2UKSDMmOTw0euCdXI/4hXU9DwZ+0cjtPb/F5nu1GOi+fKZNbqa4cbTAB3OjiX8Hpdc7+W3QbNxkHnW/NPFpiB+wTB8rxSWu+M9nQJyK73n7SZ7drmc/aqVKY/YnvceNkngw5YPzrVsV5B8d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SVUhIF3kcSwvzWk8umR7c9g+DrIIv4xOmGX3+HYmYiXFLSONai77qIZCMwrwdYJda1tOZus719AEUU17aqOoRS08DHdg9TlRbowzO47lC8kn7Jle7HZGv4HjBLo83P4foEbh6UeW1RYk79rLMH5CIJ16zdz9lgqleyKeH4N65WU=
Received: by 10.78.138.6 with SMTP id l6mr172809hud.1185370075508;
        Wed, 25 Jul 2007 06:27:55 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Wed, 25 Jul 2007 06:27:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53689>

gitweb in 1.5.3-rc3 fails to deliver snapshots in any useable format
(bzip2, gz, or zip). Clicking on a link seems to work, but the
delivered file as stored on my system is empty. No error messages
appear anywhere I can find. I am hosting gitweb on FC7 using lighttpd,
if that matters.

The snapshot service at git.kernel.org also seems broken, I don't know
what gitweb is running there so don't know if the issue is related.

I have fixed this for my use by reverting the following commits

3473e7df5f8c7f8dc3e2c3f2fdc99a1d1a719c16 gitweb: More detailed error
messages for snapshot format
a781785d8f1eb7adf05a24b121104716a086a67a gitweb: Fix support for
legacy gitweb config for snapshots
a3c8ab30a54c30a6a434760bedf04548425416ef gitweb: snapshot cleanups &
support for offering multiple formats

The snapshot problem first appears when a3c8ab30a54 is applied.

Mark Levedahl
