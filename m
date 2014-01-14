From: =?UTF-8?B?QmVub8OudCBCb3VyYmnDqQ==?= <benoit.bourbie@gmail.com>
Subject: Re: git gui crashes ( v 1.8.5.2)
Date: Mon, 13 Jan 2014 22:06:12 -0600
Message-ID: <CANJSc_u-f-qZsbEQdEeDTGnmjsEf_82aJ3MXE+cpvzt5+-aPow@mail.gmail.com>
References: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
 <20140114011141.GF18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 05:06:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2vH4-0008E2-GS
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 05:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbaANEGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 23:06:35 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:45280 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaANEGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 23:06:33 -0500
Received: by mail-wi0-f182.google.com with SMTP id ex4so184230wid.15
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 20:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=o6n18bfYMcrCIjYKMMJ7oZW35sZnBWIkJLuHuwju/5U=;
        b=BSvFZHPtXcmaCbt5cqbTMyEmPhmAgDRrzHEJ6eLewTmM7+oB9wnAFzR//FNTP6YK7q
         6ikPjWtQ7xkNpmMGHm/Kk982hQt/F5H0UH4F7bRwdCVrdpOV4o3Sp5ix1gXt5j7b0vAT
         5nYrv5ScQ5nDhRmqhIVQENfEyTy9DpHTqxoC2erXwCq7ITkkNy/SpFQNxPDvSR2KiPjz
         TdKkAHwKiDD8Llgr3T+dsFcXrcz5Q7Qp3qhOOllk+1D3/kCs1y+3fY7B4S9GJDPGuBc5
         yULl1qR6ZgC5iIHCQT3+JnB0V7JFWQVwIgtaJ86yV3X1u3jZDzq4fvBbezDTVuD9/X4H
         BSLQ==
X-Received: by 10.194.61.3 with SMTP id l3mr24728044wjr.18.1389672392427; Mon,
 13 Jan 2014 20:06:32 -0800 (PST)
Received: by 10.194.28.3 with HTTP; Mon, 13 Jan 2014 20:06:12 -0800 (PST)
In-Reply-To: <20140114011141.GF18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240390>

Hello Jonathan,

Yes, after checking, you are absolutely right, I was on master.

:)



On Mon, Jan 13, 2014 at 7:11 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> (just cc-ing some area experts)
> Hi Beno=C3=AEt,
>
> Beno=C3=AEt Bourbi=C3=A9 wrote:
>
>> git gui crashes on my Linux machin since I updated it to 1.8.5.2.
>
> I assume you mean "master" and not 1.8.5.2, since v1.8.5.2 doesn't
> include the change 918dbf58 (git-gui: right half window is paned,
> 2013-08-21).
>
>> I had the message
>> Error in startup script: unknown option "-stretch"
>>     while executing
>> ".vpane.lower paneconfigure .vpane.lower.diff -stretch always"
>>     invoked from within
>> "if {$use_ttk} {
>> .vpane.lower pane .vpane.lower.diff -weight 1
>> .vpane.lower pane .vpane.lower.commarea -weight 0
>> } else {
>> .vpane.lower paneconfigure..."
>>     (file "git/libexec/git-core/git-gui" line 3233)
>>
>> So, I reverted the change that has been made in git-gui/git-gui.sh
>> (Diff and Commit Area)
>>
>> I replaced
>>
>> ${NS}::panedwindow .vpane.lower -orient vertical
>> ${NS}::frame .vpane.lower.commarea
>> ${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height=
 500
>> .vpane.lower add .vpane.lower.diff
>> .vpane.lower add .vpane.lower.commarea
>> .vpane add .vpane.lower
>>
>> by
>>
>> ${NS}::frame .vpane.lower -height 300 -width 400
>> ${NS}::frame .vpane.lower.commarea
>> ${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1
>> pack .vpane.lower.diff -fill both -expand 1
>> pack .vpane.lower.commarea -side bottom -fill x
>> .vpane add .vpane.lower
>> if {!$use_ttk} {.vpane paneconfigure .vpane.lower -sticky nsew}
>>
>> and now, git gui works as expected.
>
> Thanks,
> Jonathan
