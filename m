From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: GIT and SSH
Date: Wed, 28 Dec 2011 11:55:24 +0200
Message-ID: <CA++fsGFOC6bV4gC+ozBKP3EmoAX4CcfTrHjjpMWPkh7vYOfgAw@mail.gmail.com>
References: <loom.20111228T091942-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Reza Mostafid <m.r.mostafid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 10:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfqEN-0006BT-0T
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 10:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1L1Jz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 04:55:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38357 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab1L1JzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 04:55:25 -0500
Received: by iaeh11 with SMTP id h11so21800384iae.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 01:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RN4LQqAANFHWsy0WiaZ6Wys2k7w3bjzSMVM1XfYNVVQ=;
        b=vez1tbUEv/Dg0QEDi13hgVgeQ07WOypeigRBcPUPNfsuI0xF3hqQdAxop7aIuT+F12
         PiBAuZvWbDpUqZQ/YqVsE722NueugT8xgR1rvHLWOnzYYZ7sI8UKQRXgJs2CBq7WIg2R
         V4lmfb/Mfox6kapM8lEOVFwBihIQTjBt3P9qM=
Received: by 10.50.207.72 with SMTP id lu8mr35420228igc.0.1325066124773; Wed,
 28 Dec 2011 01:55:24 -0800 (PST)
Received: by 10.231.149.194 with HTTP; Wed, 28 Dec 2011 01:55:24 -0800 (PST)
In-Reply-To: <loom.20111228T091942-66@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187746>

Git supports multiple transport protocols. Among them are git, ssh,
and https. (You can also use direct file system access, but it is
questionable whether to call that a protocol). Each of the protocols
have their advantages and drawbacks. The git protocol is only used for
reading, and not for writing, but is supposed to be very fast. The
common firewall filtering of the git protocol port 9418 is another
problem. ssh is the prefered protocol for writing to a remote
protocol. But if ssh is filtered, then http/https may be used, which
is very slow for large repositories, but it has the advantage that it
is the least blocked protocol.

=46or more info see:

    http://progit.org/book/ch4-1.html

Regards,
Dov


On Wed, Dec 28, 2011 at 10:43, Reza Mostafid <m.r.mostafid@gmail.com> w=
rote:
> I am starting to use GIT and I would be grateful for a simple answer =
to a
> specific situation to help me find the right ball-park.
>
>
> a.) Does the communication that takes place between a GIT `client` an=
d a remote
> =C2=A0 =C2=A0GIT `repository` involve 'ssh' traffic?
>
>
> Our connections here are heavily censored and ssh traffic is suppress=
ed most of
> the time which is why I need to figure out why a simple
>
> =C2=A0 =C2=A0$ git clone git://<URL>
>
> command chokes to a halt and freezes most of the time ( the same comm=
and when
> executed remotely on our V.P.S. in Europe works flawlessly ).
>
>
> b.) Are there means to make the `git` client on my machine circumvent=
 this?
>
>
> Y/N answers or brief hints to my questions suffice, I'll work out the=
 rest.
>
> Basically I would like to know whether there is a point at all trying=
 to make
> git work from where I am, given the limitations mentioned.
>
> Regards
>
> Reza
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
