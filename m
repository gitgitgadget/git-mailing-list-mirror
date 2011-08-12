From: Shawn Pearce <spearce@spearce.org>
Subject: Re: open files limit
Date: Fri, 12 Aug 2011 09:09:53 -0700
Message-ID: <CAJo=hJsj8_VjD5wN9Gge_Me-eXKK-P7nLAxERiiLp0+ayiEBbg@mail.gmail.com>
References: <20110812151548.GA14385@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 18:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QruJR-0006qk-4I
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 18:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab1HLQKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 12:10:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53300 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1HLQKP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 12:10:15 -0400
Received: by bke11 with SMTP id 11so1752288bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 09:10:13 -0700 (PDT)
Received: by 10.204.130.209 with SMTP id u17mr453492bks.62.1313165413607; Fri,
 12 Aug 2011 09:10:13 -0700 (PDT)
Received: by 10.204.124.18 with HTTP; Fri, 12 Aug 2011 09:09:53 -0700 (PDT)
In-Reply-To: <20110812151548.GA14385@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179234>

On Fri, Aug 12, 2011 at 08:15, Pete Wyckoff <pw@padd.com> wrote:
> Somebody at $work found this problem:
>
> =A0 =A0$ git ls-files -s | wc
> =A0 =A0error: packfile .git/objects/pack/pack-1627e77da82bbb361187626=
49c8aa88c05664b1e.pack cannot be accessed
> =A0 =A0[..lots more similar errors..]
>
> Turns out his shell's open file descriptor limit was 500. =A0And
> there are 1600 pack files in the repo.
>
> Increasing the descriptor limit to 1024 fixed it. =A0I could
> probably get him to repack, which may also fix it.
>
> Does it seem feasible to look for EMFILE errors and close
> some packs? =A0Or at least spit out a more intuitive error?

What version of Git? I remember fixing this already.... :-)

--=20
Shawn.
