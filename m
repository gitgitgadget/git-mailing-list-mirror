From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Tue, 6 May 2008 12:58:31 +0200
Message-ID: <a537dd660805060358q6e39947blda348917d5853294@mail.gmail.com>
References: <20080416062925.8028e952@zebulon.innova-card.com>
	 <a537dd660805050744h7602e553u21c70168a621fe76@mail.gmail.com>
	 <481F23D4.2090909@viscovery.net>
	 <200805061231.30135.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Bryan Donlan" <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 12:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtKtU-00016W-WC
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 12:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbYEFK6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 06:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYEFK6c
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 06:58:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:33396 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYEFK6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 06:58:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1623070rvb.1
        for <git@vger.kernel.org>; Tue, 06 May 2008 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Qm/b9rU8oYIk948ML1Lrog4c2CJ2v8QchEjbtYapFLc=;
        b=QSDAqbfKCWSiUvYx4WoTkORMbNrqxTlRSG6o/3XZNlJ5Gq0OVqsuL13ecys80W5i+35f3ZEkLvVebipuTZmSoK1yXPSk1MbXQrMeru8/0e5SQ7uL4ZnsnKEObD3U0viGu+uxqsop9iBekeHyxk8W0gjkRDBBr3PGjcS21B3HLfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=E7YU3kV+5Q/hVu7uw3CEMyv6ala3CNdChNxj4SKXZKFgOroxj7riWCNppcHOIcyYyLfkvF/1uilI3OYR6mSUpgfaupx5NbViL6QaLVASaUFKboyoOrq7KXpK3o3+XZIaZNaGnEMFY9XHyG7Dv4tXwxzExZ6SNYLzPvc2TlUHBwo=
Received: by 10.140.127.13 with SMTP id z13mr277760rvc.142.1210071511104;
        Tue, 06 May 2008 03:58:31 -0700 (PDT)
Received: by 10.141.197.19 with HTTP; Tue, 6 May 2008 03:58:31 -0700 (PDT)
In-Reply-To: <200805061231.30135.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: cda98ed20c554969
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81349>

Johannes Sixt wrote:
> Brian Foster schrieb:
> >  What I don't know is the root-cause, that is, WHY
> >  this was done.  [ ... ]  there is some anecdotal
> >  evidence it was some sort of a CPU-cycles issue,
> >  albeit just what the performance hit was is unknown.
>
> How about this theory:
>
> What happens if you fire up gitk as simple as
>
>    $ gitk
>
> in the history if no grafts are present? Some months ago this took ages to
> complete, and even today you get a *huge* list of commits in a *short*
> window; hence, the scrollbar thumb is tiny, and if you succeed to get hold
> of it without a magnifying glass, it scrolls way more than a page of
> commits if you move it by only one pixel.
>
> No wonder that $user wants to have a shorter history. So $user, being
> smart, truncates the history at a suitable point with a graft.

Hannes,

 Unfortunately, I cannot fire up `gitk' in the exact
 same configuration anymore (that server machine is now
 being used for other purposes, albeit I'm supposed to
 get the hard disc).  The git on the now-vanished server
 was v1.5.3, but that's probably not relevant, since the
 repository must have been created with a much older git
 (it goes back multiple years).

 All the (now-)installed gits I've seen are 1.5.<something>.
 I do not see any noticeable performance issue with 1.5.2.5
 (nor with 1.5.5)?  The scrollbar is, as you say, unusable.

 But how important is `gitk'?  Is it something that'd be
 used frequently enough for the formerly-poor performance
 to be such an issue that creating and maintaining such a
 "truncated" repository is worthwhile?

 It's an interesting and plausible hypothesis, but (in
 the absence of any actual evidence) I'd be more inclined
 to buy it if there was some frequent/critical operation
 where poor performance clearly matters.

cheers!
	-blf-
