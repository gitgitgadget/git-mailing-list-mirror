From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git am documentation
Date: Wed, 03 Jun 2015 09:42:46 -0700
Message-ID: <xmqqwpzkyc8p.fsf@gitster.dls.corp.google.com>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpq4mmoep9y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:43:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Bkq-0002bJ-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbbFCQmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:42:51 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33121 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbFCQmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 12:42:49 -0400
Received: by igbpi8 with SMTP id pi8so116015797igb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NOI9TQsLzjZzJpbejK5sBK/FUJGZzbCUlojDWsk/34w=;
        b=AIaTCg/SNTZnDx+jETftHTl6IqYh+wEDhPauRjeRsWcdl6dBQC8NKuLA/EyczCYrEv
         cD5zOqmIZ//CKXa+e8zoBVm5GYDG+aA+/DuzmekP/nL4zGz5MmD3Jdl2Ut9aCAp1INgc
         jwhH0reeDMclYvDCIh3Vb228a5THDqH2m1IhzTpwVp2JOaTi/E+smMt0o1opugZV62W3
         Po63ax3X1R4Gn5udefE6Fc2RRYin+5r3qBzMae3WvPFOWGMoOpZMV9wWbQyOVXEoV1ZY
         CxcQeIO5q8I+GL7UJ6aj3D4KkcVXI1Z1kvYW53d85YOBc1Owb8H2KHt79PHnmGTKO1lu
         masQ==
X-Received: by 10.50.132.33 with SMTP id or1mr28613523igb.31.1433349768644;
        Wed, 03 Jun 2015 09:42:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id qt1sm912353igb.5.2015.06.03.09.42.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 09:42:47 -0700 (PDT)
In-Reply-To: <vpq4mmoep9y.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	03 Jun 2015 18:21:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270696>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>  OPTIONS
>>  -------
>>  (<mbox>|<Maildir>)...::
>> @@ -43,11 +53,11 @@ OPTIONS
>>  --keep-non-patch::
>>  	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>>  
>> ---[no-]keep-cr::
>> +--keep-cr::
>> +--no-keep-cr::
>>  	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
>>  	with the same option, to prevent it from stripping CR at the end of
>> -	lines. `am.keepcr` configuration variable can be used to specify the
>> -	default behaviour.
>
> I don't think it's a good idea to remove this part. If I look for a way
> to make --keep-cr the default, the first place I'd look would be the doc
> for --keep-cr, and I'd appreciate a link to am.keepcr.

Yup, very sensible suggestion.  Configuration gives default, command
line options override the default.  People come two different ends;
having to describe the same thing twice is wasteful, but will help
them one indirection to find relevant facts in the documentation.
