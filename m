From: MrUnleaded <mrunleaded@gmail.com>
Subject: Re: git svn import fails.
Date: Wed, 15 Jul 2009 08:21:04 -0700
Message-ID: <fe66c02a0907150821s5ca095e0jbe9578b4310c615c@mail.gmail.com>
References: <fe66c02a0907131343m5c05af68n88a749c08d3dc70a@mail.gmail.com>
	 <fe66c02a0907131349p708e4a16hde3cd9b9c7a7a9a3@mail.gmail.com>
	 <20090715070444.GA22882@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 15 17:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR6IY-0006Bd-Jg
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 17:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbZGOPVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbZGOPVH
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 11:21:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:63910 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbZGOPVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 11:21:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so651679qwh.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=On4sODm31xZ5JKzO+zlfe+95uPpLIT4pfTHn7VPF8lw=;
        b=pMdLFZ4EdN/NspOe8kXWCChUIdLuZ4ILi+9jTUVhqNQz2xSla04uoZJTW52umcy/qP
         cW89fFR98tcbHCbJT6crFBifKAdIjEs9W6agTrB9AyiiXp5ItAV5yw95nJHKT/ocb2TK
         vOri982U3XEp2p2PLwEslBVy471y7oS3oyNMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H6XvmsdRc9oWWv9xzqOi7ryIh/bYia7X6XaCfTEwP2Lk/MF0rl9zSdKurmKt1h2d8j
         KYXI0LrEagNvlxCaiwOFHrzUldL6BJkNGTl/UHjqLlOFvxdaF4xB2RUWHO0idrXv95JN
         XUeRmn1qFVGKo67d8DEHnkhjGFTGmEqcn/zBY=
Received: by 10.229.95.65 with SMTP id c1mr1473452qcn.50.1247671264266; Wed, 
	15 Jul 2009 08:21:04 -0700 (PDT)
In-Reply-To: <20090715070444.GA22882@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123321>

Hello Eric,

I have been able to use TortoiseSVN 1.5.9, Build 15518 - 32 Bit,
Subversion 1.5.6,  on windows.

I have used svn 1.5.5 on OSX both are able to co the full repo but it
is a bit slow.

When I use git svn clone/rebase downloading commits initially got
stuck at some revision(not sure which) but then after a few days of
retrying, it continued a bit more to get stuck again at revision
44746.

I tried looking at git svn's code but it looks like it is actually
failing in the subversion perl module(i think).

Anyways any suggestions you might have would be appreciated.

Thanks.

Kevin

On Wed, Jul 15, 2009 at 12:04 AM, Eric Wong<normalperson@yhbt.net> wrot=
e:
> MrUnleaded <mrunleaded@gmail.com> wrote:
>> Hello, I have been attempting to import a public repo but it seems t=
o
>> fail predictably at the same revision with the following error:
>>
>> RA layer request failed: REPORT request failed on
>> '/svn/!svn/vcc/default': REPORT of '/svn/!svn/vcc/default': 200 OK
>> (https://mosa.svn.codeplex.com) at /usr/local/libexec/git-core/git-s=
vn
>> line 4505
>>
>> I have tried the following:
>> git svn clone https://mosa.svn.codeplex.com/svn/trunk
>>
>> git svn clone -s https://mosa.svn.codeplex.com/svn
>>
>> I have also tried git svn rebase once it fails on the clone.
>>
>> Each time it fails on the same revision.
>>
>> If anyone has any suggestions I would appreciate it.
>>
>> Thanks.
>
> Hi,
>
> This is the weirdest/slowest(?) SVN server I've ever connected to.
> svn ls https://mosa.svn.codeplex.com/svn just seems to stall
> trying to read something at the end, likewise with "svn co" and
> "svn log".
>
> It seems like the server side isn't able to terminate connections
> correctly and the SVN client itself is relying on that.
>
>
> How many revisions did you managed to fetch before it failed?
>
> Do other SVN clients work with this? =A0If so which client and versio=
n are
> you able to use with it? =A0If I can't get the stock `svn' isn't work=
ing
> right, then I doubt there's much I can do with git svn on this repo..=
=2E
>
> --
> Eric Wong
>



--=20
Kevin
