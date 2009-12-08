From: Russ Dill <russ.dill@gmail.com>
Subject: Generic filters for git archive?
Date: Mon, 7 Dec 2009 18:06:04 -0700
Message-ID: <f9d2a5e10912071706m10ed7112ob7db47cdfac510d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 02:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHoWp-00067p-TR
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 02:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbZLHBF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbZLHBF7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 20:05:59 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:62801 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965207AbZLHBF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 20:05:58 -0500
Received: by pzk1 with SMTP id 1so1764345pzk.33
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 17:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=hrAk7LtL7r2EIVNJ9r09sqKtZSUU8rNO4UBu1+QJnWw=;
        b=M2KQ0Id7wrkmubtFALP2OfEqxyJ66kF7sMhGnwfkMSdxvIsc/UMVSLnCcdWqhq8eH0
         mr/fjIsd+9pwFgFxnHLqgTC868hpls7lCERt8XXB+oY0bETHkObfwru3ifdmILefHc/H
         /49yHsUI1jTDGbxtPg9OG7af6xD6geUfdhxuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bcoVIFdcUVsUEZdd+P1c4Te73Z6V3XmeNoeDvYb4QSBcSpAkurI+0Il9JkvRzzoi4U
         hVlskzFBblgwvZvAAyo1+XbAVjCUQXIvmJKHMmytZtzjvjnR2HVM6AS/474VKdD8pWze
         4PAR1zQw00/bCxD+LGebPb3aAwGZC0AGtA25g=
Received: by 10.143.21.34 with SMTP id y34mr857701wfi.16.1260234364560; Mon, 
	07 Dec 2009 17:06:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134797>

I'm trying to add copyright headers to my source files as they are
exported via git archive. eg:

* $Copyright$

to

 * Copyright (c) 2003-2009 by Foo Bar
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

And properly handling things like '# $Copyright$', '// $Copyright$',
etc. I have a sed script that does this, but no way to apply it to the
output of git archive. I tried setting up a smudge filter that would
only smudge output on archive exports, but it doesn't appear that the
smudge filters get run on git archive.

I am currently running 1.6.3.3
