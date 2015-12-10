From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 13:33:26 -0500
Message-ID: <CAKfKJYtuY7kYV9zNysCFpJ2CwVy=Eo-yJk=eYYooOAy1eZLxJA@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
 <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com> <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114a6fcc73313e05268f7267
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a762K-0002L9-QK
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbbLJSds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:33:48 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34609 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbbLJSdr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:33:47 -0500
Received: by qgeb1 with SMTP id b1so156413853qge.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ESDIVZUSDx+4OBstIgd38kFzY4QfiDgawbMNjRQgd9M=;
        b=VA22kVTEZa2/YqasQotG1Ez8Fvbg3jvzJCtOvAhyzJ+g/P2mq0eGdPX/vrVhDJTuH1
         MOv5gEZgeuz5JS8+46lwMM9QkNZkElctkfw9oZIAmVBofwWLc9mWt72jAPkKxg2bK5/4
         ptgdMCiPomo5xJP7bjwyx0n4RFY/9PZxcpoPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ESDIVZUSDx+4OBstIgd38kFzY4QfiDgawbMNjRQgd9M=;
        b=PwTWhrvTY9d5++ZOnV+YeBodR8QklLDoGzRQc6d89MoBw0PM/GX1ETpYIxowDIh5a4
         naiONGjigZljBV5hSpvDsPBbYU1sY7frvDVyu0kh+ueOtUNSr9c3kwOPm8YPFbWeBSN9
         RK1QfemSTwbre408Gm4a+glBstvGebhahv9W8AEpt2DjKTK7BUzg/YXAuDwJ7zGNEYJX
         QcrQb/tapWs2xyH8kJKPpXgNNjra0I0IYMyz4LJgo92n1lZ5CsgqHeabaa+/OLEFHnI8
         8f4b5cH0xqxiLbTpt0RpovCNdIU7+4CQ57i/QpTEkMa+5a9nObb0dlGIl2Q8B54RgzCD
         p0Sg==
X-Gm-Message-State: ALoCoQmtaFLGCkp21ISyF4ZNkeKSQxI/8PGUTKJYNVc7DMZW8UC4S9QQ9Y1OgS2gRS49zGJe8n9aYcq+917gYfMCAKDV5nZaxA==
X-Received: by 10.140.39.210 with SMTP id v76mr17302530qgv.75.1449772426432;
        Thu, 10 Dec 2015 10:33:46 -0800 (PST)
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com. [209.85.192.43])
        by smtp.gmail.com with ESMTPSA id v187sm6565285qka.9.2015.12.10.10.33.45
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Dec 2015 10:33:45 -0800 (PST)
Received: by qgeb1 with SMTP id b1so156413434qge.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 10:33:45 -0800 (PST)
X-Received: by 10.55.82.193 with SMTP id g184mr17520069qkb.65.1449772425875;
 Thu, 10 Dec 2015 10:33:45 -0800 (PST)
Received: by 10.55.128.198 with HTTP; Thu, 10 Dec 2015 10:33:26 -0800 (PST)
In-Reply-To: <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAKfKJYtuY7kYV9zNysCFpJ2CwVy=Eo-yJk=eYYooOAy1eZLxJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282219>

--001a114a6fcc73313e05268f7267
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 9, 2015 at 5:35 PM, Taylor Braun-Jones
<taylor@braun-jones.org> wrote:
>
> On Wed, Dec 9, 2015 at 1:24 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Wed, Dec 9, 2015 at 5:08 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> >> On Wed, Dec 2, 2015 at 9:10 PM, Taylor Braun-Jones
> >> <taylor@braun-jones.org> wrote:
> >>> My use case it running git clone inside a docker container with
> >>> `docker run --user $(id -u):$(id -g) --volume /foo:/foo ...`. I want
> >>> all /foo/* file creation/access from inside the Docker container to be
> >>> done as the current uid/gid of the host system.
> >>>
> >>> Steps to reproduce:
> >>>
> >>> mkdir /tmp/docker-git
> >>> cat > /tmp/docker-git/Dockerfile <<EOF
> >>> FROM ubuntu
> >>> RUN apt-get update && apt-get install -y git-core
> >>> EOF
> >>> docker build -t git /tmp/docker-git/
> >>> docker run --user $(id -u):$(id -g) git git clone
> >>> https://github.com/git/git.git /tmp/git
> >>> # fatal: unable to look up current user in the passwd file: no such user
> >>
> >> It probably helps if you could get the stack trace to this message
> >> (printed from function xgetpwuid_self). I haven't checked if my
> >> personal laptop has docker to reproduce this.. In general we won't ask
> >> passwd if the user specifies name/email in the config file. But I
> >> still don't see why git-clone needs that info in the first place.
> >
> > Well.. reflog needs it. So either you disable reflog at clone time or
> > define name/email via config file. I don't see anything wrong with
> > this behavior.
>
> Can't git just use "unknown" and "unknown@localhost" if the name or
> email can not be determined from xgetpwuid? This seems to be the way
> that Mercurial behaves.

See attached patch for an implementation of the fallback-to-unknown
idea. With this, I'm able to clone a repository under a UID that does
not exist in /etc/passwd and do everything that I'd expect to do with
a local git repository. Is there something that I've missed?

Taylor

--001a114a6fcc73313e05268f7267
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Warn-not-die-when-unable-to-look-up-current-user-in-.patch"
Content-Disposition: attachment; 
	filename="0001-Warn-not-die-when-unable-to-look-up-current-user-in-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ii0kxa0w0

RnJvbSBkZDVjMmNjZjVkZjQxMDRlNjc3Zjg0ODhmYmI0YmU5OGZmMTgzMWM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYXlsb3IgQnJhdW4tSm9uZXMgPHRheWxvckBicmF1bi1qb25l
cy5vcmc+CkRhdGU6IFRodSwgMTAgRGVjIDIwMTUgMTM6MjE6MjUgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBXYXJuIChub3QgZGllKSB3aGVuIHVuYWJsZSB0byBsb29rIHVwIGN1cnJlbnQgdXNlciBp
biB0aGUKIHBhc3N3ZCBmaWxlCgotLS0KIHdyYXBwZXIuYyB8IDIyICsrKysrKysrKysrKysrKysr
Ky0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3dyYXBwZXIuYyBiL3dyYXBwZXIuYwppbmRleCA2ZmNhYTRkLi44MTE5MDY4
IDEwMDY0NAotLS0gYS93cmFwcGVyLmMKKysrIGIvd3JhcHBlci5jCkBAIC02MDQsMTIgKzYwNCwy
NiBAQCBpbnQgYWNjZXNzX29yX2RpZShjb25zdCBjaGFyICpwYXRoLCBpbnQgbW9kZSwgdW5zaWdu
ZWQgZmxhZykKIHN0cnVjdCBwYXNzd2QgKnhnZXRwd3VpZF9zZWxmKHZvaWQpCiB7CiAJc3RydWN0
IHBhc3N3ZCAqcHc7CisJc3RhdGljIHN0cnVjdCBwYXNzd2QgcHdfdW5rbm93biA9IHswfTsKIAor
CXVpZF90IHVpZCA9IGdldHVpZCgpOwogCWVycm5vID0gMDsKLQlwdyA9IGdldHB3dWlkKGdldHVp
ZCgpKTsKLQlpZiAoIXB3KQotCQlkaWUoXygidW5hYmxlIHRvIGxvb2sgdXAgY3VycmVudCB1c2Vy
IGluIHRoZSBwYXNzd2QgZmlsZTogJXMiKSwKLQkJICAgIGVycm5vID8gc3RyZXJyb3IoZXJybm8p
IDogXygibm8gc3VjaCB1c2VyIikpOworCXB3ID0gZ2V0cHd1aWQodWlkKTsKKwlpZiAoIXB3KSB7
CisJCXdhcm5pbmcoXygidW5hYmxlIHRvIGxvb2sgdXAgY3VycmVudCB1c2VyIGluIHRoZSBwYXNz
d2QgZmlsZTogJXMiKSwKKwkJICAgICAgICBlcnJubyA/IHN0cmVycm9yKGVycm5vKSA6IF8oIm5v
IHN1Y2ggdXNlciIpKTsKKwkJcHdfdW5rbm93bi5wd19uYW1lID0gInVua25vd24iOworCQlwd191
bmtub3duLnB3X3Bhc3N3ZCA9IE5VTEw7CisJCXB3X3Vua25vd24ucHdfdWlkID0gdWlkOworCQlw
d191bmtub3duLnB3X2dpZCA9IGdldGdpZCgpOworCQlwd191bmtub3duLnB3X2RpciA9IE5VTEw7
CisJCXB3X3Vua25vd24ucHdfc2hlbGwgPSBOVUxMOworICNpZm5kZWYgTk9fR0VDT1NfSU5fUFdF
TlQKKwkJcHdfdW5rbm93bi5wd19nZWNvcyA9IE5VTEw7CisgI2VuZGlmCisJCXB3ID0gJnB3X3Vu
a25vd247CisJfQorCiAJcmV0dXJuIHB3OwogfQogCi0tIAoyLjYuMwoK
--001a114a6fcc73313e05268f7267--
