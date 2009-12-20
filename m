From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] rebase -i: abort cleanly if the editor fails to launch
Date: Sun, 20 Dec 2009 08:31:20 +0100
Message-ID: <6672d0160912192331i7aa770d4ta38207d756d204ff@mail.gmail.com>
References: <4B2CC133.9010704@gmail.com>
	 <7v8wcy7kyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 09:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMGoG-0006cm-Vs
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 09:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbZLTHbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 02:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbZLTHbW
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 02:31:22 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44368 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZLTHbW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 02:31:22 -0500
Received: by bwz27 with SMTP id 27so2924373bwz.21
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 23:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NONTD9Y28ZYRM14pbe5UpS/SVpZif96etTSS7SWmK/E=;
        b=mZouzIVI7zPYaLFwb+h51S9P7BnHKqKQFgjKhOA8nUF8Hbd6tBbZsS5tT+Cb3vUu8l
         6p7CmqYARwSO4hfB5kKCnaTWiYfM185nsIXJF4T7/aJ2d+Zg5VF3tTMhfMIcy+UU7O2t
         Jx6FHsJfAimrpAlZ8+Sad81Mm2G+kJivqLoeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sTa2kSUwgLFPldt3Z9nS/inIQsyXjWSnVFahB/syYC6/mVAHBKxNYWjX6bTsT5LC7m
         5iAcvzuzCgIDNJa8fnsokU8yorJZhUHyZHkRnK6qqAGoFjTPJrqw2VNDujkEidSs0b0I
         TpApsIecvy1J3aqsc1NZm5rq9n2q1ILunZvrU=
Received: by 10.204.157.24 with SMTP id z24mr3312437bkw.208.1261294280458; 
	Sat, 19 Dec 2009 23:31:20 -0800 (PST)
In-Reply-To: <7v8wcy7kyc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135523>

2009/12/19 Junio C Hamano <gitster@pobox.com>:

> Two questions:
>
> =C2=A0- Is emacsclient the _only_ editor that can exit with non-zero =
status to
> =C2=A0 signal an error condition "the user invoked me to edit an exis=
ting
> =C2=A0 file, but I ended up not letting the user edit it"?

I have no idea, but my guess is that it would only happen in
exceptional circumstances (e.g. a file system that has run out
of space).

> =C2=A0- Are there editors that let you exit with non-zero status on d=
emand?
>
> The above is not a complaint to your log message, but is a genuine re=
quest
> for information.
>
> An editor that can exit with non-zero status on demand could use this
> codepath to abort the rebase, when a user realizes that the edit s/he=
 has
> done so far was completely bogus [*1*]. =C2=A0In such a case, the exi=
sting
> error message "Could not execute editor" may sound funny.

Again, no idea, but I have never heard of such a feature. I think
that anyone advanced enough to use such a feature in an editor
would not be troubled by "Could not execute editor".


I mentioned emacsclient because it is a real annoyance
that has bitten me more than once (usually because I have
closed my local emacs while working on a remote computer
because I prefer to only keep windows that I am actively
working with), but my patch will help if the user has configured
a non-existent editor too (but such a problem usually
only happens once).

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
