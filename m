Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FFF202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbdKQRnF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 12:43:05 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33839 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdKQRnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 12:43:03 -0500
Received: by mail-qt0-f181.google.com with SMTP id 8so7795118qtv.1
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yvAYZYq5uYhbmESdfBMtBU8Ze/ie51jfmGKSXZV53uU=;
        b=ITScho2MFtFGI2l0vdSO9yIyN2uqjCqTKiAML+mqkvcW+brmDiUauDZdG/lk+7b1Wb
         tNT9BXapmW/8ZUaAWtKqPXN3ytqTgzWihiXFVISDbDQiN5Z2DM597nVZoAfXx0iKjTBx
         PE5TPGd1LZBe5MpcC89JHbSkValJqPDhIorxOOp4nRRyuytGIkXEaIK1dv9h8xukNQct
         60kwX2ZG8pvGE1IGiG/Lk9NcaA5v/EQpPAURBrTslOn2LdzUmQLxYemLpaFSKcJGMvIG
         zhTq+BSuj8VEU6Vwo4EvYSshSWuT0mHE6xirqQVaZBm8r+J2WS8rHg8BF/4cuRLzAqfc
         w3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yvAYZYq5uYhbmESdfBMtBU8Ze/ie51jfmGKSXZV53uU=;
        b=sVv8j4sX/syhhHGk41II8dJDr9/JaiP8QWuWj6DlEpmafA/kRcmDZ82oUJy6JHCq+c
         xrGWfUKhhzwqdmpItw+wPuGuLCRMU+ll+uBqvSScnFMZJkxyDV+BVwQqfkSxKokWsDJx
         k2dbgabj3DSSLFQm1EELgUW1Lb1vn8ScSPs7kxoVnKoUKYhsYJDF4CA3CcKyCUl1Ei3J
         8ce2/svu3CBbSwAoXAVWM4RpiqWgpHJ/eIIVP9V4CRTI3N+tt5GN75mYblhcitjWg2lC
         XfrUXWUeqnZ5jTNo3dathWacDJ87lSwpzG/8H9T6QCpR0qnoRhHr3M8ERE9fT6gtPCN7
         fI0w==
X-Gm-Message-State: AJaThX5QG/omPJ+oMHzoyzC7fmC8nuih7GFwWixI7m+80qfx+xFhkJJT
        9A74VlC639EOKTDGI/32Q6roM1D9w+c=
X-Google-Smtp-Source: AGs4zMZLZIqby5wAExbGEBptD9IRZiUg5tjMCydT07G5Zn5CNvgXF0yjDKm/1eMz5LyPQHnLnd42gw==
X-Received: by 10.200.23.136 with SMTP id o8mr9666038qtj.258.1510940582650;
        Fri, 17 Nov 2017 09:43:02 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id a35sm3060060qka.34.2017.11.17.09.43.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Nov 2017 09:43:01 -0800 (PST)
Date:   Fri, 17 Nov 2017 12:42:58 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171117174258.GP3693@zaya.teonanacatl.net>
References: <20171115125200.17006-1-chriscool@tuxfamily.org>
 <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1hcFLMvNsXONPNbxZhTbHVzSMdRgCB9m=ZGeSTpMsYew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1hcFLMvNsXONPNbxZhTbHVzSMdRgCB9m=ZGeSTpMsYew@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> On Thu, Nov 16, 2017 at 2:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I suspect that this change will hurt those who package Git for other 
>> people.
>
> Maybe a little bit, but in my opinion it should not be a big problem 
> for them to install Tcl/Tk and its dependencies on the build machine.

It's not a big burden, but it is a seemingly unnecessary build-time 
dependency.

>> It used to be that, as long as they have msgfmt installed, they only 
>> needed to _know_ what the path on the users' box to "wish" is, and 
>> set it to TCLTK_PATH, and if they are distro packagers, most likely 
>> they already have such an automated set-up working.  Now with this 
>> change, they are forced to install tcl/tk on their possibly headless 
>> box where tcl/tk is useless, and worse yet, an attempt to install it 
>> may bring in tons of unwanted stuff related to X that is irrelevant 
>> on such a headless development environment.
>
> Yeah, but if they build gitk and git-gui, there is a significant 
> chance that they build other graphical software too, and that this 
> will require installing stuff related to X anyway.

Most distributions build packages in individual container or chroots, 
to increase the stability and reproducibility of the builds.  So 
package builds don't run on systems where any deps have already been 
installed.

To be fair, it looks like pulling in tcl/tk would add only around 8MB 
to the Fedora build root for git.  That's not egregious, to be sure.  
But it really isn't a necessary build-time dependency either.  I don't 
know if there are other distros who would strongly object to pulling 
in tcl/tk.  Some are much more sensitive to build root sizes and 
unnecessary dependencies.

> In general I think packagers are much more able to deal with those 
> kinds of problems than most regular developers who want to hack on 
> Git.

I agree.  Packagers also provide git builds to the vast majority of 
end-users, so we should make their task easier whenever possible. :)

> So asking packagers to either set NO_TCLTK or BYPASS_TCLTK_CHECK or to 
> install Tcl/Tk would not burden them much, especially compared to what 
> regular developers have to deal with these days when trying to build 
> Git.

Presuming this new BYPASS_TCLTK_CHECK is communicated well and that 
the failure when not using it is clear, this doesn't seem likely to 
cause problems.  (I'll leave it to others whether there's a better way 
to solve the msgfmt fallthrough issue.  I didn't even know such a 
fallthrough existed until yesterday.)

I think it's important to ensure that automated package builds of a 
newer git don't simply skip parts of the build which used to work and 
so packagers reading the failed builds logs can easily see what they 
need to adjust.

Just dropping the new variable in the Makefile and waiting for package 
builds to fail or not package gitk & git-gui at the next release would 
be a bit unkind, I think.  Posting this to the git-packagers group[1] 
which Ævar created would be useful.  It /might/ even be worth asking 
there if any distros have strong opinions on the subject.

[1] https://groups.google.com/forum/#!forum/git-packagers and
    git-packagers@googlegroups.com

>> I think "If I cannot run either wish or msgfmt, then barf and give 
>> an error message" might at least be needed.  Am I misinterpreting 
>> the motivation of the patch?
>
> I'd rather add a separate check for msgfmt than mixing the 2 issues, 
> because I think that unless it has been explicitly told to do so, 
> Git should not try to build git-gui and gitk in the first place if 
> there is a big chance that those tools will not work.

If that's a motivation, wouldn't a check in the gitk and git-gui 
scripts handle it?  That would provide an error at run time to the 
user.  This change is about helping the user who builds their own git 
and then runs it, so if they built git without wish installed and then 
ran git-gui, they'd get a clear error that wish is missing and could 
easily install it.  It's not needed for the build, so they wouldn't 
need to rebuild anything.

Something like this:

diff --git i/gitk-git/gitk w/gitk-git/gitk
index a14d7a16b2..f9f28a164a 100755
--- i/gitk-git/gitk
+++ w/gitk-git/gitk
@@ -1,5 +1,6 @@
 #!/bin/sh
-# Tcl ignores the next line -*- tcl -*- \
+# Tcl ignores the next 2 lines -*- tcl -*- \
+type wish >/dev/null 2>&1 || { echo "error: wish not found" >&2; exit 1; }; \
 exec wish "$0" -- "$@"
 
 # Copyright © 2005-2016 Paul Mackerras.  All rights reserved.

maybe?  (The error message is certainly open for improvement.)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A fool's brain digests philosophy into folly, science into
superstition, and art into pedantry.  Hence University education.
    -- George Bernard Shaw

