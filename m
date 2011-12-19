From: fREW Schmidt <frioux@gmail.com>
Subject: git svn can't handle giant commit
Date: Mon, 19 Dec 2011 09:28:04 -0600
Message-ID: <CADVrmKRySXFAAi5WgpgSrephbsY7JLBECF+c9ZX=_KnRxn3Lzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 16:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcf8j-0000aI-UX
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 16:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1LSP23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 10:28:29 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53904 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab1LSP22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 10:28:28 -0500
Received: by vcbfk14 with SMTP id fk14so4067386vcb.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=d1lrAcDQgYu5Sj7Mt1cVldNWfH80BGKy8QmhLQqJZKQ=;
        b=AVt+N+/AFpnEzQAgJkUvGe0RqQbj/Mz03U5nOOUyVFxTdpvLzWyHjj2MR1O9i6C68A
         YF3xRSj2VwtHxdp2JyFVhJyymh/JMeTyHP2dUpbDaENTZPvLs3ajGDmAA772nTWQi/Y/
         Oead71Zcd8GqCpm4tdCNl08neeJLDPfO8K208=
Received: by 10.220.8.146 with SMTP id h18mr1586119vch.64.1324308507848; Mon,
 19 Dec 2011 07:28:27 -0800 (PST)
Received: by 10.220.167.212 with HTTP; Mon, 19 Dec 2011 07:28:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187450>

Hey guys,

I'm working on an import of some repos and I discovered that I can't
import a certain commit due to it's size.  This is the commit:

http://perlcritic.tigris.org/source/browse/perlcritic?view=rev&revision=2676

Clearly it's large :-)

Anyway, here's the error message I get:

   Svndiff data contains invalid instruction: Invalid diff stream:
[new] insn 4 overflows the new data section at
/opt/libexec/git-core/git-svn line 5653

This is not a deal breaker as I'm fairly sure I can do the clone in
pieces as opposed to from the root (I just did the root to get a list
of authors anyway) but it seems like there should be a way to handle
something like this...

--
fREW Schmidt
http://blog.afoolishmanifesto.com
