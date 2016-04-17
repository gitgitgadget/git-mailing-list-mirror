From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] t1500-rev-parse: rewrite each test to run in isolation
Date: Sun, 17 Apr 2016 12:15:19 -0400
Message-ID: <CAPig+cQ+iqteAdEQR0PLZXnOLVuOT8Onbk3DDPujVvCmgnu=OA@mail.gmail.com>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
	<1460823230-45692-3-git-send-email-rappazzo@gmail.com>
	<20160417114253.Horde.giIo57RkUzhAe6GP-RahIrw@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 17 18:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arpM7-0000qS-2D
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 18:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbcDQQPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 12:15:21 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34729 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcDQQPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 12:15:20 -0400
Received: by mail-io0-f193.google.com with SMTP id z133so20546871iod.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=juXyyGFzeNsNdsMoSx6SHf6FKUNkwduFpZRR/k3fyEE=;
        b=xcRbZT2ftGh6VCrMZ2Y7cruatpcOtGb6bw/cRttYNqC5oLqeN++Ik/BjjOW9b+ChKq
         Q4mfIPa0FFm7MGCmljN+o18DQFMT5xOQyMku1aYWm8gZgKbSPl/JIftoONjmn8io0fOw
         0cUnHKEPvKg45l4ttIfpqbiMkYh89IVQH7EBrvDtEAu7110Xfo8B+DXj6GTpsCZPB1AS
         LxhNx8mNhOjq+OKmNamwaBam+PoQD2vU4HNcqXqTf8znfalswAOHMDJaJ+Ob0d35Fky0
         CuS99Q8uYlTQoHrLtIsdN+uQF4MQ3PQdUnqFei2NvoSm14PT7KzRHtWl3SAPt2cSwOEn
         ivCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=juXyyGFzeNsNdsMoSx6SHf6FKUNkwduFpZRR/k3fyEE=;
        b=DQDZNmFC9Nwu0CIzULrlCMTqKq6u0Xx38kHD9Tx/dJ7j2yWWOHkYPGoAjLX3jHm2TT
         T4bwkOL1GgGyuZdYNo/usnU9uqg/9mE279Si6bfy70FGrrCoCOmw++SmLtgQnmE7ZrgW
         2UMtGULH9TCQgaIUstBRQEbzjiRofO4S7heAAXyK0NCWU/e6oG56haidwNivaMto0onR
         pWdOzOTTYgg6eEa1nMD+bmuhA/tEu9jPGTNSxKES/nZ93hbxx+Wi+2TUn+aXty8oOARj
         er1JAqnYnjp+oSK/k5yahCgeZLCLJYSFm2j2iD7VPxwh8ggZzudkQJOMe+HaY727ZdHU
         1+SA==
X-Gm-Message-State: AOPr4FUHX/9NWIN2F2iwW7CSLNujUz2+x1Uh/p42bGEcb5wGU8rJwmDNIkSVUpVSTeOBl8RoXU9zKN2yLg54zA==
X-Received: by 10.107.47.10 with SMTP id j10mr17260301ioo.168.1460909719554;
 Sun, 17 Apr 2016 09:15:19 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sun, 17 Apr 2016 09:15:19 -0700 (PDT)
In-Reply-To: <20160417114253.Horde.giIo57RkUzhAe6GP-RahIrw@webmail.informatik.kit.edu>
X-Google-Sender-Auth: 4J13bPEo3pBdE21jOq3RdQxRoq4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291764>

On Sun, Apr 17, 2016 at 5:42 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Quoting Michael Rappazzo <rappazzo@gmail.com>:
>> +test_expect_success 'GIT_DIR=3D../.git, core.bare =3D false:
>> is-bare-repository' '
>> +       mkdir work &&
>> +       test_when_finished "rm -rf work" &&
>> +       test_config -C "$(pwd)"/.git core.bare false &&
>> +       GIT_DIR=3D../.git test_stdout false git -C work rev-parse
>> --is-bare-repository
>> +'
>
> Here and in the following tests as well: some shells don't cope that =
well
> with a one-shot environmental variable set in front of a shell functi=
on.
> See commit 512477b17528:
>
>     tests: use "env" to run commands with temporary env-var settings

While reviewing the patch, I stared at that code for a good while
thinking that there was something about it I ought to remember but
couldn't, so thanks for the reminder (and j6t's too).

Considering that this patch is probably going in the wrong direction
and that if, when re-rolled, it takes a systematic approach testing
that the original code uses, then the "need" for test_stdout
effectively disappears, so this issue should go away too (but it's
good to remember, nevertheless).
