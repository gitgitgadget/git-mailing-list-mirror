From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: git clone --update ?
Date: Sat, 8 Jan 2011 10:41:11 +1100
Message-ID: <AANLkTimkD6vfDMhJjuwuVrrzVVvd51_ORmp6A4V0JC9L@mail.gmail.com>
References: <20110107225405.GH20411@chaosreigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Darxus@chaosreigns.com
X-From: git-owner@vger.kernel.org Sat Jan 08 00:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLwo-0005BR-IF
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab1AGXlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 18:41:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48313 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1AGXlo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 18:41:44 -0500
Received: by bwz15 with SMTP id 15so17759837bwz.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 15:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=0CcvauE7t9qT8bQxxuVzt7ljELGQIlSo0zBHFqgUCOY=;
        b=sRffgWApkE6UJdu2jVz/RhI+yhMyb6nj4Bu6/rY6yYWuZmqyxyj7kXfMEV8pbIL2Ye
         SUlwWz9FhuBfgS4wLm0FO9BP6w3KlPGt7n4YrsLB1E/ZVzbxUHBu76wzPpI79Wl01Dk+
         a3w8tkRtiyStSSADlK4l4k7Y/+eEzwiZeZNGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=f1UFDowBrKPxHUIDAjdEhrUJwNrrjeRT40EGOxGk6dTB3G4HoFbFyLy+3L/KUcIa7c
         jlVLFYpTQDyL5w4E6JWi/VdFDZIenTqUCshoPj072coJJNjkwE6dlsGScfTuWO7LrcD/
         3+ClJmaBVzLzj7Cn0/s+AwcxioSj8L65VP/sQ=
Received: by 10.204.117.71 with SMTP id p7mr1402950bkq.187.1294443701332; Fri,
 07 Jan 2011 15:41:41 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Fri, 7 Jan 2011 15:41:11 -0800 (PST)
In-Reply-To: <20110107225405.GH20411@chaosreigns.com>
X-Google-Sender-Auth: oV1tqU_ouSQVPu6G3T2vKExZwl4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164786>

On Sat, Jan 8, 2011 at 09:54,  <Darxus@chaosreigns.com> wrote:
> I'm working on a build script that pulls source from 12 git repos:
> http://www.chaosreigns.com/wayland/wayland-build-ubuntu-all.sh
>
> I would like to be able to do the equivalent of:
>
> =A0rm -rf gtk+; git clone git://git.gnome.org/gtk+ --branch gdk-backe=
nd-wayland
>
> Without re-downloading the entire thing. =A0Even if I made any kind o=
f
> modifications to the repo.

Are you aware of local cloning? ie:
  git clone ../my-repos/gtk+ --branch gdk-backend-wayland

=46irst of course, you create my-repos/ somewhere, and inside that dir,=
 run
  git clone --bare git://git.gnome.org/$which $which.git
for each of your 12 repos that your build script will work with.

Then whilst in my-repos/, when you need to update from upstream, do:
  for i in *; do cd $i; git fetch; cd ..; done

Your build scripts can clone from your local repos as often as you
like, without ever hitting the server.

But your question suggests you really have not read much git
documentation or experimented much - there is a heap, and lots of it
high quality. Read, do, learn.

Good luck
Zen
