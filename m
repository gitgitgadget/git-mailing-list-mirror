From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 1/2] t3401: modernize style
Date: Sat, 10 Dec 2011 00:14:43 -0800
Message-ID: <CAOeW2eGbwQZRDXn0crMD2eMTkw3eqWeCS3x2p4VhT65q45cs0Q@mail.gmail.com>
References: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<CALkWK0mip_pzUDQO=YLxaVwsWEAUdrk_EKcNG94Xr5+N+kzBtw@mail.gmail.com>
	<20111209200703.GA21280@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 09:14:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZI54-0004UP-TN
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 09:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab1LJIOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 03:14:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41270 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab1LJIOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 03:14:44 -0500
Received: by iakc1 with SMTP id c1so5477796iak.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 00:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XJopoVPTJJSDNlsWY+DcpDMn2HtdpMPnvwi9aKy3e94=;
        b=L4+wjX4D8dtG9OtYRwWdR7EWHuqMyIcra5KiyyW8vUcV7vw0Ek+dAc9jF5sXD5zIbn
         srGymYN/09GOsh/KbHIMjcE6MnWRYRHEtWOdA5BvKALIU5d/1+WP3o1SiIyvJ0WsRczt
         kKlyLcPB+dCX2E/VS2qLJkxCm2GomI8aqXjm0=
Received: by 10.42.172.70 with SMTP id m6mr5358942icz.37.1323504883677; Sat,
 10 Dec 2011 00:14:43 -0800 (PST)
Received: by 10.231.23.213 with HTTP; Sat, 10 Dec 2011 00:14:43 -0800 (PST)
In-Reply-To: <20111209200703.GA21280@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186728>

On Fri, Dec 9, 2011 at 12:07 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ramkumar Ramachandra wrote:
>
>> The motivation is unclear: lazy afternoon? :P
>
> Perhaps he was reading the list and after noticing a few patches in
> the same vein, realized that this test script could be made easier to
> read, too.

Sort of. These patches have been sitting in my repo since late Sept
and the patches you mention made me decide to send them out now. The
reason I did this back then was while trying to fix rebase to pick the
right patches when used with --onto. See this old discussion:
http://thread.gmane.org/gmane.comp.version-control.git/161917/focus=3D1=
62041.
Also in the same series are patches teach rebase to only feed the
commit names to git-am (wrapped in a silly "From $sha1 Mon
Sep 17 00:00:00 2001" to please git-mailsplit). These patches have
been taking way too long, which is why I'm sending these little
cleanups separately.

>> Martin von Zweigbergk wrote:
>
>>> + =C2=A0 =C2=A0 =C2=A0 echo First > A &&
>>> + =C2=A0 =C2=A0 =C2=A0 git update-index --add A &&
>>> + =C2=A0 =C2=A0 =C2=A0 git commit -m "Add A." &&
>>
>> Style nit: >[^ ] is prevalent FWIW.
>
> Finally I caught on that you mean that redirection operators tend to
> be flush against the filename they are redirecting to.

So did I. I think I'll leave the code unchanged, though, because the
end result, after patch 2/2 is unaffected anyways (it removes
redirections).

>> While at it, why not change this "test ! -d" to
>> "test_path_is_missing"?

Will bake it into patch 2/2 if you don't mind. Unless there are other
comments, that would mean this patch can be applies as is, Junio.

> The patch looks good to me, too. =C2=A0Thanks, both.

Thanks to you both, too.
