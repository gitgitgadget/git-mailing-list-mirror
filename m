From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] sequencer: factor code out of revert builtin
Date: Tue, 15 Nov 2011 14:30:56 +0530
Message-ID: <CALkWK0mtmRYyFosQNJixhheUmHpRjWc4A5zPQ6AaBfmw4H4eLQ@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-2-git-send-email-artagnon@gmail.com> <20111106001232.GC27272@elie.hsd1.il.comcast.net>
 <CALkWK0n7v15n_s3CNq1Qu3LHjYkV-ENAkv2b+oB+VBkyV+Sphw@mail.gmail.com> <7vvcqnmxeu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 10:01:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQEtP-0003Ce-4q
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 10:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab1KOJBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 04:01:18 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34023 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1KOJBS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 04:01:18 -0500
Received: by wyh15 with SMTP id 15so6781414wyh.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DGsOyYMjEN78oOecGDoIieMdgfG8q7zq34lp4Tgaqqg=;
        b=fn6JQUUAQ3nXa5ylHMT8QVa/huNadrIJXLg/3nVQPsoLIfivfVYvsYx4zdB2YsVKuf
         cSx00aAnHP/g331U/iN4gvmXkbhQSkg82AyjZoJt4+zvWOZS5myMOeuH9bxpyo3NeXvv
         +GuXz0TO5ZQJXXaMZ0Ty4mhUM6FIGv2eSbk0M=
Received: by 10.216.188.145 with SMTP id a17mr4266873wen.24.1321347677212;
 Tue, 15 Nov 2011 01:01:17 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 01:00:56 -0800 (PST)
In-Reply-To: <7vvcqnmxeu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185445>

Hi Junio,

Junio C Hamano writes:
> [...]
> With that observation, it would probably make more sense if "foo.c"
> included the headers in the following order:
>
> =C2=A0- git-compat-util.h (or the prominent ones like "cache.h" that =
is known
> =C2=A0 to include it at the beginning);
> =C2=A0- Anything the declarations in "foo.h" depends on;
> =C2=A0- "foo.h" itself; and finally
> =C2=A0- Other headers that "foo.c" implementation needs.
>
> That way, people who want to use "foo.h" can guess what needs to be
> included before using "foo.h" a lot more easily.

That's a good rule-of-thumb.  Thanks :)

-- Ram
