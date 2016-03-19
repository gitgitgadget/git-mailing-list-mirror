From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: GSoC Project | Improvise git bisect
Date: Sat, 19 Mar 2016 15:03:19 +0530
Message-ID: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, troy.moure@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, me@ikke.info,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 10:33:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahDGb-00076x-Vr
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 10:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbcCSJdW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 05:33:22 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36771 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcCSJdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 05:33:20 -0400
Received: by mail-yw0-f177.google.com with SMTP id g3so166544739ywa.3
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=TC+PqAP9S0D45VBNJuynW3HXthkQfJhS8LHmFVeV7Hk=;
        b=NIrC2bPgzG/aDgB1fPMwvfqwHJQQWB4AlWqz1oABsYPZmDgWAGgvIHUf/9TPkmpf1P
         vr3kr9DMLbCkzcVmlscCJgQNF7WVQbV+vE2owEbsiwz/m6aMsEvXQFjPK7f3hKe45WGY
         t2FANttt29LyUVy6Ptxx5zOUz4uBSQ1lK6ffuiJX5c9WoEGUN/DZS+II/XtcPUBUELJu
         vLkRwo0X/fuE98Ft9IaZgPHZfNVw5JF4VtTv2WnemrVvSnlESVxpcQfwW3tFFEOSNOIv
         Mv+TIQTlxsKalcBxEr8DMqdkPCU8hRgajAP+CENWO2qR1iG/Yeunt79lHaINguegEC5T
         +H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=TC+PqAP9S0D45VBNJuynW3HXthkQfJhS8LHmFVeV7Hk=;
        b=Ad8lZsUy4rLWUOl9mwLGhd5iz9mv9KWSvquVKpNVbUm7K/HmBxvKkLA8NC0OJRbeZL
         qJpZGFVpP+K/LYi0druAx8GoSccJpz/d0rA+JFC0WdD6Y4/v5GhH0Gi9VTh/L3B5qRT4
         nP4lR1UULFMBxVz33Ou9NGh3dXqJO/Y+gwzLkO5dcG8P457zPpbWSMmh0n3/32B2WIEW
         L1HwytMLwqddhSX7wXMnEOpiP3KQKAvEPOaHiOY1NgTa8nU2+Uc8U7TDc+O4b4WQjgXW
         loeFzhdc6EeJJ46V62ZWJsuETUtodsgQLaZ1TLjU0b+cdLCM2q2c+OntazeDtQbWcYuk
         Ne+Q==
X-Gm-Message-State: AD7BkJKhEQEhfTGGKyQHDoc9MO4PiLEmdCwTWZWldDt8t/5d+PQfXGaq8CnEXFoomafPzmiuaIj9MKG6bZON+g==
X-Received: by 10.37.12.195 with SMTP id 186mr9338197ybm.154.1458379999163;
 Sat, 19 Mar 2016 02:33:19 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sat, 19 Mar 2016 02:33:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289299>

Hey everyone!

I am Pranit Bauva. I am studying Mining Engineering at IIT Kharagpur.
I am interested in participating in Google Summer of Code under Git
organization. I have attempted a micro-project to add configuration to
commonly used command line options `git commit -v` ($gmane/288820).

I am interested in 2 project related to git bisect confused between the=
 two:

 - Implement git bisect --first-parent

> When your project is strictly =E2=80=9Cnew features are merged into t=
runk, never the other
> way around=E2=80=9D, it is handy to be able to first find a merge on =
the trunk that merged a
> topic to point fingers at when a bug appears, instead of having to dr=
ill down to the
> individual commit on the faulty side branch.
> Cf. http://thread.gmane.org/gmane.comp.version-control.git/264661/foc=
us=3D264720

What I understood is that let's say the repository is like :

         C13
           |
         C12
           |
         C11 (merge commit)
       /   |
     |   C10
     |     |
     |   C9
     |     |
     |   C6 (merge commit)
   C8    |   \
     |   C3    |
   C7    |     |
       \   |     C5
         C2    |
           |     C4
           |    /
          C1
 (master branch)

The commits numbers ie. C1...C13 are according to the time stamp, C1
being the first. On starting to debug with git bisect, given that C12
is bad and C1 is good, it starts a binary search from C1...C13. ie. It
first goes to C7, if its all good, it goes to C10 and so on an so
forth. If C7 is not good, it goes to C4 and so on and so forth. This
just makes the job of debugging a bit difficult for a repo which has
only 1 mainstream repository and it just has some short-term branches
to instantly get stuff done. It can be simplified by using
--first-parent. Given C1 is good and C12 is bad, it will find the mean
between {C1, C2, C3, C6, C9, C10, C11, C12, C13} which is C9, see if
its good. If not then it will go to C3 and then C2, if good then it
will go to C6, if not good then it will go to C5 and then C4. This
will greatly simplify the job of debugging.

 - Rewrite git-bisect.sh as bisect.c and bisect.h

 For this I plan to go along the guidelines of Paul Tan's previous
year work. I have followed his work and his way seems nice to go about
with rewriting.

What are your suggestions about these project? Which one would you
recommend me to do? I have tried to cc everyone who participated in
the discussion for -first-parent

Regards,
Pranit Bauva
