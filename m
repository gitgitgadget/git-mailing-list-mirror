From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Wed, 9 Dec 2015 10:23:17 -0500
Message-ID: <CAKfKJYu1frw5QLkkkZo-F1kxbkLREpyudFiCST6h7hSS=LPdmw@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:23:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6gam-0002OU-16
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 16:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbbLIPXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 10:23:39 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:32819 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbLIPXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 10:23:38 -0500
Received: by qgea14 with SMTP id a14so84557730qge.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=yDRjQA3TNY3Hele82HnQyHZOh74cQ+oOBkDSXTw+FhM=;
        b=g8UNzycPMSTlBPrTNMt+ucRrl+67ILvDsF0kRGibxOBSUeC00/EcPT9j1SUNmSmfUe
         HwDA7EB5hPVQ4ufj6IRM0prfXINQUpDQ9kwQbpCsESwllCdkH13RG2Y6w8Du+bT3INSy
         9ArTMSyZ5kw1OBSYq8ZKu1BlaZ31mCwRn5IUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=yDRjQA3TNY3Hele82HnQyHZOh74cQ+oOBkDSXTw+FhM=;
        b=JJmJO2R69nDJEnEp2hmx/o1mpj4yI/4C4ZTrWjQLg77t6446Yrf/LioQ4BkOZf5QLQ
         PbPJDv2CmwSswiav+Oy6UF13SREg8hWdJq07u2++bmEUAY7fkj7svERAnFoyhtbW97xQ
         Xia/cVpQ/scGtVfx7XjXTe4sDivTooYXXRhZ03We0Cf7uDkH/FdHIgoITxOgodAMnRpV
         S+N+1jAgE34+/82P6VE/VniTOnBdboLWg4yvvVx2M3cFwHL1geDCi4F1clknRuvEw3PF
         /MdTeSQsyOQff4fTWWiIpzxa9q2yf9wIKc/d8sXHWgsnvk2SJ05UPoi9Wd188Ix+0kjC
         GW/w==
X-Gm-Message-State: ALoCoQkCfM2G9zrq9G29Ikhrknbvx039qOx0+dNUvvDVu/lY8xYkAMdjaaMxjQsPbwwvZTqPWMmAOCZ5qEWFCsoGrCTYvFsnYQ==
X-Received: by 10.140.97.229 with SMTP id m92mr8023233qge.22.1449674617610;
        Wed, 09 Dec 2015 07:23:37 -0800 (PST)
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com. [209.85.192.52])
        by smtp.gmail.com with ESMTPSA id a136sm4030389qkb.20.2015.12.09.07.23.37
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Dec 2015 07:23:37 -0800 (PST)
Received: by qgea14 with SMTP id a14so84557225qge.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 07:23:37 -0800 (PST)
X-Received: by 10.55.72.85 with SMTP id v82mr8300026qka.52.1449674617121; Wed,
 09 Dec 2015 07:23:37 -0800 (PST)
Received: by 10.55.128.198 with HTTP; Wed, 9 Dec 2015 07:23:17 -0800 (PST)
In-Reply-To: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAKfKJYu1frw5QLkkkZo-F1kxbkLREpyudFiCST6h7hSS=LPdmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282192>

What's the feeling on this one? If there's agreement in principle that
git-clone should not fail when the current UID cannot be found in
/etc/passwd then I'm happy to submit a patch to fix it.

Thanks,
Taylor

On Wed, Dec 2, 2015 at 3:10 PM, Taylor Braun-Jones
<taylor@braun-jones.org> wrote:
> My use case it running git clone inside a docker container with
> `docker run --user $(id -u):$(id -g) --volume /foo:/foo ...`. I want
> all /foo/* file creation/access from inside the Docker container to be
> done as the current uid/gid of the host system.
>
> Steps to reproduce:
>
> mkdir /tmp/docker-git
> cat > /tmp/docker-git/Dockerfile <<EOF
> FROM ubuntu
> RUN apt-get update && apt-get install -y git-core
> EOF
> docker build -t git /tmp/docker-git/
> docker run --user $(id -u):$(id -g) git git clone
> https://github.com/git/git.git /tmp/git
> # fatal: unable to look up current user in the passwd file: no such user
> echo $? # 128
>
> My current workaround is:
>
> cat >> /tmp/docker-git/Dockerfile <<EOF
> RUN git config --system user.name Docker && git config --system
> user.email docker@localhost
> EOF
>
> But I don't see why this should be necessary just to clone a repo. I
> run complex build jobs inside a docker container using this approach
> and git-clone is the first command to fail due to the lack of a passwd
> file entry for the current user. Some complain to stderr, but still
> succeed.
>
> Regards,
> Taylor
