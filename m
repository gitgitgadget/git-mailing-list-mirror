From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/8] filling out the notes man page
Date: Sat, 8 May 2010 22:13:57 -0500
Message-ID: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:13:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAwx6-00074R-P5
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0EIDNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 23:13:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35075 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0EIDM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:12:59 -0400
Received: by vws3 with SMTP id 3so705934vws.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=y7YVk0JD4j+4BiNK8g9LQj+4D6sCGUAjnvk1YbJQfks=;
        b=AhjUKfpvnL9f9JoCM6OM6I05JvgY0sTxwp+74KcksNsL3uwstLVmeilJJC53xGPn5C
         gmGIstauDIYVK4B03HkD40Ji9pDdgAhS0LxIPb8m7beyJjOlznSmhq+VkDqhRPiiCKSU
         5KoEUXLdBOgSZ0ahoZlQkc8Pfdpj7dtNYi/+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=nOgEw2GLt4IzHTnhuUsvfOTxFJbb4k0goC15BTy+uSznEGCbjeS/uPvpOtaXyMA6hR
         e8fPHau1kkuwPzJeppk8wXIXVtamq1GlPzNKZHIKRNSAdlfvWBY+DT+eXhQDcwpfaxuM
         4XFMJTH3FBmYeKOU44+XH5zo4ZF2aCCR3O/jM=
Received: by 10.220.123.5 with SMTP id n5mr1692742vcr.229.1273374778434;
        Sat, 08 May 2010 20:12:58 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b22sm27456615vcp.20.2010.05.08.20.12.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:12:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146691>

Hi,

Many thanks for the feedback from last round[1].  I tried to take your
comments to heart and carry them out as well as I could.  I hope you
like the result.  Doubtless some of the new text I added is unclear,
so as usual, your comments are welcome.

The first two patches sum up the low-level basics that a reader should
know.  For the format of trees, I renamed the NOTES section to
DISCUSSION and added a paragraph or two (and a footnote, triggering a
bug in docbook-xsl; more on that later); for the format of notes
blobs, I added an example to illustrate Johan=E2=80=99s trick for arbit=
rary
binary notes.  Thanks for the tip.

The next five patches aim to make the treatment of configuration a
little more systematic.  git-notes.1 gains Configuration and
Environment sections and git-log.1 gains a Configuration section (but
not Environment, because I am lazy).

Of course, there is a lot still to document.  It is not obvious to me
yet what relationship notes will have to other commands, such as
format-patch.

Thanks,
Jonathan Nieder (8):
  Documentation/notes: document format of notes trees
  Documentation/notes: describe content of notes blobs
  Documentation/notes: add configuration section
  Documentation/notes: simplify treatment of default notes ref
  Documentation/log: add a CONFIGURATION section
  Documentation/notes: simplify treatment of default display refs
  Documentation/notes: clean up description of rewriting configuration
  Documentation/notes: nitpicks

 Documentation/config.txt    |   16 +---
 Documentation/git-log.txt   |   42 ++++++++++
 Documentation/git-notes.txt |  177 +++++++++++++++++++++++++++++++++++=
++------
 t/t3307-notes-man.sh        |   38 +++++++++
 4 files changed, 238 insertions(+), 35 deletions(-)
 create mode 100755 t/t3307-notes-man.sh

[1] http://thread.gmane.org/gmane.comp.version-control.git/146269
