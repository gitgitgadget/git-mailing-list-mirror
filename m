From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: Re: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 13:48:13 +0200
Message-ID: <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com>
References: <200804161334.17748.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 13:49:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm68M-0006NU-8e
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 13:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbYDPLsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 07:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbYDPLsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 07:48:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:46912 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155AbYDPLsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 07:48:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1790119wxd.4
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=//NTsYGwGfaKlTuws63M+aBv+PYEvbw93QxJH61XcTQ=;
        b=H3taA6ke33bwHcpzsUnXy44nuOYaJf2KkqisifdGOnP5nvQTzp1fZrIdqQ4IEBo7HX4kR/6p2GErqBTwn0SqjkeNpY5N44MsjbGmp0Z/VI3+DR3cxAC1WGi8jBBVH/+BGeuTUm7soi4jXpQIZ94leATque1AJfZBliJzrzieWiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bAWEBGqN1toBv7pMm6hvgZJIKclp/lQRtODio36Q1NuHjZ402taczQ2DwZo8bRCDvT73Dv0MGkxHEI7+7P2iI/sZ5JUpj3dqG5rv40qi8EwCKkdCzm6w5WmBt045MkAlfF0z5v95CePTCsIJ+RWwV0dVFxIC3ojLz5RmXT8iqNk=
Received: by 10.140.203.9 with SMTP id a9mr5124417rvg.203.1208346493988;
        Wed, 16 Apr 2008 04:48:13 -0700 (PDT)
Received: by 10.141.123.21 with HTTP; Wed, 16 Apr 2008 04:48:13 -0700 (PDT)
In-Reply-To: <200804161334.17748.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: 3e0ad7118fe1d30e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79693>

Dmitry Potapov <dpotapov@gmail.com> correctly deduced:
>  On Wed, Apr 16, 2008 at 11:45:39AM +0200, Brian Foster wrote:
>  >  Brian Foster <brian.foster@innova-card.com> writes:
>  >  >  I've recently inherited a bare git repository,
>  >  >  which, as far as I can tell (I'm something of a
>  >  >  newbie with git), seems Ok [ but clones are not ].
>
>  I suspect your original git repository has info/grafts

hi Dmitry,

 bingo!  YES, it does:

	$ cat info/grafts
	8700854c41a40d333e90104971c3abbbcf082e57
34757f56bd7cb007bbb48ce064a2cd7e67c32428
	c87c46fe892211f8aa4fd363ccff4f667a9aaf7d
d560b7a27640cdf9ff1e6a30ae161dc6144618bd
	dd3f3c0636cfd50719c706b030db5473b0270add
e6cfa744e0434f9b700cd8a3780dcf9235ed10e3
	e5a60f1636cceac33777bb8098a0b7a4a136a56c
b38536a9a67b8d6b94e51860195529481703286b
	0ff75b3afff6fb306bef221bf1823ccf5ffc568b
01d4f94e5e5e65058234256241c01a6caf1c5feb
	fb5967688f7b464421cff28f266b64ad2a313a9e
00fe1cce8a053ecf9d8ba160991f28574fb11f63
	2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
	$

 now, showing that I am indeed essentially a git newbie,
 WTF is a "graft"?  I don't recall running into the term.
 I shall, of course, immediately start trying to find some
 info blah blah ..., but pointers/explanations would help.

 the goal is to put things into a sane state so any new
 clones are healthy.  there's only one(?) existing clone,
 which may or may not be(? become?) an issue.

cheers!
	-blf-
-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
