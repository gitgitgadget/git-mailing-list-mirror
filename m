From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 16:19:01 -0400
Message-ID: <CAPig+cRvV2L3Wt3sMLHMngzeomLcD96Swfd3KSXJxnBEid2yVA@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<1427048921-28677-4-git-send-email-koosha@posteo.de>
	<550F1E9F.40801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Koosha Khajehmoogahi <koosha@posteo.de>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 21:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZmL5-0006Um-6O
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 21:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbCVUTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2015 16:19:04 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34681 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbCVUTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2015 16:19:03 -0400
Received: by yhch68 with SMTP id h68so60179366yhc.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Jl8tXAbg/WJQukcZ1Cmq7GcoAYvDju6ttsmtAMu7WYk=;
        b=pYxYETUvq2zRwcAVZwnEMS21J+01B4Piq6vNYBEqCDuxpiAGANqTQsZEJuQhnpKp41
         UhMvAs75LDKBtwJkFo6rNuf79X693Awx8pMD8HRuxTueugLy+axt88Gv2sjCHyfqYkcM
         Gwqk/mNYjdT7deYB7ipXBbi3+8xiNKuA2ZIokEjhyKRgyErUqMKOtfTtGc3X1j/qO04J
         2ZMRl/MAhwE73FJO7k/yfZ+4AD7zMuMTVgvUo4TiMi9ijOSA9GBLKS5B8D9TEaW8HCPj
         stqy9rwb8DgPy9LoAqS6JZG2NxZRC2CMM7MxHEJACZEg4qrc1TIVkdFBRMYeyU+w6ZOt
         RRow==
X-Received: by 10.236.63.6 with SMTP id z6mr92570805yhc.65.1427055541816; Sun,
 22 Mar 2015 13:19:01 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 13:19:01 -0700 (PDT)
In-Reply-To: <550F1E9F.40801@web.de>
X-Google-Sender-Auth: dc4BsFehbDknUzLR1IRa7u6xTcc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266089>

On Sun, Mar 22, 2015 at 3:57 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 22.03.15 19:28, Koosha Khajehmoogahi wrote:
>> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
>> ---
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 5f2b290..ab6f371 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -428,6 +428,147 @@ cat > expect <<\EOF
>>  * initial
>>  EOF
>>
>> +cat > only_merges <<EOF
>
> - please no space after the ">"
> - please add the && at the end of the line:
> cat >only_merges <<EOF &&

This code is outside any test, so && has no impact (and would be
slightly confusing). Better would be to move this setup code into a
"setup --merges=3D" test, in which case the &&-chain would be
appropriate.
