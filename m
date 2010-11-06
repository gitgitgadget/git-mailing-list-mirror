From: fREW Schmidt <frioux@gmail.com>
Subject: Yet another git archive all
Date: Sat, 6 Nov 2010 14:03:37 -0500
Message-ID: <AANLkTim07Ku=ETtPEutZ_gWagXdg8kVTUMMDpZcs1kMm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 20:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEo3r-0008LH-2b
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 20:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab0KFTED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 15:04:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63310 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0KFTEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 15:04:01 -0400
Received: by bwz11 with SMTP id 11so3658783bwz.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=S9V3Dp/ZBGNvgIRbvDfCkZVIWWQv8vu5joObiFFGg78=;
        b=oGquak6b20h+jfPe0JYTGGjao+CNNrh39g0juaZwmeyyNSvMVW2/DkiT5uBJZQkQ9I
         hNFWF0E518K37vuZPLPCcqWfv+50SdUCQGHc5Z87AZG4yhNWpEiyv0NG6CCzKtquSCze
         SK/QG0apmo7Fk6fJ658GoMjsYo+UlHMmZyNgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=dgEuLj0CC+cgTZMCmVxyGe8AU/FmPpe0/7iQWX6JYXzHeez7neql29gsjPccH1YPJs
         BUlOxfZoiox8aeej+V1/kOgLNx5UbqRvFyOkSlED6Dl1leOpHoOck6hSRQ0W2bQII0JT
         greYbhHfjmkHt7xBFXG3LTwMPS4Iz1TQjAVuo=
Received: by 10.204.60.12 with SMTP id n12mr3209456bkh.61.1289070238017; Sat,
 06 Nov 2010 12:03:58 -0700 (PDT)
Received: by 10.204.84.29 with HTTP; Sat, 6 Nov 2010 12:03:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160856>

I was trying to use this:
https://github.com/meitar/git-archive-all.sh/blob/master/git-archive-all.sh

but I was having issues and am not really a bash programmer, so I
wrote a new, much more minimal archive-all.

I haven't added *any* option support, it only exports as zip, and it
does foo.zip as the file, but those things should
be pretty easy to fix for someone who cares.  Anyway, here it is!

git ls-files --cached --full-name --no-empty-directory -z | xargs -0
zip foo.zip > /dev/null
git submodule --quiet foreach --recursive 'perl -e "print join qq(\0),
map qq($path/\$_), split /\0/, qx(git ls-files -z --cached --full-name
--no-empty-directory); print qq(\0)"' | xargs -0 zip foo.zip >
/dev/null

--
fREW Schmidt
http://blog.afoolishmanifesto.com
