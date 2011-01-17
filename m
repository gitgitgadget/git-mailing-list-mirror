From: Graham Sanderson <graham.sanderson@gmail.com>
Subject: EOL strangeness
Date: Mon, 17 Jan 2011 13:56:35 -0600
Message-ID: <AANLkTiknxMh_OophKWsqkYO2C+PsfF0ZnNXKLbheM4wF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 17 21:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pevfh-0003Dn-PI
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 21:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab1AQU1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 15:27:19 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38365 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab1AQU1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 15:27:18 -0500
Received: by ewy5 with SMTP id 5so2927687ewy.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 12:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=v7gJ4BriFjXuqzRG2M3jy6wmagbdtdZ86gPEhd03Y5Y=;
        b=HjgU1kUqAE9njK6D7SidJ7I6vF7bJuEDAFTOFq2HY5g41A8uhl7SU/Tfg03xlYrKKR
         MLPMSqQhlbtD3IiPwRLU2QDIGsjqJyAOpBhASNma4CAo6v9mg6yJsYislmBU5cOdiPiI
         LKFQxnjiosn9eI1kFhHPQ8ht5IydfwCjNmGjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aFRVtHUOgCU+57eEFcLrcF/Eyv0HqXTD/D/1AVXCX0fltxKYvfe1M3OPyvzcKFubAa
         OCNnHjioJu/5lffncr3YNIW1X8Ou+4YEjkgmY0tVs75xUE9LPP/dupdN1/q2qmPXdbfH
         xsfW9Eboy25BLplXXZWZpV1SrsA/cU/UsgzZo=
Received: by 10.216.183.195 with SMTP id q45mr3558823wem.94.1295294195844;
 Mon, 17 Jan 2011 11:56:35 -0800 (PST)
Received: by 10.216.196.156 with HTTP; Mon, 17 Jan 2011 11:56:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165178>

Apologies if someone has answered this before:

So we have moved some big teams over to git (awesome thx), and have
been using the msysgit default core.autocrlf=true on Windows, and
making sure text files are LF on other platforms

However we do continue to have a few problems with people storing CRLF
in the repository (partly because of lack of understanding, and partly
it seems because of eGit on windows which ignores core.autocrlf).

Anyway, this much is all fine, and we can fix; what I don't understand
is why for files stored as CRLF in the repository it seems
indeterminate when or if they show up locally modified (on my window
box with core.autocrlf = true) when I pull them from the repository. I
assume the idea is that that they "would be" modified if I were to
check them in, since they would be converted to LF, however this only
happens sometimes and for a seemingly random subset of the files
stored incorrectly.

It also seems to depend on the state of the local index, as recreating
the local index often changes the set of files that are displayed this
way (even without any changes to the files), and it also seems to be
different on different machines (perhaps based on when they happened
to pull code).

If anyone can give me a quick mental picture of how this is supposed
to work (i.e. at what time the eol conversions are considered) then
that'd be great... otherwise I guess I'll go dig in the code.

Thanks,

Graham.
