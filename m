From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH 1/3] t3034: add rename threshold tests
Date: Tue, 23 Feb 2016 22:15:35 -0300
Message-ID: <CALMa68oN-d1t67QZ8+7KetApbLgFXoZkJV93-QOeviT_JVPGdw@mail.gmail.com>
References: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
	<1456271292-4652-2-git-send-email-felipegassis@gmail.com>
	<CAPig+cQ+MF7Nsvp7jASXPtPjNWT_g865ot45Y1Q347Y1iCDeYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 02:15:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYO3I-0000Ec-QR
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 02:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbcBXBPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 20:15:37 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35579 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbcBXBPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 20:15:36 -0500
Received: by mail-io0-f176.google.com with SMTP id g203so11837421iof.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5OCTYNjoUO5TcYJ/rJ0kHnIUHDVHRLw9UWh8KQLgCXQ=;
        b=0PLqzDlHaVQM0bq1glXbHCK6DEhOU0cuXieYX+2xPEkhPHp4wtwJ27mE8h9kaLHknZ
         MTTbnkP+5nP47FoDKNKGqsOsyDmX447iVM6UN3OWtlsfraBUQKh74NZDTX0Rdhvj0/ni
         Tk6JKx5W+dc70v2p/usgNr2ktRmMd1JyUIucvAgtq2oUu+I56DdEWxEIvjbNX+27CsOM
         VX9Z2jOhy4tpGjMGnudaxc7lRF0/515hLD5WC7dWobhGP2fwvTWKIw5rj9NSEXobNj8l
         /NIAN7q98rnGxLNhl+Nri7FOtQXK0NaMG0gcbHq8XcsuJjBMU6GLghbNX/9PFk2HBjC6
         Q42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5OCTYNjoUO5TcYJ/rJ0kHnIUHDVHRLw9UWh8KQLgCXQ=;
        b=k0G9mD7WkS4v4chkrqN9Z+uCuU4dy/rxomW5H0c72mprtk5NxsOM7qPr4NqhA0fI3w
         ESTWJavXyGuLiJvus/F/bHSoOeFi0xJQybx9BVOvdNr6rWmqc2LChj+0zQsqQTrzWzuC
         33v75MYI11zTNUF+djcawNhn0lgz5REK0rtTOkyK2JUsisBW9iT8Qt7upBrZS/sMaX/w
         kXKSaw5UwCce0t/pW2/sTaidPujmS+h8Nss4gKvAtqrBmoGaiSoQOxvpbw/u+RpfJJZU
         Kq71FwjlM8NufCVXyG3oCacIWiWAfpwQiZLo5Fxz98KpdAJTS2KzUQCc5un+tqX/y01G
         WRwA==
X-Gm-Message-State: AG10YOSsX0qWHU6NbzarKT3K/Cs/ftOMQjTsQUBNRFXnpvcRyADkZ1GMuqVYNrCZmlLJIKwn4aTChPRKlD8h7w==
X-Received: by 10.50.43.133 with SMTP id w5mr17906720igl.47.1456276536039;
 Tue, 23 Feb 2016 17:15:36 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Tue, 23 Feb 2016 17:15:35 -0800 (PST)
In-Reply-To: <CAPig+cQ+MF7Nsvp7jASXPtPjNWT_g865ot45Y1Q347Y1iCDeYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287153>

On 23 February 2016 at 21:50, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> On Tue, Feb 23, 2016 at 6:48 PM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> 10ae752 (merge-recursive: option to specify rename threshold,
>> 2010-09-27) introduced this feature but did not include any tests.
>>
>> The tests use the new option --find-renames, which replaces the then
>> introduced and now deprecated option --rename-threshold.
>>
>> Also update name and description of t3032 for consistency:
>> "merge-recursive options" -> "merge-recursive space options"
>
> A few superficial comments below...
>
>> +       cat <<-\EOF >3-old &&
>> +       33a
>> +       33b
>> +       33c
>> +       33d
>> +       EOF
>> +       sed s/33/22/ <3-old >2-old &&
>> +       sed s/33/11/ <3-old >1-old &&
>> +       sed s/33/00/ <3-old >0-old &&
>> +       git add [0-3]-old &&
>> +       git commit -m base &&
>> +       git rm [0-3]-old &&
>> +       git commit -m delete &&
>> +       git checkout -b rename HEAD^ &&
>> +       cp 3-old 3-new &&
>> +       sed 1,1s/./x/ <2-old >2-new &&
>> +       sed 1,2s/./x/ <1-old >1-new &&
>> +       sed 1,3s/./x/ <0-old >0-new &&
>> +       git add [0-3]-new &&
>> +       git rm [0-3]-old &&
>> +       git commit -m rename &&
>> +       get_expected_stages 0 &&
>> +       get_expected_stages 1 &&
>> +       get_expected_stages 2 &&
>> +       get_expected_stages 3 &&
>> +       check_50=3D"false" &&
>
> Why isn't this assignment done in setup 2/2 where all the other
> assignments to 'check_50' are done?
>

Oh, it might be a minor thing, but I would like to make tests using
check_50 fail if setup 2/2 is skipped, instead of succeeding without
any actual checks.

>> +       th0=3D$(sed -n "s/R\(...\)        0-old   0-new/\1/p" <diff-=
output) &&
>> +       th1=3D$(sed -n "s/R\(...\)        1-old   1-new/\1/p" <diff-=
output) &&
>> +       th2=3D$(sed -n "s/R\(...\)        2-old   2-new/\1/p" <diff-=
output) &&
>> +       th3=3D$(sed -n "s/R\(...\)        3-old   3-new/\1/p" <diff-=
output) &&
>> +       test "$th0" -lt "$th1" &&
>> +       test "$th1" -lt "$th2" &&
>> +       test "$th2" -lt "$th3" &&
>> +       test "$th3" =3D 100 &&
>
> It's very slightly odd to see '=3D' rather than '-eq' among all these
> other algebraic operators ('-lt', '-le'), but not so odd that I'd
> mention it (unless I just did), and not necessarily worth changing.
>

Here I favoured the stricter test. If the string is not exactly "100",
then a lot should be reviewed.

Once more, thanks for the review. Your other comments should be
included in the next version of the patches.
