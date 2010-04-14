From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH] make description of "core.autocrlf" less ambiguous
Date: Wed, 14 Apr 2010 15:49:34 +0100
Message-ID: <m2p5b9751661004140749kf97d84f8ufee365390e1c57f5@mail.gmail.com>
References: <1271201003-3413-1-git-send-email-wmpalmer@gmail.com> 
	<7vk4saqguf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 16:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O23vI-0002po-R0
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 16:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0DNOt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 10:49:57 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:22542 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0DNOtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 10:49:55 -0400
Received: by ey-out-2122.google.com with SMTP id d26so51105eyd.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=23OcVGvr7KBRSDwb55D9ESLH3EJ/rOMY73+4ENBv0UI=;
        b=aJAjnEdnA1D7nHxGepv1ergu1LgWP+9fYY3ccKjMAqTDKNNxMuwPb3ZnaX+EozyKGj
         c8Jty1gMxoBlLspDSgnoMZ0uCODZPljclqtst1sslwVvA/sW2mSIj6QOYaznDtsMJ0Qw
         uv7uwCARaZpoKiyQjI9j/1knrKSlI2lHgVN6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tH96or5e5l+/S/nVlxJBD/R+Gft3Pqt7mhBXPWXuWG8xbqaewFPKNhWBNV4qEoHzk3
         DVze506pWzuWf9ImEfYeJ5hgvQvQKSfPM2fU6sq+NlLCNnIN8LcqoBzoNb3v9x99aclK
         LIWcxZaUFhslxRrLPy+Ihk3zOYQy/HaUyBjYM=
Received: by 10.103.108.16 with HTTP; Wed, 14 Apr 2010 07:49:34 -0700 (PDT)
In-Reply-To: <7vk4saqguf.fsf@alter.siamese.dyndns.org>
Received: by 10.103.37.12 with SMTP id p12mr4229005muj.94.1271256594175; Wed, 
	14 Apr 2010 07:49:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144880>

On Wed, Apr 14, 2010 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Very low level plumbing commands deliberately omit the conversion in order
> to show the raw data (e.g. cat-file), so it is not correct to reword it to
> "when output" as in your version.

Blame poor testing on my part, then. Yesterday, my tests showed
"cat-file blob HEAD:a-crlf-file" outputting crlf lines, but
today (with a script, rather than my typing commands in by-hand) that
seems not to be the case.

I agree that verbose-and-anal is not the right way to go, but I still
think the phrases reading from / writing to "the filesystem"
sound very ambiguous, especially when related to a command which
effects the way git stores things in its internal filesystem.

Most other uses of the term "filesystem" in the manpage use wording
such as: "...filesystems like NFS..",
 "..filesystems like FAT..", "traditional UNIX filesystems", etc. The
only non-explicit uses of the term talk about
"slow filesystems", which are clearly talking about something other
than git. The autocrlf mention is the only use of the
term "the filesystem".

Though at the time I thought I wasn't being anal enough, perhaps the
correct move would be to go the opposite direction:
technically not the-real-truth, but "good enough": maybe both
references to "the filesystem" should just be replaced with
"the work tree", which is the term used in the safecrlf section anyway?
