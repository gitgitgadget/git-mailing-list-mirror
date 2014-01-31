From: Matthew Ruffalo <mmr15@case.edu>
Subject: Re: Having Git follow symlinks
Date: Fri, 31 Jan 2014 08:20:04 -0500
Message-ID: <52EBA304.3000205@case.edu>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se> <CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com> <alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se> <vpqa9ed1w8y.fsf@anie.imag.fr> <alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jan 31 14:26:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9E6r-0002Ju-VA
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 14:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbaAaN0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 08:26:14 -0500
Received: from mpv1.tis.CWRU.Edu ([129.22.105.36]:9201 "EHLO mpv1.tis.cwru.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932269AbaAaN0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 08:26:13 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2014 08:26:10 EST
Received: from mpv5.tis.CWRU.Edu (EHLO mpv5.cwru.edu) ([129.22.105.51])
	by mpv1.tis.cwru.edu (MOS 4.3.5-GA FastPath queued)
	with ESMTP id BBU11954;
	Fri, 31 Jan 2014 08:20:09 -0500 (EST)
Received: from mail-qc0-f179.google.com (EHLO mail-qc0-f179.google.com) ([209.85.216.179])
	by mpv5.cwru.edu (MOS 4.3.5-GA FastPath queued)
	with ESMTP id APX42265;
	Fri, 31 Jan 2014 08:20:06 -0500 (EST)
Received: by mail-qc0-f179.google.com with SMTP id e16so6916262qcx.24
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 05:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=oHlNYuHyqwpkPjLVrxcLA9KweyV8DAGUJaE5UKrBjXs=;
        b=NjgRSJOwYfedmAETChF5+JYgW3rKV9cFTS6Dxz28JX5AJFTywkK+JMbUBOY7eKArYE
         9GOY/WZUAOjB8oC4IGGCj2/qtJcugHcRE0AX7rf++IuxuZSBTt4aOsr8dQztQGsziaq6
         backvxYQHkFTRotOd4n3/dvDhdAXOEXRoms6lGU0Qx8a1vBeDSlX+Y9dXV9TpeB53/Rb
         1OQENWXiMlmnhi0xogZ05vNLJmJsMoNwTC0aoRZ37FSEK2kCG67rrepRrYDQDKo0uFrS
         OsYfwGREUAi/sYAFuKe5XNl3gVB+ZCUCyQUwzBmmaWMZNsi92WxeiJqLEYDqVz3VmMa3
         2V6w==
X-Gm-Message-State: ALoCoQmXX92ofcoZyH6EsSvpCOZOL+99JNt3DM/M7ENWLO8hQW8Gap/4yV6nQI2k55DFbPne5CoGxaVqMMq0Hdfody+n5XnIv3nTZgBVO50yq47BIRejHr4WxJ0GCBhT5IiK3q8dpALuEVXjiqI+XOqOHrO01aC1vw==
X-Received: by 10.224.103.131 with SMTP id k3mr31621564qao.102.1391174406265;
        Fri, 31 Jan 2014 05:20:06 -0800 (PST)
X-Received: by 10.224.103.131 with SMTP id k3mr31621543qao.102.1391174406123;
        Fri, 31 Jan 2014 05:20:06 -0800 (PST)
Received: from [10.0.8.11] (cpe-107-10-52-68.neo.res.rr.com. [107.10.52.68])
        by mx.google.com with ESMTPSA id j50sm13432630qgf.14.2014.01.31.05.20.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 05:20:05 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se>
X-Enigmail-Version: 1.6
X-Junkmail-Whitelist: YES (by domain whitelist at mpv1.tis.cwru.edu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241297>

On 01/31/2014 04:56 AM, Peter Krefting wrote:
> Matthieu Moy:
>
>> One option is to have the symlink in the other direction: make
>> /etc/foo a symlink to $GIT_WORKTREE/foo and version the later.
>
> I do that for the software that supports it, but ssh, for instance, is
> very picky that ~/.ssh is a directory and such. And at least one of
> the other files I version-control will be unlinked and overwritten in
> such a way that that does not work.
>
> I could split the repo up (that seems to be what "vcsh" is doing) and
> check the parts out in the corresponding directories, but I do like
> the idea of having one single repo.
>
>
> Oh, well, if I have the time, maybe I can come up with a patch. There
> is already some hacks in the "core.symlinks" setting, so I guess it
> should be possible.
>
This is now unrelated to Git, but I have .ssh symlinked to a
version-controlled directory on all of my machines (Kubuntu 13.10,
14.04, and recent Gentoo systems, but I've also done this on CentOS 5
and 6).

SSH doesn't care whether ~/.ssh is a symlink, but it *does* //care about
permissions:

"""
mruffalo@giygas:~$ ls -ld .ssh
lrwxrwxrwx 1 mruffalo mruffalo 13 Mar 17  2013 .ssh -> .home-git/ssh
mruffalo@giygas:~$ ls -ld .home-git
drwx------ 1 mruffalo mruffalo 116 Dec  8 01:26 .home-git
"""

If .home-git is mode 0755, SSH may refuse to use any private keys that
it finds, though I was unable to reproduce this with a few quick tests.

MMR...
