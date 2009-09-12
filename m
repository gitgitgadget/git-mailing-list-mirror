From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Confusing git pull error message
Date: Sat, 12 Sep 2009 23:37:47 +0200
Message-ID: <fabb9a1e0909121437q4eb432e3idde98993ac552b5@mail.gmail.com>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com> 
	<20090912211119.GA30966@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 23:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmaJn-0007xf-C1
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 23:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbZILViG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbZILViG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 17:38:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:4635 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZILViE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 17:38:04 -0400
Received: by ey-out-2122.google.com with SMTP id 25so407197eya.19
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YK1GJdsUNChFAffNnYLhYj8HdZbctcPuHTEazbwHKms=;
        b=V46zIG5SGunE6kIj6VSFrJDA+UH90+BDxBCrcAlet9AVJi8gK9vLomqZgLAlN3sR9n
         +CS4cxkYquORIMBhIXYKIZxlmQZT1tvwbrKj5HVsevukoPMygZDlMpX7fSUL0dLjzrxB
         fg3IvEPC2DMY7ZaCvhM2m1ySFzV5LrIsDb4cI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AdxHVCTK5nVOAhzCaNQezUYOqhX0qEMJHn9YaosYolYjzIMUMBpEMftKr0NOdjBBJF
         /0X+EawUfqxiBxMmXb+49OtZwK0hJHdwBHOGQUw2nou1AFBHjnOUfSuIW8vco1C3RdO3
         coVJg+Dw/L3WBxAjXtlfQwQYotwmtC+7ZbWwQ=
Received: by 10.216.22.66 with SMTP id s44mr470388wes.87.1252791487190; Sat, 
	12 Sep 2009 14:38:07 -0700 (PDT)
In-Reply-To: <20090912211119.GA30966@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128300>

Heya,

On Sat, Sep 12, 2009 at 23:11, Jeff King <peff@peff.net> wrote:
> =A0 =A0 =A0 =A0if [ -z "$curr_branch" ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "You are not currently on a branc=
h, so I cannot use any"
> @@ -96,7 +99,7 @@ error_on_no_merge_candidates () {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "Please specify which branch you =
want to merge on the command"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "line and try again (e.g. 'git pu=
ll <repository> <refspec>')."
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "See git-pull(1) for details."
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 elif [ -z "$upstream" ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "You asked me to pull without tel=
ling me which branch you"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "want to merge with, and 'branch.=
${curr_branch}.merge' in"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "your configuration file does not=
 tell me either. =A0Please"
> @@ -114,6 +117,10 @@ error_on_no_merge_candidates () {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo " =A0 =A0remote.<nickname>.fetch =
=3D <refspec>"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "See git-config(1) for details."
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "Your configuration specified for =
us to pull the ref"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "'$upstream_short', but we were un=
able to fetch it from"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "the remote."
> =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0exit 1
> =A0}

Pretty bad case of multiple personality disorder here? At first
there's a "me", then again a "me", and then all of a sudden a "we"?

--=20
Cheers,

Sverre Rabbelier
