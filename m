From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 09:59:32 +0200
Message-ID: <14146E1E-857D-416B-9287-F20826DCB806@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <561CDDBA.609@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: =?windows-1252?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdRs-0001fV-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 09:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbbJOH7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2015 03:59:36 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34029 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbJOH7g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Oct 2015 03:59:36 -0400
Received: by wicgb1 with SMTP id gb1so16269564wic.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 00:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=99UJTfSU89aIvTHriWUdEtYHZjU/AbVKtUZv/OdWG00=;
        b=ne0dRHGvITrm0wy+RpfkkldXZWlccU41Q5KwF3CHWUsEaZ0+soCfcYaqIE+uHkTo1j
         7ZfV4d3zn7gp+AEY3FHJ11szOSfeOa4ZbsTNng2K4ZEo4g/z/vGl380BsdDpSODXMj9V
         e4yJX+BofUIzKw5w3uiep7FW7ON/P0r3T65l7JYZpCLDj+dGT73xfx8iYVIuSu+qVZsr
         mI7WmhqV8McAs2UlM9E7/ja+Z3OFQUPRVaGnCgUI8Vk12MFqIovOuo5tO2BXVt2YLgOT
         d/EVjiw0u0T40IAyzLbh9eBjTL02EJviWuP7/k/WAZaC87h7xtPAnEJeKiusfuX/zfjA
         WctQ==
X-Received: by 10.180.149.167 with SMTP id ub7mr33351846wib.43.1444895974509;
        Thu, 15 Oct 2015 00:59:34 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5503.dip0.t-ipconnect.de. [93.219.85.3])
        by smtp.gmail.com with ESMTPSA id lf10sm14842424wjb.23.2015.10.15.00.59.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 00:59:33 -0700 (PDT)
In-Reply-To: <561CDDBA.609@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279650>


On 13 Oct 2015, at 12:32, Jean-No=EBl Avila <avila.jn@gmail.com> wrote:

> Le 11/10/2015 19:55, larsxschneider@gmail.com a =E9crit :
>> +
>> +before_script: make
>> +
>> +script: make --quiet test
>=20
> Travis can be used in container mode but that would need getting rid =
of
> "sudo" command and only installing from white-listed sources
> (https://github.com/travis-ci/apt-source-whitelist/blob/master/ubuntu=
=2Ejson)
>=20
> Anyway, even within the present VM mode, 1.5 cores are available, so =
it
> makes sense to add "-j2" to every make commands.
>=20
I was reluctant to this because I feared problems. Especially while run=
ning tests in parallel. However, the result looks quite good.

make -j2 9min 11sec:
https://travis-ci.org/larsxschneider/git/jobs/85478022

make 17min 20sec:
https://travis-ci.org/larsxschneider/git/jobs/85432398

If there is no argument against running test in parallel then I will ad=
d it to the next roll.

Thanks,
Lars