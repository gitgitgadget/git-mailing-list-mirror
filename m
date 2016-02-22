From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH v2 0/5] Tests and fixes for merge-recursive rename options
Date: Mon, 22 Feb 2016 19:16:09 -0300
Message-ID: <CALMa68qmGie+AHOWZ=BKHZOeSK9K4djiHRuooCz2h72rNZg7_A@mail.gmail.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
	<xmqqpovo5ul2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:16:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXym7-00088G-28
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbcBVWQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 17:16:11 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33256 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbcBVWQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 17:16:10 -0500
Received: by mail-ig0-f172.google.com with SMTP id y8so97981139igp.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 14:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gMTwSN5qqZF5ioNo3CPFLSuyUNTD4g+lonV78L0szeE=;
        b=xVUTS/9PvHsmNbm0K1tB2GKGZtL59sWee89i3UimYcNfNU4RsttCOk1WRTTky7PxtE
         YDAQYEtzxUH/Pb0ysP62Yf+eJjcs/niiYHWJ35a3XYhsJcY1ZuYARETbzhe7BJ9tAY5e
         0gnUuwv7gVPS/CjTqkBiSMWP1ifA/tJ3D4CYVHTovpGyHGAgjs7bKbglmFLMJdrjnJY8
         dlmt5i4WQ8XjeBaSPJUsHOGkKIASt6++96bH0Rb2qPTtfsBQk9g8iwgFrajhd6OLKT4n
         xGeINidnRaYhMnCxy/L5FAsWPeq7M6wQfOI4k2yVA/PqiQWlA/V2jTLMEgZe8hrZpNrZ
         SXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gMTwSN5qqZF5ioNo3CPFLSuyUNTD4g+lonV78L0szeE=;
        b=N2rRg7VMlirdEM/f2Dtly9gOTVKPAjmAT4UtxiD61c6vjeH2LUE4aOXzcgn+RTghGM
         XzWYeu7pn08HFOyMP3K6gkklORFgBPRze5mysusLkk74OCj71AWpywMsmYIiGEYoZEG2
         DcbIe2xKCYdTbRiFqVEB7IO7c1gNJDIvjp8s8jeHndCeunl/MtS053n+BUz8dMqZjbT0
         N7BELXSusMr6ApyYFK0Xxcv8LkOX132NV5YSFjxcUZoJV4Iy6ZV3Z39UQQEMQipIyPN0
         hUNUEGnHhDTky+Os1CRdXCRf010LDaF/5EFd/xUnDgdy+Wzlq8DyyTM/aHjr3YBCstlq
         MupA==
X-Gm-Message-State: AG10YOSNRHALd20lzbDjMVTpQwt3pDCdmmbjfQ0c4ZHrbmsIsuLPUU8aQ5iaOrg8mhxNsxG5kjb+1alPZX1cvA==
X-Received: by 10.50.43.133 with SMTP id w5mr11769486igl.47.1456179369179;
 Mon, 22 Feb 2016 14:16:09 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Mon, 22 Feb 2016 14:16:09 -0800 (PST)
In-Reply-To: <xmqqpovo5ul2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286959>

On 22 February 2016 at 18:00, Junio C Hamano <gitster@pobox.com> wrote:
> "Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:
>
>> This is a reorganisation of the previous series, bundling the test f=
or the fix
>> along with the commit itself, as suggested by Eric. It also includes=
 many fixes
>> and improvements pointed out by the same reviewer, whom I thank.
>>
>> The typo fix is the same as before.
>>
>> In "add rename threshold tests", I include tests involving --find-re=
names,
>> except for one that depends on the fix.
>>
>> "test option to disable renames" adds tests involving --rename-thres=
hold.
>>
>> "test deprecated interface" tests the aliasing --rename-threshold.
>>
>> In "find-renames resets threshold", the specific test for the featur=
e was
>> bundled along.
>>
>> To Junio: Please pay special attention to the test of threshold trun=
cation.
>> Given that it seems to be an undocumented feature, I am not sure whe=
ther it
>> should be included or not.
>>
>> Felipe Gon=C3=A7alves Assis (5):
>>   merge-strategies.txt: fix typo
>>   t3034: add rename threshold tests
>>   t3034: test option to disable renames
>>   t3034: test deprecated interface
>>   merge-recursive: find-renames resets threshold
>
> As I said, I am reluctant to take the 25%/50%/75% tests in their
> current form.  Let me take the first one and a half of the last one
> (i.e. excluding the test) for now.
>
> Thanks.

Ok, should I post a new version of the patch without the tests while I
rework them or does that mean that you have already filtered them out
locally?
