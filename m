From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/1] git-gui: fix hunk parsing for corner case changes
Date: Sat, 14 Jan 2012 06:25:28 +0100
Message-ID: <CAKPyHN3dp_t+hVsX_dBB8OnU=oM2t1DsdKFDghD7L9qAEtYgfg@mail.gmail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 14 06:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlw7T-0008JU-5d
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 06:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab2ANFZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 00:25:30 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44956 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab2ANFZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2012 00:25:29 -0500
Received: by wibhm14 with SMTP id hm14so866436wib.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 21:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lQTjOLhaVH7LFrJy291faOEh6Q4fz7IpJwfrumafIWw=;
        b=WUX2WtttaMgSgI3V+cc31pe9uOIRXa96fq0nGNW6SW7ZEhqXJ2NCb8P2eOQNRGzxl3
         BBhSytGMKEB4+KGcZkIv3I15+m6f7HZz8VaPwQMXS+KbODHbWMfs9z525+wi048/jG9E
         r3QXjBv1VvvcGHV7xhVX2DJZe/AGFHGiKUw6I=
Received: by 10.180.93.168 with SMTP id cv8mr1340500wib.2.1326518728105; Fri,
 13 Jan 2012 21:25:28 -0800 (PST)
Received: by 10.223.118.10 with HTTP; Fri, 13 Jan 2012 21:25:28 -0800 (PST)
In-Reply-To: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188548>

Hi Pat,

On Mon, Jan 9, 2012 at 14:43, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> The simple hunk parsing code did not recognize hunks when there is no
> second number after the comma. Like in these cases:
>
> =C2=A0@@ -1 +0,0 @@
> =C2=A0-1
>
> Which resulted in this hunk header:
>
> =C2=A0@@ -1 +0,1 +1 +0,0 @@
>
> Or:
>
> =C2=A0@@ -1 +1 @@
> =C2=A0-1
> =C2=A0+2
>
> Resulted in:
>
> =C2=A0@@ -1 +1 @@
> =C2=A0,1 +1 +1 @@
> =C2=A0,0 @@
>
> While trying to stage only the '-1' line.
>

could you please consider pushing this into the 1.7.9 release. I see
no point in waiting for the next release.

Thanks.

Bert
