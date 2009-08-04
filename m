From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: git gc expanding packed data?
Date: Tue, 4 Aug 2009 21:25:12 +0100
Message-ID: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 22:25:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYQZa-0007mL-Rz
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 22:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbZHDUZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 16:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755184AbZHDUZO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 16:25:14 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:32822 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbZHDUZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 16:25:13 -0400
Received: by ewy10 with SMTP id 10so636650ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=6rRgAPXEqK65lzfrlee5+OOcDIuO4pGKWK7WUY7xY+U=;
        b=jIvtPheY4nt89795aDh42FZmtw2GdbsQUGW+8Lmn4R9nApEfDOy+HG8daQHqERHb+W
         XUm7k9XudwAkDrY79RBiZbo6UPMaRGT3A2KlSJD1kPrJ71h4RucUSJoJ/gP5d5TY7sWo
         qBFog/b5pTEY6nA3FhHkET/R15/GVIQRJpz5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=A4JfCuQpAtgFySew3eIeTAymJWwFIRi60J5S52eWZmEDJuGgOqAytsZdfIbniBCHjL
         Dm+9KvgYWSlSR8HtHUOhU7FHVNO7HUxlsMWOLX5inhLVmlcyhV4W4aaw6tl4qDnmL7F5
         sLNtzkzupEL4Zbtgmn7p0Y1KDh8B/Gz8n3hMs=
Received: by 10.216.45.65 with SMTP id o43mr1529066web.4.1249417512962; Tue, 
	04 Aug 2009 13:25:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124805>

I cloned gcc's git about a week ago to work on some problems I have
with gcc on minor platforms, just plain 'git clone
git://gcc.gnu.org/git/gcc.git gcc' .and ran gcc fetch about daily, and
'git rebase origin' from time to time. I don't have local changes,
just following and monitoring what's going on in gcc. So after a week,
I thought I'd do a git gc . Then it goes very bizarre.

Before I start 'git gc', .The whole of .git was about 700MB and
git/objects/pack was a bit under 600MB, with a few other directories
under .git/objects at 10's of K's and a few 30000-40000K's, and the
checkout was, well, the size of gcc source code. But after I started
git gc, the message stays in the 'counting objects' at about 900,000
for a long time, while a lot of directories under .git/objects/ gets a
bit large, and .git blows up to at least 7GB with a lot of small files
under .git/objects/*/, before seeing as I will run out of disk space,
I kill the whole lot and ran git clone again, since I don't have any
local change and there is nothing to lose.

I am running git version 1.6.2.5 (fedora 11). Is there any reason why
'git gc' does that?
