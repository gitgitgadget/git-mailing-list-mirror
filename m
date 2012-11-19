From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 0/2] New zsh wrapper
Date: Mon, 19 Nov 2012 22:56:31 +0100
Message-ID: <CAMP44s0K2bzDDJQcC-KRnY50sZ4zNPSaujH5Gj7v5y6=ZYM90Q@mail.gmail.com>
References: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
	<7vpq39xw01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Marc Khouzam <marc.khouzam@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaZKe-0002Db-Ud
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 22:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab2KSV4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 16:56:32 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63201 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2KSV4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 16:56:31 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so5328060obb.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vGmMErdxluFU03jw8VmIU5TnsijS6hSbEJEh0wnCtqY=;
        b=oj+cgJKPEPVAC6wqpqwmiCWA3RsP0RSUdD2px5vgTXW1xo5qx4L94fpmY5Ehq/2iQF
         3KtPzzbYH/iWV5i3SKHmBXiZkjYuE3vDqZcP1vtuhxm8xuu4SHza6hO1Y1EOPXjoud0w
         yjgmY0UiO0A/TR2TwMaw5ypRrb1VlCpMsaxoluJepimrM4O+Ps2EEqgirNSiM4U29mA4
         HeseyYSHOfq+Sv13yGXChkRuUKteVpSeFwgeTGIVOXh1rS20zs5mr0PL+XobtuwuGUBJ
         VHiX7kn4Cz/N93Qqao3NhSim8ZPhzR01c5ZVNppjCCsO04o+ToOByTN5QBioIS7Iv423
         P3Zw==
Received: by 10.182.194.70 with SMTP id hu6mr11782959obc.4.1353362191140; Mon,
 19 Nov 2012 13:56:31 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 19 Nov 2012 13:56:31 -0800 (PST)
In-Reply-To: <7vpq39xw01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210058>

On Mon, Nov 19, 2012 at 7:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The second patch is new, in order for users to get the same features when
>> sourcing the bash script (they don't need to change anything). They'll get a
>> warning suggesting to check the new script git-completion.zsh. Eventually, that
>> support would be dropped from the bash script.
>>
>> Some people were suggesting something like this, so here it is.
>>
>> Can we merge the zsh wrapper now?
>>
>> Felipe Contreras (2):
>>   completion: add new zsh completion
>>   completion: start moving to the new zsh completion
>>
>>  contrib/completion/git-completion.bash | 104 +++++++++++++++++++--------------
>>  contrib/completion/git-completion.zsh  |  78 +++++++++++++++++++++++++
>>  2 files changed, 139 insertions(+), 43 deletions(-)
>>  create mode 100644 contrib/completion/git-completion.zsh
>
> Thanks; I am a bit puzzled as to the progression of this series, as
> it spanned many months.  I *think* the following are the previous
> ones, but I may be mixing up v$n patches for other series, so just
> to make sure (please correct if I am mistaken):
>
>  * (v1) http://thread.gmane.org/gmane.comp.version-control.git/189310
>    with only git-completion.zsh without any changes to the bash
>    side;

Yes, and with a lot of code that is not strictly needed.

>  * (v2) http://thread.gmane.org/gmane.comp.version-control.git/189381
>    without bash side changes;

Yes, also with more code.

>  * (v3) http://thread.gmane.org/gmane.comp.version-control.git/196720
>    without bash side changes;

Yes, now it's simpler due to changes in bash side already in.

>  * (v6) http://thread.gmane.org/gmane.comp.version-control.git/208170
>    with COMPREPLY changes;

Yeap.

>  * This one, with removal of zsh specific workarounds from bash
>    completion script.

Yes, although that is a separate patch.

> I do not care too much about how v4 and v5 looked like; I primarily
> am interested in knowing if I can discard 208170 from my inbox
> safely ;-).

Yes you can. The rest of the patches I sent in a different series.

Cheers.

-- 
Felipe Contreras
