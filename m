From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 1/5] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sat, 12 Jan 2008 17:09:49 +0800
Message-ID: <46dff0320801120109l5d69fcbancd68bbcec7f2455a@mail.gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <7vmyrbv4ms.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:10:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDcNh-0000jL-FL
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759813AbYALJJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 04:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759732AbYALJJw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:09:52 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:64922 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759171AbYALJJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:09:51 -0500
Received: by py-out-1112.google.com with SMTP id u52so2070320pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=991Fl4iiqJ2RBb/5sIlZCy1iLWNVjCWV+VhJuCUAQE0=;
        b=IE9I29TyEj3wvk+ZcgO6vOHYx9Um70U5JiFjC7dDpgDPq61aFBJxGsJqIqGC3An9Qrcp3w44e7awFF9tSLBABFzFC2+gKdN5AKE6g1ygGGR4zCnUA570Dq4VxwBINQHbB72UHKNChnEh4k/RwDDt16ftftk6dg1YN3PbPxYruXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z1WAj2FmRNM7QkvSTeR+hs3tyKoFCPYBHy05QA2bNpQB7/wGJ5EhMUZ7O2M/S7yIm4vg7Fy4l+4NTIWeSWg+QiSC2RnoiwoVIEloqzY1XXwJmURZ6Kqbd2zHodhv4umDWmb8lDe5j6qzKUTWtyi/CUMUSBXsttxk3QrqYyVCft8=
Received: by 10.35.65.17 with SMTP id s17mr4798543pyk.19.1200128989944;
        Sat, 12 Jan 2008 01:09:49 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 01:09:49 -0800 (PST)
In-Reply-To: <7vmyrbv4ms.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70301>

On Jan 12, 2008 4:18 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> Ping Yin <pkufranky@gmail.com> writes:
>
> > +     # get modified modules which have been checked out (i.e. cared by user)
> > +     modules=$(git diff $cache_option --raw $head -- "$@" |
> > +             grep '^:160000\|:000000 160000' |
> > +             while read mod_src mod_dst sha1_src sha1_dst status name
> > +             do
>
> You are listing paths that were already submodule in HEAD, or
> newly added submodule.  What about a path that used to be a blob
> but is being made into submodule with the next commit (i.e. RHS
> is 160000 but LHS is not 000000)?

Hmm, i had ignored such a case.
>
>
>
> > -case "$add,$init,$update,$status,$cached" in
> > -1,,,,)
> > +case "$add,$init,$update,$summary,$status,$cached" in
> > +1,,,,,)
> >       module_add "$@"
> >       ;;
>
> This is simply unsustainable.
>
> Please see the other thread with Imran M Yousuf regarding the
> command dispatcher.  I think that should be the first thing to
> fix before doing any change.
>
Ok, i will resend my patches after this fix


-- 
Ping Yin
