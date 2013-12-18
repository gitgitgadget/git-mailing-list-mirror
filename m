From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 01:02:04 +0100
Message-ID: <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com> <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com> <20131217210255.GA18217@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 01:02:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt4bC-0006yN-AN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 01:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab3LRACq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 19:02:46 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:39617 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab3LRACp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 19:02:45 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so6785251wes.41
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 16:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ChX+7AF91BrYPvZfXRgaK86UrDkzPIZJlwnOw21n8ew=;
        b=uzseBdui2wjo+O7vYBJrmJqvJ6VdDmWWalFUBvQEZt7tAsPDn/8HryUwyqyGn4FDDw
         eKqiGbA7c2oOsW2GfTodNfdYrHxOf068xI/CNRCptbQIiZAWidDdvGPAJK89RIxW8TZF
         wdFeaROQwKXM7HZcOZTioFX30x+RWPFVTfUljvGbjty9eCcUPLTRf+UuEUgKpa7Uk39u
         x+Qz+8jsu4bdZ3EQHfmhxSgmJG/HdTsebZ0uiJcJNVQsCGZd+WfuQZCTe2hUV8tUXzYk
         qSMast/jievFYcjZTsRrnxgGjelQV0PqKt1suEKiV+MICvlQkwyFsvPKobjirhWo9f2r
         OWHw==
X-Received: by 10.180.198.43 with SMTP id iz11mr5825947wic.0.1387324964949;
 Tue, 17 Dec 2013 16:02:44 -0800 (PST)
Received: by 10.227.86.201 with HTTP; Tue, 17 Dec 2013 16:02:04 -0800 (PST)
In-Reply-To: <20131217210255.GA18217@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239414>

On Tue, Dec 17, 2013 at 10:02 PM, Eric S. Raymond <esr@thyrsus.com> wro=
te:
> Jakub Nar=C4=99bski <jnareb@gmail.com>:
>>
>> Errr... doesn't cvs-fast-export support --export-marks=3D<file> to s=
ave
>> progress and --import-marks=3D<file> to continue incremental import?
>
> No, cvs-fast-export does not have --export-marks. It doesn't generate=
 the
> SHA1s that would require. Even if it did, it's not clear how that wou=
ld help.

I was thinking about how the following part of git-fast-export
`--import-marks=3D<file>`

  Any commits that have already been marked will not be exported again.
  If the backend uses a similar --import-marks file, this allows for in=
cremental
  bidirectional exporting of the repository by keeping the marks the sa=
me
  across runs.

How cvs-fast-export know where to start exporting from in incremental m=
ode?

BTW. does cvs-fast-export support incremental *output*, or does it
perform also incremental *work*?

Anyway, that might mean that generic fast-import stream based increment=
al
(i.e. supporting proper thin fetch) remote helper is out of question, p=
erhaps
writing one for cvs / cvs-fe would bring incremental import from CVS to
git?

--=20
Jakub Narebski
