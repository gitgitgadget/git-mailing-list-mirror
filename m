From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: git --version wrong
Date: Mon, 14 Dec 2009 19:41:51 +0100
Message-ID: <28c656e20912141041v3dbbbe3dh6a87f59aa2e789b9@mail.gmail.com>
References: <26770625.post@talk.nabble.com>
	 <28c656e20912132217u4e1aeb27y9b957c8e75210e9e@mail.gmail.com>
	 <4b308ad10912140852k15b5b815ge77c54525634d454@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Brad Hutchins <oshybrid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKFrq-0001XN-Bl
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 19:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbZLNSlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 13:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756138AbZLNSlx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 13:41:53 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34926 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876AbZLNSlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 13:41:52 -0500
Received: by ewy19 with SMTP id 19so3701885ewy.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 10:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bFwYfqUbYEC0eJKyz3etKp/pB+BxV0o4hmwXONK8ZIc=;
        b=akSMH4Fi/75AhoIUOqnJ5aeIULh93NtvXY9Qq21NkZsBbLFN2fL1lGri7H3fBXXGgb
         RxvjwvgvVrDzLFEmbJ+MYAndVLHnarsQXRJVtAcFvsw8d/y8NJrKIlU/2MlK3I8j/nP8
         kPlW4IsSpbCg8OPlddoYfg6o9xhky+PSv6QsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rcf7ERmaXEuq0EyzT3dxVqrCCvND+nUYXao0neoalcgI91bxtmu2PVL0hGo2vktmva
         Xrn9+xVccxqR/PNU7K2/aK+lpbFjdYMQk+WbyDkPPjoL4l3wVaSekzcO029JlEwB0Su8
         9ClzzmBCXQJ4ajimucWU+vetxaBJU3Tq3MSUo=
Received: by 10.213.24.2 with SMTP id t2mr3919250ebb.6.1260816111163; Mon, 14 
	Dec 2009 10:41:51 -0800 (PST)
In-Reply-To: <4b308ad10912140852k15b5b815ge77c54525634d454@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135230>

> On Sun, Dec 13, 2009 at 10:17 PM, B Smith-Mannschott <bsmith.occs@gma=
il.com>
> wrote:
>>
>> On Sun, Dec 13, 2009 at 23:51, oshybrid <oshybrid@gmail.com> wrote:
>> >
>> > After i Instal 1.6.5.5 my "git --version" =C2=A0still shows 1.6.0.=
5
>> >
>>
>> How, exactly, did you install it?
>> What's the output when you type "which git" at the command line?
>>
>> // Ben

On Mon, Dec 14, 2009 at 17:52, Brad Hutchins <oshybrid@gmail.com> wrote=
:
> /opt/local/bin/git

Judging by the path, it looks like the git that is actually running on
your machine was installed through macports. Is that accurate? The
current version of git offered by macports, however, is 1.6.5.3
<http://trac.macports.org/browser/trunk/dports/devel/git-core/Portfile>
which is neither the version you are expecting, nor the version you
actually have installed.

Here's my guess, based on insufficient information:

(1) You have macports package manager installed.

(2) It's been a while since you've updated it, so...

(3) The git installed by macports is outdated (1.6.0.5)

(4) You tried to install git 1.6.5.5 via some other mechanism other
than macports.  Maybe one of the stand-alone git installers floating
around. Maybe you built it from source. I can't tell, because you
haven't told me.

(5) Where ever that install placed your new git, it wasn't in /opt/loca=
l/bin

(6) Your PATH environment variable either does not contain the
directory where the newer git is installed or it contains it, but said
directory is after /opt/local/bin in PATH.
(type "echo $PATH" in the shell to see what's in PATH).

I'd look in /usr/local/bin and /usr/local/git/bin to see if you can't
find the newer git there.

=46ailing that, please come back with an answer to the question "How,
exactly, did you install it?" from my first reply and I'll see if I
can help you further.

// Ben
