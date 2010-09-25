From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: 'git diff' against files outside a git repo
Date: Sat, 25 Sep 2010 00:45:10 -0700
Message-ID: <AANLkTikpPQM4GyP5O7+aw6_P9_1DdxUjTzpH=WhzW=wK@mail.gmail.com>
References: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com> <AANLkTik4kL8Mao1VM=njNxFSXOY7guwuEZgmpv0UTc8R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 09:45:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzPS0-0006th-Fj
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab0IYHpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 03:45:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39158 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884Ab0IYHpc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 03:45:32 -0400
Received: by wyb28 with SMTP id 28so2554269wyb.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x0IIbe1dSkrFOprQCpN/NgEYJRY/Wh1+no9m5nMkJHU=;
        b=pP4elWhBTzlHKe89lD7ZBx606Y8KtGjbesbw+BGtrBo59FAfgkO576ltl6VvCXuWSL
         KFFN+6fObTlS8Kh3HT0GIbAMt1y0eXlfrYia3KRmzVy9YK0gIi7IgPrvJMsNpCKpahes
         NaPmk+NyfoxxpFBz/o2EyuUjKujtkqVqvny9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MfyBgdxbw83wO02HO1l8Q+hgpoCmSbb9YIXrrzfesNCGR97Axx3odPggb/byv1CKWV
         FWgeUHF/9S1/jlwPDHK3Opf+wV8fpQTXaEBCmE/ONwMkOu+Nk/eNToHWWRnVrUoBOvbq
         puaTSJh/VdKyEFz68KRpnkn+GlzDFxv65oXig=
Received: by 10.216.186.70 with SMTP id v48mr3668168wem.64.1285400730561; Sat,
 25 Sep 2010 00:45:30 -0700 (PDT)
Received: by 10.216.165.15 with HTTP; Sat, 25 Sep 2010 00:45:10 -0700 (PDT)
In-Reply-To: <AANLkTik4kL8Mao1VM=njNxFSXOY7guwuEZgmpv0UTc8R@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157129>

On Fri, Sep 24, 2010 at 3:30 PM, Elijah Newren <newren@gmail.com> wrote=
:
> On Fri, Sep 24, 2010 at 4:23 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> I'm interested in using 'git diff' on some files that aren't actuall=
y
>> inside a git repo at all. =A0Specifically, the --color-words and
>> --word-diff-regex are really cool and I happen to have a use for the=
m
>> on files that aren't stored verbatim in git. =A0As a whole, git's
>> implementation of diff seems to be the fastest-moving one out there,
>> so I'd rather use it instead of another random diff implementation.
>>
> <snip>
>> Is there already a way to get 'git diff' to do this?
>>
>> If not, would it be sensible to extend git-diff to do comparison
>> between two outside files?
>
> Isn't this what git diff --no-index ... does?

Aha, that was exactly what I wanted. :)

Oddly, 'git diff file1 file2' *doesn't* work when file1 and file2 are
in a working tree; git tries to diff something, apparently, but I
don't know what.  When you're outside a working tree, it works.  And
your "--no-index" suggestion is what makes it work even when you're in
a working tree.

Thanks to you and Brandon for your help.  I guess I'll try to submit a
patch to the git-diff manpage to make this type of usage more obvious.

Have fun,

Avery
