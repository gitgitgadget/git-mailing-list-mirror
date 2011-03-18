From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: PATH_MAX (Re: [PATCH] system_path: use a static buffer)
Date: Fri, 18 Mar 2011 18:54:00 +0700
Message-ID: <AANLkTimW9TofyEqZUQwkAkVqA_Sr5kgV_rm6dJ6LTVbb@mail.gmail.com>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
 <1300371853-8965-1-git-send-email-cmn@elego.de> <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
 <20110318113818.GA6049@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 12:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0YGT-0007Ro-HC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 12:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1CRLyc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 07:54:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37632 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1CRLyb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 07:54:31 -0400
Received: by gwaa18 with SMTP id a18so1521388gwa.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=D3gKUXJ1XhwzC16wyH7xhupYOoyW4hmUAfn0/Qdi0a4=;
        b=dIGIJJFht1Hzb2FCCdhb+9rb2eRbo9OhucY3Gphu8Mmsi1JkcOAuMINGxrPsjBlu4O
         os06xTbJ465DXxKSYSv1sRh5P0wyX2TShm/SCPvvTRqQ1QHq8gFIk1lZrrL/Rtygf/Pl
         wYiu80I6TbXBaznAxo1WUIwfU9AChGZZIfMX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c/Sv9RR2Pqa+yiYOwxJkmYU2pgE3X8kDjsiVb74ihZD6+4b38GAqOp247ysy8JKJGl
         l6hrRbnrRDdRuOdjLjO5bk51uZ2FsOOeWeVl5JtBRdo6KvP1gyXtX9hqftaCloJZ0ls0
         asNpGDHPIK1BJ7+2FJp4dkwHfXJWfE2cY4KRI=
Received: by 10.151.16.4 with SMTP id t4mr1167949ybi.103.1300449270123; Fri,
 18 Mar 2011 04:54:30 -0700 (PDT)
Received: by 10.150.220.14 with HTTP; Fri, 18 Mar 2011 04:54:00 -0700 (PDT)
In-Reply-To: <20110318113818.GA6049@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169313>

On Fri, Mar 18, 2011 at 6:38 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Nguyen Thai Ngoc Duy wrote:
>
>> It was pointed out elsewhere [1] that PATH_MAX only specifies max
>> length of a path element, not full path. I think we'd need to stay
>> away from preallocated PATH_MAX-sized arrays.
>
> No, PATH_MAX is actually the maximum length of a path, and when you
> use, say, open(2), it will fail if your path is longer than that. =C2=
=A0The
> maximum length of a path component on most filesytems is 255 or 256;
> PATH_MAX on Linux is 4096.

Hmm.. too late I sent two patches before reading this :) Cloning
linux-2.6.git for verifying. But getcwd() can return a path longer
than PATH_MAX, right?
--=20
Duy
