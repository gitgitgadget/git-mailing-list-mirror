From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 18:54:15 -0400
Message-ID: <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
	<CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
	<B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
	<CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
	<3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
	<513B8037.7060107@gmail.com>
	<C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
	<CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
	<E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
	<CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com>
	<ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Mar 11 23:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFBcB-00030q-35
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 23:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab3CKWyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 18:54:17 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61819 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3CKWyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 18:54:16 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so1383487wib.16
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=BScKGnTSocHQnIeuXMJh8fZXEDdb6SHrv2odqf51ztQ=;
        b=R8wo4uOFClaUNkfmRyrfgwbESzp6IFK+P8hawsYsdL4lIiczsW3QdgozC8SKu+rdeJ
         O2JJ2wXDQscm7k63ItL7ai2kOoPKMXYrsj5M9JxVd1HoPamgQVzYEe4WCYQiZHfbNxKS
         FeI3KiQ5rK+WzamB4tBkmsAAcgkLDldugh+moKNUhc7bWo1a/EuH+yb2lyehvQ2o03aa
         J0KcdsppSFCZULMsY1D/BHEVqKtxpDJSI8ETNGGsDbwga9kha1x1A6VXQgCD+WfwwbOX
         zXTNDYxI2hWKtkSyH8wD+wL4knKpPRM6NurxrXg3puCn9t90IIMC412G14s5f76oXE4B
         4w7g==
X-Received: by 10.194.122.131 with SMTP id ls3mr22565085wjb.55.1363042455365;
 Mon, 11 Mar 2013 15:54:15 -0700 (PDT)
Received: by 10.194.138.107 with HTTP; Mon, 11 Mar 2013 15:54:15 -0700 (PDT)
In-Reply-To: <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217924>

On 3/11/13, Max Horn <max@quendi.de> wrote:
> Looking at the git config man page to check what each of my config settings
> does, I discovered "trustctime". And adding
> 	trustctime = false
> to .git/config made the rebase work, every single time. Huh.
>
>
> Adding this to the fact that a clone works fine, I wonder if  something *is*
> touching my files, but just in that directory. But what could it be? One
> nagging suspicion is the "file versioning" feature Apple introduced as part
> of Time Machine in OS X 10.7; it's kind of a "version control system for
> n00bs" for arbitrary documents. It has caused me some pain in the past.
>
> But I just re-checked, and problematic repos is explicitly on the Time
> Machine exclusion list. I also used the "tmutil isexcluded FILES" to verify
> that the problematic files are really on the TM exclusion list. Finally, I
> moved the one of the repos subdirectory containing most of the problematic
> files, and then run "git checkout". In other instances, this sufficed to
> "disassociate" a file from an unwanted TM version history. But doing that
> had no effect here, i.e. also with the freshly regenerated files, the
> problems appear.

Would you be able to turn off Time Machine completely and do a few
tests? If it does works, then it becomes a matter of fixing Time
Machine...
