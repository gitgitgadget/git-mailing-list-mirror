From: "Chen WANG" <ellre923@gmail.com>
Subject: RE: pretty format can't work on cron job
Date: Mon, 8 Nov 2010 10:30:19 +0800
Message-ID: <020101cb7eec$e5d1baa0$b1752fe0$@com>
References: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org> <20101105131444.GB11707@sigill.intra.peff.net> <01c101cb7d6c$fd053cf0$f70fb6d0$@com> <201011072018.31740.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'Jeff King'" <peff@peff.net>,
	"Chen Wang \(QA-CN\)" <chen_wang@trendmicro.com.cn>,
	<j.sixt@viscovery.net>, <git@vger.kernel.org>
To: "'Thomas Rast'" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Nov 08 03:31:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFHWI-00071Y-2R
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 03:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0KHCa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 21:30:28 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34402 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab0KHCa2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 21:30:28 -0500
Received: by pzk28 with SMTP id 28so760260pzk.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references
         :in-reply-to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding:x-mailer:thread-index:content-language;
        bh=vU9Z+tBGFcBQrY3yq9tK3SwC7BQNWpywMs8uCfbkmsM=;
        b=Bl8icm0B7hX8UlEfUOjpLU5BIKxgOOaYEVwrU7ZjReFORNw+jN8xF84rmeVdgj8t60
         9BCgeotjpRMy40BcXFfAilXodPI/D+Bdf2rMffzLDFLlqpg0Nnld/V4fDeJUZha4mKcp
         eqxu7BeWY5WPjWvSIWwbvbBU7xKDOoXhAkVCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer
         :thread-index:content-language;
        b=Fg2+1wnRvcMxRYUoWH3xDSy7JbfqGxvCYQfQ+dpIaUCyU4SIaxbkYy0ebNZ6QDvdAs
         URUbOM1NLyOvbiH8Jj+HkViDn/etPwqrmQJOZm7LJBbHBe5ZTVbrEEa0xAcdmLHXee9r
         cGi50DthRcCejF8Dcta6nNsPOQRBbaqxWu/yg=
Received: by 10.142.147.13 with SMTP id u13mr3754458wfd.417.1289183425976;
        Sun, 07 Nov 2010 18:30:25 -0800 (PST)
Received: from njchenwang ([218.104.127.130])
        by mx.google.com with ESMTPS id x18sm7365721wfa.23.2010.11.07.18.30.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 18:30:24 -0800 (PST)
In-Reply-To: <201011072018.31740.trast@student.ethz.ch>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Act+sJNAlgo+TH8qQ5Cf73RyngptMQAO3ZZg
Content-Language: zh-cn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160907>

> -----Original Message-----
> From: Thomas Rast [mailto:trast@student.ethz.ch]
> Sent: 2010=C4=EA11=D4=C28=C8=D5 3:19
> To: Chen WANG
> Cc: 'Jeff King'; Chen Wang (QA-CN); j.sixt@viscovery.net; git@vger.ke=
rnel.
org
> Subject: Re: pretty format can't work on cron job
>=20
> Chen WANG wrote:
> > $ cat /home/wangchen/kps_update
> > #!/bin/bash
> > su wangchen -
>=20
> What is this 'su' supposed to do?  AFAICS you would have to run
> another script with 'su' if you really want to change user.
>=20

Ignore it please. I put a lot rubbish here to try to figure out the iss=
ue.

> > git log 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2.. -M --date=3Dshor=
t
> --pretty=3Dformat:"Author: %aN <%ae>; Date: %ad" --shortstat --dirsta=
t
> --no-merges >/tmp/ChangeLog-all
> [%aN does not expand to anything within the cron runs]
>=20
> Also, what git version(s) do you have installed?  %aN appeared in
> 1.5.6.4 and 1.6.0, so it is entirely possible that the $PATH within
> your cronjob runs an older version which fails to expand it to
> anything.
>=20

Absolutely right.
I was keeping figure out the difference between manual run and cron job=
 for
git.
But seems my administrator installed a 1.5.5.4 for global, but my local=
 bin
has a higher version of git which support %aN.
Thanks guys. Thanks Thomas.

> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
