From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Tue, 6 Apr 2010 08:42:10 +0000
Message-ID: <h2h51dd1af81004060142p25194aaai58492f617419d0f8@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
	 <1270392557-26538-1-git-send-email-avarab@gmail.com>
	 <20100404224324.GB12655@gmail.com>
	 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
	 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
	 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
	 <20100405055139.GA28730@coredump.intra.peff.net>
	 <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
	 <20100405175822.GA32083@progeny.tock>
	 <20100406055530.GE3901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 06 10:42:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4MU-0006zT-DM
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 10:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab0DFImO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 04:42:14 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:42215 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab0DFImM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 04:42:12 -0400
Received: by bwz1 with SMTP id 1so3384724bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bPjEvHi/nfeqy1DqqykcsOJiv1vEXTduMRCNFHfNob8=;
        b=LpMGn8Cza9uaWqbDmd0ztHjsuQ8S0Av35xeiuG5kTwXapcV35drzjWl3Mzkmcnydeu
         Sl99Gx7hmSpc2G4DdRY2a81jx2buwiMfaVhjhzypByXX38EHr806XbGs0ZsgUXnoZo0/
         S8tgQbjam3S+GAEeWxTO7UMZDebYr9wbxGOfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tFrCNbz2MX3yaEG/Zt7nxOpB72Hopgy6lwjL+MMOnWGemhOWd2M1afjaMaZtGGV70M
         zFpNr0d2UIZdaiOZR1po9YhwhOiHkrNNVx1K4Xrh8PPh7I8ggDuu6TUqhsYJY/8oyDsk
         PZPPo7MuB/67TtnlTJJlWnBDHJUBRU5QDzH3I=
Received: by 10.204.121.195 with HTTP; Tue, 6 Apr 2010 01:42:10 -0700 (PDT)
In-Reply-To: <20100406055530.GE3901@coredump.intra.peff.net>
Received: by 10.204.7.220 with SMTP id e28mr5210904bke.33.1270543330570; Tue, 
	06 Apr 2010 01:42:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144116>

On Tue, Apr 6, 2010 at 05:55, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 05, 2010 at 12:58:22PM -0500, Jonathan Nieder wrote:
>
>> > There's probably a lot of code out there doing `git commit -m"Yet
>> > another revision"' from some cron job.
>>
>> FWIW, I have no strong opinion about whether to add this --allow-emp=
ty-message
>> option. =C2=A0Maybe it would make something more convenient for some=
one,
>> though that has to be weighed against it making it harder for everyo=
ne
>> else to read the manual.
>
> I meant to mention this in my other response: I would prefer if such =
an
> option doesn't clutter up the usage message. --allow-empty is already
> there, and probably doesn't need to be. "git commit -h 2>&1 | wc -l"
> shows a whopping 39 lines, which IMHO is too many for a short usage
> summary. I mean, "--no-post-rewrite", is that really one of the top-u=
sed
> options?

I just put it there because --allow-empty was there and I thought the
SYNOPSIS might be going for a complete listing. I completely agree
though, the option shouldn't be in the SYNOPSIS, and neither should
--allow-empty be. They're both analogous to obscure options like
--porcelain (which isn't listed).

I've just submitted a new patch to rectify this. I can send another
one to remove --allow-empty from the SYNOPSIS.
