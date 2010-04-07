From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: ghost refs
Date: Wed, 7 Apr 2010 12:58:33 -0400
Message-ID: <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:59:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYai-0003v9-3K
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758069Ab0DGQ6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 12:58:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53513 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756955Ab0DGQ6y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 12:58:54 -0400
Received: by gyg13 with SMTP id 13so645030gyg.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Cmjz3SsjVruSX8b7OEJdWfmZ5Rhr/wAt2Xj0Lv2DRmc=;
        b=NYOXGFVzRfpJMoBeNjclVWpZCvPQ1xYaPdreHS8BQfHYy9YrA4ZoIkOmPTpBcjtI/P
         yhYdvbMZEG2a1UT5mpOb3jIc26OIKELs97SbTflYnFgtEJ3CoQilFw6h7CjL7XQwp6gr
         Tp7ZtD/p6nqqL7QuI95rDJj6h8qWU/FRHP1cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G5au/Ho8oujW7f/a6JE4nbTk7GSm7M8BMWWxVYhQglfoNl7NilC2OiJH+jVw9hCuwG
         e9wXiz0Ld1vQuuMpaIMBKNwftLwjfMjm1Nj7T0LV/n8hMpI0X5yPPQVI1cCBnkC9ctci
         YQ3D52bhUGVu/sUaD5iKS6Iyuv50X3DFS/SNY=
Received: by 10.150.150.20 with HTTP; Wed, 7 Apr 2010 09:58:33 -0700 (PDT)
In-Reply-To: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
Received: by 10.150.254.7 with SMTP id b7mr9818723ybi.293.1270659533128; Wed, 
	07 Apr 2010 09:58:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144251>

On Wed, Apr 7, 2010 at 12:38 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
> A couple times I've seen people who have some reference
> remotes/origin/foo after foo has been removed from origin.
> What is the proper way to address that, other than removing
> the file directly? =A0It appears to not go away with a "fetch" even
> though it was deleted from the origin. =A0So what is the proper way
> to delete something on the origin so the deletion propagates?
> I normally use "git push origin :foo".

This is on purpose, based on the theory that you don't want to lose
data from your local repo just because someone (accidentally?) deletes
a branch on the remote server.  Unfortunately, this theory is a bit
flawed, since someone could just as easily overwrite the remote branch
with a totally different commit, and you'd still lose it in *that*
case.  So mostly it's just confusing.

Anyway, what you want is "git remote prune origin".

Have fun,

Avery
