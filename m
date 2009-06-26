From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 2/8] gitweb: uniform author info for commit and 
	commitdiff
Date: Fri, 26 Jun 2009 19:52:27 +0200
Message-ID: <cb7bb73a0906261052i4315075ag3f8e2ce220b8534e@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906260114.44345.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKFbK-0002Bv-Gx
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 19:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZFZRw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 13:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZFZRw1
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 13:52:27 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36542 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZFZRw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 13:52:27 -0400
Received: by bwz9 with SMTP id 9so2170290bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4CGv/QDANLCWDKgartw7e6e1E3WCyYd//h+GFYn1+P0=;
        b=VwIqCwlj1lVMrAMRZDEMeCqCq1yH2wPFtQdKdBsXCFue2qhIwa5a+MDmLjLiAahl7Q
         dKMzzyrAHOZ7NSPLN1267DHDQLhNGseMoFRJns9LBhCuLXVZoJ6/5IUx1REiVwQHv+NA
         WqWUqRyNT0g9lJELeZ0Y3qwvawNqpEKlnCaU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bk8audcBNNHmqIWJhbmoeHy/m6ESSlmxfTL+3Q49xFQDuE5NwA5f64JFGlFRS4WbXi
         aau27GklzyKi/uWXXO+JFxoJr4IQ6mvSDVzN0dtgch3VL/53820lN9PqpYAIH3HluLE0
         it5y/VLGMqLOF8ZBXFbRgmAMlzh8XLB/dB+io=
Received: by 10.204.62.135 with SMTP id x7mr3930275bkh.95.1246038747849; Fri, 
	26 Jun 2009 10:52:27 -0700 (PDT)
In-Reply-To: <200906260114.44345.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122312>

2009/6/26 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 25 June 2009, Giuseppe Bilotta wrote:
>
> Here I would write that 'commitdiff' view moves from
>
> =A0Giuseppe Bilotta [Mon, 22 Jun 2009 22:49:58 +0000 (00:49 +0200)]
>
> to
>
> =A0author =A0 =A0 =A0Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0Mon, 22 Jun 2009 22:49:58 +0000 (00:49 +02=
00)
> =A0committer =A0 Jakub Narebski <jnareb@gmail.com>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0Tue, 23 Jun 2009 18:02:21 +0000 (20:02 +02=
00)"
>
> (perhaps with A U Thor and C O Mitter as example names).

Done.

> Very good that you put this in separate patch, so it can be evaluated
> independently, and decided independently whether it is worth having m=
ore
> detailed authorship information in 'commitdiff', making it more like
> 'commit' view, or be more like 'log' view with similar, but slightly
> extended authorship information.
>
> I personally am a bit ambivalent about this issue...

I really don't understand why commit and commitdiff are so different,
but this is something we went over already. One thing that should be
kept in mind is that commitdiff can span multiple commits, but in this
case it only display the information about the first one (but this is
not something that is changed by my patch). commitdiff view probably
needs a complete rethinking.

--=20
Giuseppe "Oblomov" Bilotta
