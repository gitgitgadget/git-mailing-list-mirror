From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RGC/PATCHv2] grep: submodule support
Date: Sat, 16 Oct 2010 19:13:27 -0700
Message-ID: <4CBA5BC7.9090707@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com> <4CB9CAD3.7060109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 17 04:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7IkH-00083m-8P
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 04:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab0JQCNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 22:13:01 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59262 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab0JQCNA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 22:13:00 -0400
Received: by pxi16 with SMTP id 16so296728pxi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 19:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dArktI+naP0i/coWvkilYTs+CXushVbn/+NjzOliNtU=;
        b=E/pX9WWekq1A+gCrBVdNgvo3MhvxPm7w+KPYTiuvMjSdCXltL3rA/ZWwdCQ2HtbmrO
         km017s/VQBgSeCMDRUqac0ZOJtsZOdL6rE6M2JrDoeToIohm6hoR46urusAf6OOR+2GU
         x5t7LmNCCl2rthCl54Q05yrpTbIWIWUpehMKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=mcOv4JObHgLtmiaGjKgGe0Pxhy2JNd8gp3PeLRjGktqW1s25zE6mzlykROXOyvKwU8
         eB9PEGnsKciy3DmZ4SYr2ACJuTu/xPfrKMTvECZ8qdAOgrxEfeiuxgEMfTbgXIZfKgUy
         fraBJPchh8w/7KenW86UpcIYduS8wx2Z0WGX8=
Received: by 10.142.131.17 with SMTP id e17mr620794wfd.320.1287281580107;
        Sat, 16 Oct 2010 19:13:00 -0700 (PDT)
Received: from laptop.site (adsl-71-131-194-2.dsl.sntc01.pacbell.net [71.131.194.2])
        by mx.google.com with ESMTPS id v19sm17687177wfh.0.2010.10.16.19.12.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 19:12:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <4CB9CAD3.7060109@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159186>

On 16/10/10 08:54, Jens Lehmann wrote:
> Am 16.10.2010 01:26, schrieb Chris Packham:
>> Here is my updated grep support for submodules series.
>=20
> Thanks Chris and Duy, I added this series to my git-submod-enhancemen=
ts
> repo on github and will give it some testing next week.
>=20
>> Chris Packham (4):
>>       grep: output the path from cwd to worktree
>>       grep_cache: check pathspec first
>>       add test for git grep --recursive
>=20
> Hmm, is it useful to add tests before adding the feature tested? I
> thought it makes more sense to add them in the same commit or after
> adding what is tested (e.g. to reduce the noise when bisecting
> later). Or am I missing something here?

That's just reflects my personal preference to write the tests first
(influenced by a former colleague who was keen on extreme
programming/test driven development). Eventually these can be swapped o=
r
squashed as needed, for now it's probably easier to review them separat=
ely.

>=20
> (And by the way: the test script should be executable)

OK will fix.

>=20
>>       grep: add support for grepping in submodules
>=20
> Nit: The commit message (5/5) talks about the old option name
> "--recurse-submodules" instead of the "--recursive" the patch
> is adding.

Yeah I just noticed that. I'll update the commit message.

>=20
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
>>       worktree: provide better prefix to go back to original cwd
