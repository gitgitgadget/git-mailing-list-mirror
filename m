From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Tue, 6 Jan 2009 23:41:58 +0100
Message-ID: <c09652430901061441xf18d39fw42d54c6c16c3626e@mail.gmail.com>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
	 <alpine.LFD.2.00.0901061709510.26118@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:43:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKKe2-0006F2-5N
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762133AbZAFWmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbZAFWmD
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 17:42:03 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:58824 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbZAFWmA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 17:42:00 -0500
Received: by bwz14 with SMTP id 14so24773865bwz.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 14:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=a2F2FI12iQjTUlDa7N05hqcVE9KXTf0KlcKoW/sOiy4=;
        b=Vj4UISogHBqtzDKCaqJ+RWJO3xTQca8O58E5BsnJ5L6hzWFzVbJ81TkrjGOfhjPMLG
         +dYxXgjdJJWI3Snj3mKM8RAGU0uW0+8Fabe1U+JVMS3XEXP+yopEOR6OAYBMEnWZSfvt
         VgICj+nBMs23QHrE/drKwoS7jbzcKGprlJB1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=KHttDHpdHjuOf6KMauwq/jFci2lBlQHO/HlO+Rz2OdjW3g5+sgoRdBQGIhrznEAucK
         O+V1zY78+CYHONVv4pOZXuF0T/x6bfFW98bQkQokUNeWWTCGflv2tt8rWEVlvSO4mkrJ
         oi+n6DcpRTQ1qmizvQQiMI2eQN8MHJkaiTDlc=
Received: by 10.223.108.210 with SMTP id g18mr15902027fap.38.1231281718701;
        Tue, 06 Jan 2009 14:41:58 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Tue, 6 Jan 2009 14:41:58 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901061709510.26118@xanadu.home>
Content-Disposition: inline
X-Google-Sender-Auth: b8d9fc67b79dcf59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104734>

>> 3. I tried "git reflog expire --all" + lots of other tricks in the
>> link below, but no luck.
>
> OK, try this:
>
>        cd ..
>        mv my_repo my_repo.orig
>        mkdir my_repo
>        cd my_repo
>        git init
>        git pull file://$(pwd)/../my_repo.orig
>
> This is the easiest way to ensure you have only the necessary objects=
 in
> the new repo, without all the extra stuff tied to reflogs, etc.

Super!

That worked!

> Then, if your repo is still seemingly too big, you can get a bit dirt=
y
> with the sequence Johannes just posted.

Johannes procedure had the unexpected side effect of showing that
my server setup is flaky somehow though... :-) I'll need his
tricks for other situations soon enough.


--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
