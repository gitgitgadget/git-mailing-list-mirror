From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Thu, 12 Apr 2012 00:59:38 +0300
Message-ID: <CAMP44s2EunUabZdU23e+jYnBrWtBmhZeqt9yR+wV3X9HZhd7hA@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
	<7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5Zo-0003dC-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933388Ab2DKV7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:59:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53251 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933301Ab2DKV7j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 17:59:39 -0400
Received: by eaaq12 with SMTP id q12so339784eaa.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WQdLhigQc3Y5h/GRzG19dj+pPIqYytTYNhW1TR/zLr0=;
        b=kl+zghtulapsN2goXUcbxxTafISzftBJpyAFBD4XqAip8v4pKEuz1hZELLojwgastS
         Ra8VWEM+qbyrJAYmjaDA8N0PytjJenMRtvtJk88NCz6/+8cVvJv0L35cScdjiN/jhFwb
         UGoy8xRfO9u6tJbe/Sc6Xbq2TxPw4nzL8QcfueUgr7kY1aHgq7MOERiCYHORM6z+hIAt
         cdhwKFiwtSOGbgms1WfEkglPaB1gstQ+r/eX3c5b+kO+tXutFnMip7e7cu14bOBSlJPP
         MjA2i/mNq/3JrNrlEMCqUEfiLBnOaWDXA1dQBDExMek7T9KY79aRdhIrYiFHtNnPS+5H
         keNA==
Received: by 10.213.19.207 with SMTP id c15mr39382ebb.67.1334181578180; Wed,
 11 Apr 2012 14:59:38 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Wed, 11 Apr 2012 14:59:38 -0700 (PDT)
In-Reply-To: <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195272>

On Sun, Apr 8, 2012 at 7:25 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0t/t9902-completion.sh | =C2=A0201 ++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A01 file changed, 201 insertions(+)
>> =C2=A0create mode 100755 t/t9902-completion.sh
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> new file mode 100755
>> index 0000000..7eb80dd
>> --- /dev/null
>> +++ b/t/t9902-completion.sh
>> @@ -0,0 +1,201 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2012 Felipe Contreras
>> +#
>> +
>> +if type bash >/dev/null 2>&1
>> +then
>> + =C2=A0 =C2=A0 # execute inside bash
>> + =C2=A0 =C2=A0 test -z "$BASH" && exec bash "$0" "$@"
>> +else
>> + =C2=A0 =C2=A0 echo '1..0 #SKIP skipping bash completion tests; bas=
h not available'
>> + =C2=A0 =C2=A0 exit 0
>> +fi
>
> What shell do you use on your system as /bin/sh (or if you use SHELL_=
PATH
> in the Makefile to override it, what do you use)?

/bin/sh is a symlink to bash on my system, and although bash defines
POSIXLY_CORRECT, the tests pass just fine. I even tried to run /bin/sh
--posix.

--=20
=46elipe Contreras
