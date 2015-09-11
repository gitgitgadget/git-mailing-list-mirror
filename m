From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: parse authors file more leniently
Date: Fri, 11 Sep 2015 10:36:55 +0200
Message-ID: <55F292A7.1030809@drmicha.warpmail.net>
References: <5613050.3arVUQYvEz@granit>
 <03f07c11135aef9e04a26e5b1018d726ba2fab5d.1441887195.git.git@drmicha.warpmail.net>
 <20150910180810.GA22112@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Till_Sch=c3=a4fer?= <till2.schaefer@tu-dortmund.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 10:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaJpY-0006m8-TD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 10:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbbIKIhA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2015 04:37:00 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37757 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170AbbIKIg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 04:36:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 658B22049C
	for <git@vger.kernel.org>; Fri, 11 Sep 2015 04:36:57 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 11 Sep 2015 04:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=vBk85gHfPwotIRyjOROQy/CwWr4=; b=P+pa0E
	mOjoidaaiRqyNWYBPtDunZFzJGPk17VxZ7OMpMF43oTcPUi6pcVbL2BKsU/AV0TA
	FN/4+hnkC5uDpz1SgaF+DQHzOmW6X/HR2Xh23Dk7+glzcx7o2w1fNfyQbTsj6OsD
	eALq6OSd5dCwa2zI4+RakHmpPvZjRU9DffCkM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=vBk85gHfPwotIRy
	jOROQy/CwWr4=; b=Hv20EM9fdfdrtbWheKTrfSv/UjdVbS1ioFTuVP77rQvi0b6
	bn+zYEe9iXNQQG0BWmtcrEQm1jucgMPVLp+QTMSAI0EHm4WDe3WnyrEWX06oK/Nc
	IpfV61/dyZF8J13y8kSO0A3oTL0EMZRHQduZQlVq6sQU2xspzEgtC/3bDSUY=
X-Sasl-enc: 279vi5e7+0lY3I///87CNEWETNT0ZieNVs3xA9HfmLYG 1441960617
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C273FC00287;
	Fri, 11 Sep 2015 04:36:56 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150910180810.GA22112@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277654>

Eric Wong venit, vidit, dixit 10.09.2015 20:08:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Instead, make git svn uses the perl regex
>>
>> /^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.*)>\s*$/
>>
>> for parsing the authors file so that the same (slightly more lenient=
)
>> regex is used in both cases.
>>
>> Reported-by: Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>=20
> Thanks.
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>=20
> And pushed to master of git://bogomips.org/git-svn
> (commit f7c6de0ea1bd5722a1181c6279676c6831b38a34)
>=20
> By the way, I also had some other patches sitting around for you.
> Did you ever have time to revisit them?  (I haven't)
>=20
>       t/lib-httpd: load mod_unixd
>       t/lib-git-svn: check same httpd module dirs as lib-httpd
>=20

Also "from me".

Short answer: No

If I remember correctly, they were correct bit not complete in the sens=
e
that on a standard Fedora install (with newer apache), svn tests still
wouldn't run over http. But I/we learned that those tests were simply
run over local file protocol instead when svn over http didn't work. On
a standard debian install (which apparantly has non-standard, thus
downwards compatible apache config) everything was fine with or without
those patches.

I still plan to look at them when I find time. (I'll be retiring
sometime between 20 and 30 years from now, so there's hope.)

Michael
