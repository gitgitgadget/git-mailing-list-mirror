From: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Thu, 25 Feb 2016 19:54:21 +0300
Message-ID: <CAHdYDCqM0dhjs0vYmuHmbU3Pr=Wmfp_7GbgXGsRcbT+TgX10vA@mail.gmail.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	<20160205204648.GA7403@vauxhall.crustytoothpaste.net>
	<xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
	<20160205210623.GC7403@vauxhall.crustytoothpaste.net>
	<xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
	<CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
	<CAHdYDCryaCbj-s6LG5fcDu115fi0k_uCawtus81PPbgyWpBTSA@mail.gmail.com>
	<xmqqk2lz9i66.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:54:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYzBL-0006be-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 17:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760641AbcBYQyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 11:54:23 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35072 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759877AbcBYQyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 11:54:22 -0500
Received: by mail-ob0-f175.google.com with SMTP id dm2so53367296obb.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oHbwRFk3VEMScVkgfmllZ1y0gfot0keb2T2MphTLh3s=;
        b=q25mFoJNWCuIaVlnq4AjjiC30h7misxFtBQ0IENNWBGLTKlzr8/zfwZM80c1ztZBFx
         /dsLaSOHA+N88T7G02NgBAWqL8CZF29G9gJTg5Y1hPxIpYDYawtNSWGwwz0pT0oPmB7d
         1R/r+jE1hS0cpB/04IDA13cio5eWaxBPfgid5F4+F8fjILyFsQGCND5950NmVLxVnHw8
         96UQtvUl8tInIB0RSf28/yFqhwGTGzcETgOGsm1ouWmExzaNfwvmfT8GMZdAzLJDxKf4
         cpVOpVIMz+s0DpaSuYzOM7LYOwvtACUFT8+kX97AGp9Hg9BFWt6KTStuPFlpF7GjQgrD
         84cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oHbwRFk3VEMScVkgfmllZ1y0gfot0keb2T2MphTLh3s=;
        b=O01mI4nYAJHBBkhvst7Hmav0yYAt9qlSRVTsHFFkpjDl88TT50RY7/QPZBWWpNL0s3
         9Ci26KiRaGHwfaI5yrw5Ur3myWwO1VIwHKDBKIaCTTtzWfi0j/HflLxGLipz9LFGQihr
         Yp3IhNfrvPJrjMAKBJU7InyvE7pryXDcSfd+mTR9VKqiLViRhbxO+/BgPPz6KPEJEbjr
         qd0xeEUGHmVrC2xJdekcSPE/Ar0VdPdJa/ZxZsfSoCNSli5I6dkpEYGOaac3w9crkBY/
         TTfpB61JyCjyYolfUW0H9vH5IInV9Jl1C/rxWr7vKdyJHek50eRTnepRJGDJN1HJO68P
         TskA==
X-Gm-Message-State: AG10YOSI+nEwNxqNjnEZj43I8V1zDfdetWiZ9OOStxUdEjXLx668OMiH8+NtewvmH8bpeD0jhKXSchh53IMm9Q==
X-Received: by 10.60.96.74 with SMTP id dq10mr39534732oeb.78.1456419261865;
 Thu, 25 Feb 2016 08:54:21 -0800 (PST)
Received: by 10.76.130.36 with HTTP; Thu, 25 Feb 2016 08:54:21 -0800 (PST)
In-Reply-To: <xmqqk2lz9i66.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: o7iApApjGurDF0s1HvBq7l4HerA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287400>

Hi, guys!

> I sent in a patch (and I believe I CC'd you) that adds an option
> http.emptyAuth that can be used in this case.  It should make its way to
> a future release.

Somehow I've missed your letter...

> The patch has been queued as 121061f6 (http: add option to try
> authentication without username, 2016-02-15); perhaps you can help
> by trying it out in your installation before it hits a released
> version of Git?  That way, if the patch does not fix your problem,
> or it introduces an unexpected side effect, we would notice before
> we include it in a future release.

I've cherry-picked commit 121061f6 over version 2.4.10 and 2.7.1.
In both cases it works exactly as expected.

Please, let me know if I can help with something else regarding this issue.

2016-02-21 0:38 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Dmitry Vilkov <dmitry.a.vilkov@gmail.com> writes:
>
>> Hi guys! Any luck with fixing this issue?
>
> I think Brian suggested an alternative approach, to which you earler
> responded
>
>>> That would be great! Definitely it will be much better solution than
>>> patch I've proposed.
>
> The patch has been queued as 121061f6 (http: add option to try
> authentication without username, 2016-02-15); perhaps you can help
> by trying it out in your installation before it hits a released
> version of Git?  That way, if the patch does not fix your problem,
> or it introduces an unexpected side effect, we would notice before
> we include it in a future release.
>
> Thanks.
>
