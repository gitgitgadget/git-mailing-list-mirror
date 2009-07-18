From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git svn .git/svn/*/index files taking up huge amounts of disk 
	space
Date: Sat, 18 Jul 2009 14:10:17 -0400
Message-ID: <eaa105840907181110q416a9dd0j989a63eedd9b15ca@mail.gmail.com>
References: <CFF1FF99-9237-4C89-BB2D-66F82CF683B1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 20:10:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSEMd-0005py-K3
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 20:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbZGRSKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jul 2009 14:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbZGRSKU
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 14:10:20 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:42403 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZGRSKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 14:10:19 -0400
Received: by ewy26 with SMTP id 26so1517622ewy.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Jdgv5t8NOyEta6Nf6EsyAeIc7Q0lovYTwbH6byJzMTI=;
        b=tVAogP9ZDNvlRHAuDjQg3OUMsYcDebcn5Qg7+tJkifpKsiO61p1z/fWeVnx+XVAd2h
         c3e18BtAPkSvWS0Q6EkOtweSNysznnaLXfUhEYJPenO5KzA/m1txalqyKCEDthESiiGO
         RZuTqnp9/SFW6HlOpaLGf0FOjjYzYlvzAlBb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WWM/9SwGrBOCgf2BItkpHYQg9eSUk+SV+7fYu2HRC8GOmfZCN861PHf+TJpgEjtARN
         OTg5I68mH3CT6eXtRgk6NQSRmFmzuKs1w+RDUiyM+n88SGYq9r4s6ISxZBRWykIaZ5VS
         aIIQVrCrbAMSM8LxR8AG8M++uxzrw4zI+USTM=
Received: by 10.210.86.1 with SMTP id j1mr1396413ebb.61.1247940617247; Sat, 18 
	Jul 2009 11:10:17 -0700 (PDT)
In-Reply-To: <CFF1FF99-9237-4C89-BB2D-66F82CF683B1@gmail.com>
X-Google-Sender-Auth: 120c71d58c47ee24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123529>

On Sat, Jul 18, 2009 at 10:58 AM, Robert Zeh wrote:
> What are the index files under .git/svn used for? =A0Am I doing anyth=
ing
> wrong? =A0Can the index files under .git/svn be safely removed? =A0My=
 brief look
> at git-svn.perl makes me think that they are temporary, but I'm not s=
ure.

The index files are used to keep track of the commits that came from
svn, so that git-svn rebase knows where to start from (either when
committing or when doing a fetch from svn).

Unless you used the --no-metadata switch, the files under .git/svn can
be safely removed (at the cost of performance when operating a branch
that has had its index removed).

Peter Harris
