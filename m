From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/17] revert: Don't check lone argument in get_encoding
Date: Wed, 13 Jul 2011 11:44:09 +0530
Message-ID: <CALkWK0mWFvDFdOhQuZK-E-_78YGdXve42NX=Zj6S4BTDu+pTzA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-4-git-send-email-artagnon@gmail.com> <20110712165949.GB13578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 08:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgskB-0006ss-56
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928Ab1GMGOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 02:14:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34048 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897Ab1GMGOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 02:14:30 -0400
Received: by wyg8 with SMTP id 8so291311wyg.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i/djQr22bGjotlGfF1a4jEMkCsM2FRBWSd1iRxteFN4=;
        b=FsyB7XPSAOYUrl836kqB9Gr3jx6WQ+1A+FiifrzZH9FzVq1SAb4MvrjqdR5LiXW7Lu
         2si4lz5bcKJgHkBgtZYw0nUfvDW+q5NlmHH3is89O4dBi9DE5sDi8nJH8KD5XpfvBYtN
         7K3NBPlY/GySbfpEnVCuR0DtcfGNAcG/6jALw=
Received: by 10.216.62.3 with SMTP id x3mr4673012wec.77.1310537669229; Tue, 12
 Jul 2011 23:14:29 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Tue, 12 Jul 2011 23:14:09 -0700 (PDT)
In-Reply-To: <20110712165949.GB13578@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176993>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> The get_encoding function has only one callsite, and its caller make=
s
>> sure that a NULL argument isn't passed. =C2=A0Don't unnecessarily do=
uble
>> check the same argument in get_encoding.
>
> Such a double-check is not a huge maintenance burden, is it? =C2=A0As=
 I
> mentioned at [1], I am guessing the actual motivation is (1) to avoid
> having to pass "commit" around and (2) to avoid burdening translators
> with a message that will never be shown.
>
> Would it be possible to clarify the commit message so it is no longer
> necessary to guess?

I should have done this earlier.  Thanks for being so patient :)

revert: Don't check lone argument in get_encoding

The get_encoding function has only one callsite, and its caller makes
sure that a NULL argument isn't passed.  Don't unnecessarily double
check the same argument in get_encoding.  As a result, avoid passing
"commit" around, and remove a string marked for translation that will
never be shown.

-- Ram
