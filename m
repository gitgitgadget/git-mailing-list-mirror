From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 3/3] git-submodule: add "sync" command
Date: Sun, 24 Aug 2008 12:23:44 -0700
Message-ID: <20080824192343.GA22134@gmail.com>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com> <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com> <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com> <23327a679798d19dc52a27c55a58c5b8c9ebe945.1219598198.git.davvid@gmail.com> <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mlevedahl@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:32:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXLKS-0004Do-46
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYHXTbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 15:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYHXTbo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 15:31:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:34526 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbYHXTbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 15:31:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1324096rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HEzvtz4dSA0QIh/Gt4ccjXyLtuThnFcIgoKnZJd2sC0=;
        b=j/LMBI56ocpdrrbwFHDxzKG/DSc024D7GXR9wYdFQ8mG17BYid+8YOZK8lBWwm4gyt
         8QP16R95+Ee0dCT8Y9/djmyrXmEdL+RgM6fT86onD6xO41xk0S6HqOwfuc5K/imu5w3p
         G2x3bBru486RRPChTHnOTUR61FSzVNDnsJM7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ydn2vQTG6nBPHMQmdptOCwTdWT2NJ/QtlUVxVd4vRA9eIx5nYqvN5pEXfokOIMwZm+
         BGU/3jT5BCtctXu2IgsZeFfFo8dUTX1roHyxqOnlnb5XDLf77JO+/eA+di5Ze+6aiX5K
         /kROLnG5w6nsoaz3zeWTNkTUw6P2l9hO/2ZXA=
Received: by 10.140.132.8 with SMTP id f8mr1721682rvd.206.1219606301773;
        Sun, 24 Aug 2008 12:31:41 -0700 (PDT)
Received: from gmail.com ( [208.106.56.2])
        by mx.google.com with ESMTPS id k2sm6013868rvb.1.2008.08.24.12.31.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 12:31:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93554>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
> > +		(
> > +			unset GIT_DIR
> > +			cd "$path"
> > +			remote=$(get_remote)
> > +			say "Synchronizing submodule url for '$name'"
> > +			git config remote."$remote".url "$url"
> 
> I am not sure about the way you determine $remote.  When the HEAD in the
> submodule repository is detached by prior "git submodule update", this
> will fall back to the default "origin" --- is it a good behaviour?
> 
> This is not an objection; I am merely wondering if that fallback is
> sensible, or if people who are interested in submodules can suggest better
> alternatives.


This is true.  I recall there was a lengthy thread a while
back about how "origin" might not always be what you'd want
when cloning a repo.  I'll address your comments, use
Mark's get_default_remote, and resend.  I have a feeling that
addressing the use of remote names in submodules is beyond
the scope of this patch for now since it seems like we'd need
that info stored somewhere in a superproject gitfile.

-- 

	David
