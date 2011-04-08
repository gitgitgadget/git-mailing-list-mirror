From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Sat, 9 Apr 2011 00:02:09 +0700
Message-ID: <BANLkTimTm3L62J-bErmxYNE0=CRChvaKQQ@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com> <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
 <7vd3kyf327.fsf@alter.siamese.dyndns.org> <BANLkTi=YK-4TOxoD1qR8TO4SymLK6sPnQA@mail.gmail.com>
 <7vtye84wc3.fsf@alter.siamese.dyndns.org> <7vpqow4s3f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 19:02:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8F54-0003cd-Io
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 19:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab1DHRCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 13:02:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37764 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab1DHRCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 13:02:40 -0400
Received: by bwz15 with SMTP id 15so2992708bwz.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=MDhDajYIDj1+QmD+XPbuV26Qnt3QDPmKu+QrkX0WiVA=;
        b=QyZh2aO3/9ZDTl+uoBK+1e3Qu2LZ+sC4apC1xPALOI05MUSg1Ap9Y99e0CVi6uBqBR
         4agF4OcXs4S6pW6j5F7IjqLqJLfQIB6jnCQD94Y/Oxg4YhItQpStSPNPoptavKj8KF5K
         es94A/2e71LWZub5hRwyZ33ywhc1nM9nLDLQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AY8qCeo1er4mLNPQ6cbIFU9nO1a77pAYccg/csJ7IYNY7BikiBuuwvrFRpLTi5ZzsL
         9VHZlZht/j4lfRnKtM0RvHTIJvNZRM5c5GepEtcSj1SF7lGdGFNCVWE/+KBoQJAu5yVv
         E2PEA5umNooSYnTu/Dzb09XcB7Qg16QBzqmQg=
Received: by 10.204.141.12 with SMTP id k12mr2199127bku.44.1302282159101; Fri,
 08 Apr 2011 10:02:39 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Fri, 8 Apr 2011 10:02:09 -0700 (PDT)
In-Reply-To: <7vpqow4s3f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171136>

On Fri, Apr 8, 2011 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Off the top of my head, we should exclude "." (period -- dot-files are
> common), "_" (underscore), and possibly "+" (plus) and "=" (equal), as I
> saw these used to start filenames, but the latter two are rather rare and
> I don't mind requiring the terminating colon after the magic signature.

Totally agree on dot and underscore. I don't really care the other
two. While '*' is not actually part of path name, '*.[ch]' is commonly
used, and I usually have to quote once to avoid bash expansion
already. So put asterisk in exclude list too, to avoid another quote?
-- 
Duy
