From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: Is there a library for monitoring a git repository for any
 changes?
Date: Fri, 7 Jun 2013 09:00:46 -0400
Message-ID: <20130607130042.GA28057@google.com>
References: <CABaQ0JgJaCY-LXHjXMq_7NTgHf2GqN4Ond7rm61jfLAV-gEgRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robert Martin <rdmartin3@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 15:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkwHo-0006ut-Te
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 15:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab3FGNAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 09:00:49 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:34662 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab3FGNAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 09:00:47 -0400
Received: by mail-yh0-f74.google.com with SMTP id i72so261560yha.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vo4KTja5MLDIux3VDnEIeTgIal/OdxDmese7uUYfdMo=;
        b=BEIbHPoMXZcipraYVIOeQA0Jvsg5G/oWkxRnPaFjls5DQuZOqN1p6lZGtKZgPP7084
         3lwbFdF/6oRAsQ6VtFz9v7BRoRHBQ+h9I+sSLZl1F2B8Il4c4wUa+6+iqJ8F8JEyNHxQ
         bcsPccsVApdEAEmPMgw/86K8kK21WWPeiq5t08NH1B9Yonexz0e7Jjz7Zj1UsRLC9m60
         AA9wgHSgRUXtFW21nRs4kBJMP9xAJsR7xDrVEYEuP/Fad5R6XhP9nccCd7dpFuDl59Ag
         jfvJCq8yMlDYny+Yxy09s9FyxHLHG/QMyabXfroRC6O1Dunkyl2gIkMLSXkYSER4NqUB
         /Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=vo4KTja5MLDIux3VDnEIeTgIal/OdxDmese7uUYfdMo=;
        b=OQLaB/D+QbfbmNxbW6lGWFgPo6n7VE2je7Sj3Ll7QYvwJ89VRBeWJ+MJH8Ft7d+pVu
         1Ei+DBTS+UWkXz6cvykKq4pDYiOwL2NTQHoL2UEZ9o+mmnV4Ig7DX8TmkVMAmuPprvIW
         VPFOVpOoFH7ZWxiarltAnhUSRE+78NfUlyrWdnw+jT0H3y2WSdP5gh/DvS8UgiAVhEKH
         Exygoyiz6XASG7appcMh6ko/0GcWr/ZVAZsTiG69LPehQNti5PGRz81LL9I95fHzcEq3
         Cf11JIWRIi2XDuoBA3h6BFfyY8qDEeXvmng+rPXrAP5G2eJD+QZ1W4FZjk6g9u8FfH6D
         fYug==
X-Received: by 10.236.53.202 with SMTP id g50mr8120436yhc.1.1370610046803;
        Fri, 07 Jun 2013 06:00:46 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g80si584218yhj.7.2013.06.07.06.00.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jun 2013 06:00:46 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AB62E5A4208;
	Fri,  7 Jun 2013 06:00:46 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 1B04A40803; Fri,  7 Jun 2013 09:00:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABaQ0JgJaCY-LXHjXMq_7NTgHf2GqN4Ond7rm61jfLAV-gEgRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnBwc5cRMPSJDbIDzbdubmvtB9Uhkz6eSVe3CWcFyREDqdI2SNd7naZ4wPmcnXc6TVw5uD7b+5XdjcQw1e8lCxnbWun5auzojJy1fR/WuM5FjX2nbR8gyPYNqpZx9+IHLEauXTDAlRGYrt1V//4cHP14efi0wy63aZZbdk4iuOL9vmcmXux8ya5FjLaW8Nf0bYnSUUh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226626>

On Thursday, June 06, 2013 at 23:16 EDT,
     Robert Martin <rdmartin3@gmail.com> wrote:

> I want to work on a visualization program for git. I was hoping there
> was a library that would allow me to monitor a git repo for changes.
> Consider it like inotify, but for a git repository (in fact, I think
> it would probably have inotify under the hood).
>=20
> This hypothetical library would trigger an event any time the
> repository was modified, i.e. any time the graph that represents
> history was changed.
>=20
> Is there such a library? If not, is there a better way to monitor the
> repository so that I wouldn't need to write it myself? Would anyone
> else be interested if I wrote it myself?

'git ls-remote'? Either run periodically or, if the monitored git is
local, triggered via inotify. If you have control over the git perhaps
a post-receive hook would be useful too.

--=20
Magnus B=E4ck
baeck@google.com
