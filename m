From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Wed, 26 Aug 2009 15:24:25 +0200
Message-ID: <81b0412b0908260624v30d32cc1m96e798076b51cbc9@mail.gmail.com>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
	 <200908261231.01616.johan@herland.net>
	 <81b0412b0908260505m233d9a5cmefdd81e1ef51a299@mail.gmail.com>
	 <200908261456.55906.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 15:24:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgIUL-0005IX-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 15:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbZHZNYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 09:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbZHZNYY
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 09:24:24 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64671 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485AbZHZNYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 09:24:24 -0400
Received: by fxm17 with SMTP id 17so116767fxm.37
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S1ine3EOzNmAIQ5rttLrlJmY/bP+bt2/d/JMuGtY5fQ=;
        b=elpb/FCBDkRpW/X7UtqOH+zyBG9Wt0fHzVdbzd4g7gaO4thh7j5ELqSCzOFytYGOYW
         pfh6Qs03IhtbcvPkECY5cqxu9giWW1Zo4V4YcobQzBoCdqgWuijaJgDkypn2Mnnh8RxG
         26VJ+NCblCdyblGrRrV4hbYdxRCxM3Vuz/vI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZuorrOMSB9fJJpleHY6Yyw2RQU7rw5aA1/B+54rXYa3NKZU2McYr5dyBlHNDqsdW5w
         B0qHACv9aiuaeTReXXTUsyNHgFSEYiJHbDqPX+bgzE0WG6tmnoBl6R0Ky4R3Un7mfeTR
         kB7qlCVIO0HqEzJmOANrAeGO0PyPqJMpYD0vY=
Received: by 10.204.25.152 with SMTP id z24mr3670537bkb.44.1251293065157; Wed, 
	26 Aug 2009 06:24:25 -0700 (PDT)
In-Reply-To: <200908261456.55906.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127095>

On Wed, Aug 26, 2009 at 14:56, Johan Herland<johan@herland.net> wrote:
> On Wednesday 26 August 2009, Alex Riesen wrote:
>> On Wed, Aug 26, 2009 at 12:31, Johan Herland<johan@herland.net> wrote:
>> > The 256-tree structure is considerably faster than storing all
>> > entries in a
>>
>> This part is confusing. Was 256-tree better (as in "faster") then?
>
> 256-tree is faster than the everything-in-hash_map draft.
> 16-tree is slightly faster than 256-tree
>
> 256-tree uses more memory (in the worst case) that the
> everything-in-hash-map draft.
> 16-tree uses less memory than both.
>
> Makes sense?

Oh, it does, it is just confusingly presented. How about:

The 16-tree is both faster and has lower footprint then 256-tree
code, which in its turn is noticably faster and smaller then existing
hash_map implementation. ...
