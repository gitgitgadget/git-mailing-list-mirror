From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 14:17:16 -0700
Message-ID: <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	 <20070927185707.GC12427@artemis.corp>
	 <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	 <7vhclfubh5.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	 <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	 <7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
	 <7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib0jf-0008Q7-G8
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 23:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbXI0VRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755957AbXI0VRS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 17:17:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:21689 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbXI0VRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 17:17:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3310590wah
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=B9myCn/gZYWd1WMWvml9U7tAajbsfnHRCzAgSSTVvLI=;
        b=GHvi06C7XggSbRCThE/8zkZnsgpKv1LMKTEuja3BoShAxsoe/DHvbwksR+Rwttvhzh6gIWBzjteRyWdId/CYyGjhjh/1bRcgtojl0KXMyF9kUWcHXt5IpBH/6pdgo/W/k9e1j3lBcQ6SkJrCcvSk+NgZwL+Fyoz2R503MJHIX4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=mOL9hbe/iAa+cVJXuz+3ONL01DcxNXRj/60ckfZRUpvSPTq3Fcu4hcAg5a2q6RffFkkp1161uDEoky8Xit8TTCk/MMz7az/7Pd7cunyGrnf4Akm7wgZm3G7uk82eASqRt6JnuvEoTCPEge2lIa73BLyAJxC42Angm/wm3Kv0bkY=
Received: by 10.114.154.1 with SMTP id b1mr1547948wae.1190927836681;
        Thu, 27 Sep 2007 14:17:16 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 14:17:16 -0700 (PDT)
In-Reply-To: <7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 05ce601acd83855e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59335>

On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Kelvie Wong" <kelvie@ieee.org> writes:
> >
> >> Egads, it's alive!
> >>
> >> I was in a subdirectory (most of my work is in that one subdirectory
> >> anyways :p), but running it on the top level did indeed work as
> >> expected.
> >>
> >> Thanks,
> >
> > Thanks for spotting a bug.  It claims to be subdirectory safe at
> > the top of the script but apparently it isn't.
> >
> > And I do not see a reason why it cannot be made subdirectory
> > safe.
>
> It _could_ be just the matter of doing this, although I cannot
> test it right now (at work and have no access to any of the
> backends).  Care to try it from a subdirectory and report
> failure or success?
>
> ---
>
>  git-mergetool.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index a0e44f7..018db58 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -12,6 +12,7 @@ USAGE='[--tool=tool] [file to merge] ...'
>  SUBDIRECTORY_OK=Yes
>  . git-sh-setup
>  require_work_tree
> +cd_to_toplevel
>
>  # Returns true if the mode reflects a symlink
>  is_symlink () {
>

At least with emerge, this isn't so simple -- emacs tries to save it
as ${absolute_PWD}/${PWD_relative_to_toplevel}/$filename
(which of course doesn't exist yet).

In meld it works fine, however; haven't tried the other ones.
-- 
Kelvie
