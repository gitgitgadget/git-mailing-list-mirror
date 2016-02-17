From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH v3 0/2] merge-recursive: option to disable renames
Date: Wed, 17 Feb 2016 01:38:23 -0200
Message-ID: <CALMa68oy2i6GeiUS1MLodAJ__TsqDzbRWcFVY2xdZKcoONKvzA@mail.gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
	<CAPig+cRhbCRJhrOFcjY2avFZ0rQgCP-JT-6RTCiihOQB8nWeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 04:38:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVswf-00049U-CO
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 04:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933726AbcBQDiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 22:38:25 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:33990 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933619AbcBQDiZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 22:38:25 -0500
Received: by mail-io0-f175.google.com with SMTP id 9so18221015iom.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 19:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/1F3++tckjqWbnXyYSTQ81iqcSkt0q+EZxG1QM/AqmI=;
        b=lrO3ovjIZsWdfe41DQSi4VbIAWP3u+KQv1j+R4EdsFSJb0/RISzAVynNFqql25IzF1
         RwIt3N6KDBWA74LC/0pa3nBa8eE2DXTcEo8OSpZgaB7b/Pjm+cdYh6QeP0OFXiQJJSzY
         lAwongawCI3rWnFg8Nf2CxWGyvXfUuhFAKW4Zb4RYhXjSnE5w+23fsjWihowJlBrSN9X
         1WXnFVWNZ1vq5scRNEtpvz35IuIyUYNbTxMsXoFCR82Q5Zh/KHrQH04xAGT+94mIclh/
         HqnE0kBo+jAoMm6QG2u6+YKdqkrX81HHCr13QdR+nmCVdnGYc7UMDxRLHEzpiPTyrz/E
         FImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/1F3++tckjqWbnXyYSTQ81iqcSkt0q+EZxG1QM/AqmI=;
        b=JdrxFjQdIjdwEm7rcdRlDlGrYseSlXEI5OPVqkRniDdqv2FYrNep+VzuhnyKFU6hqH
         927525Pi/ASPjDxz7MxUyT3OMCv+GFPz12Q66aZlO/6A9GX4pSfEUkoalEw6/RWbnUPO
         jxCn+lNAejFzz9rR5N5ni/D3E55dWBbcvyjnnFP7yMutQPAXKzMUCBaER8j6GFDixJl+
         LmibZX0VaqBAHmyUg2/Gd+bD2DRICaYtz9Ht3udn2qQhfg9byXS9E7/8hOlfUVtdGctK
         gDw4cChBRJpwx5IGlK7XJ4PcZDoUAyQOGMPsaoKDsQ/h9PvRvzBtPHdakUn1jqEg+wfw
         uVIw==
X-Gm-Message-State: AG10YOSteGGumVBYIQqUdOfMNULE3/0FFr9yKbpovGR0H4GYI3lMMcTI2sNIth/XvbZWVNLYnEfye1KUuHa7zA==
X-Received: by 10.107.157.18 with SMTP id g18mr961573ioe.151.1455680304050;
 Tue, 16 Feb 2016 19:38:24 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Tue, 16 Feb 2016 19:38:23 -0800 (PST)
In-Reply-To: <CAPig+cRhbCRJhrOFcjY2avFZ0rQgCP-JT-6RTCiihOQB8nWeMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286481>

On 16 February 2016 at 23:37, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> On Tue, Feb 16, 2016 at 8:11 PM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> No more renames option. rename-threshold enables renames.
>
> Can you add some tests? Off the top of my head, I'd expect to see at
> least three new tests:
>
> 1. --no-renames works as expected
> 2. last wins in "--no-renames --rename-threshold=3Dx"
> 3. last wins in "--rename-threshold=3Dx --no-renames"
>

Sure.

Just a heads up: For the next three days I will have very little time,
so I will start tackling this on the weekend. I submitted a fourth
version of the patch without the tests, so that this part of the work
can proceed in parallel.

Thanks,
=46elipe
