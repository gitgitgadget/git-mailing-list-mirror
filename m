From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 1 Sep 2015 17:02:45 +0200
Message-ID: <3942C6D1-A758-4F50-9865-9D83C5CD9128@gmail.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com> <1441059026-66814-2-git-send-email-larsxschneider@gmail.com> <55E52BA7.6020303@web.de> <6BD3F017-37E4-4677-BCCE-D84E7031B780@gmail.com> <55E5B798.40108@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, gitster@pobox.com
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 17:02:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWn5J-00081a-W2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 17:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbbIAPCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 11:02:49 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37889 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbbIAPCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 11:02:48 -0400
Received: by wiclp12 with SMTP id lp12so34051130wic.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ybvBNKjif510qcWbGVNQT6GK2B+kTE5LQEuhLyJFnbM=;
        b=e791hgw1FtRXXecD8UqoYUVEMa0VJUbRaZZLE0s0CXsprnhJ+tFgEiPKax3guR3A4C
         Iyza6G6HzuH5wIk/CrnVVbtAipfoL9MXYzyWb209lLVdIt8nciWZQsLg5Ln3ZJ8F3Zau
         Feeq3TMaXrnAYiD/aHvyJpuAj7N3t7OYJZIDUxoaiTs+tPnpB7n9VPI3zqE7G2vHGqMp
         yyy6ddMXXZ6Yub30JyQ6CdiwxPE4KSTZ5pt9BpCFl2/iR1LPalLgEcq10mtDYSoSlMdA
         FZMwWCZVPzqc6OF4qNokkrDSgENnr+BURgDlY0AQAG4F4jZw7HZdSl/P8desmZdBhZF+
         ogjw==
X-Received: by 10.194.94.73 with SMTP id da9mr35395489wjb.97.1441119767648;
        Tue, 01 Sep 2015 08:02:47 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l17sm12649833wjr.18.2015.09.01.08.02.46
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 08:02:46 -0700 (PDT)
In-Reply-To: <55E5B798.40108@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276982>


On 01 Sep 2015, at 16:35, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 2015-09-01 14.47, Lars Schneider wrote:
>>>> +test_expect_success 'Create a repo containing iso8859-1 encoded p=
aths' '
>>>>>> +	cd "$cli" &&
>>>>>> +
>>>>>> +	ISO8859=3D"$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso885=
9-1)" &&
>>>>>> +	>"$ISO8859" &&
>>>>>> +	p4 add "$ISO8859" &&
>>>>>> +	p4 submit -d "test commit"
>>>>>> +'
>>>> Sorry for being persistant,
>>>> but you can't create files with names that  are ISO-8859-1 encoded=
 under Mac OS,
>>>> we end up like this:
>>>>=20
>>>> a-%E4_o-%F6_u-%FC.txt
>> You are right. However, my goal is not to create a file with ISO-885=
9-1 characters in Mac OS. My goal is to create this file in Perforce an=
d this approach seems to work.
>>=20
>>>>=20
> But this line creates a file, doesn't it ?
>> "$ISO8859" &&
>=20
> (I just wonder how this works on you machine )
I tested it on OS X (HPFS) and Linux (ext4). Can you reproduce problems=
 on your machine? If yes, what is your OS/filesystem?

> And, may be, we could fill the file with some content, to be double-s=
ure that
> the file name conversion works with Perforce ?
>=20
> like
> echo content >"$ISO8859" &&
>=20
> and test the content later ?
OK, I will add this.

Thanks,
Lars
