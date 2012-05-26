From: NGUY Thomas <thomasxnguy@gmail.com>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Sat, 26 May 2012 19:17:02 +0200
Message-ID: <4FC1100E.2080909@gmail.com>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <CACsJy8Dx=HWKJ8H3LQhVAAJGtZKmMe0d5e3Q7eHER6Xo4yTAZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 19:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYKcI-0000xD-5i
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 19:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab2EZRRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 13:17:14 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38185 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2EZRRK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 13:17:10 -0400
Received: by wgbdr13 with SMTP id dr13so1765647wgb.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BIENx8/5r+BEG+rRnGwmfZNpFNljlvsNGXrsa/k2e0Q=;
        b=gvojFvKEfRdUuJebtnLR7Omd3SbDJ/ijdRTnXz3qnabcCRXtvBUmDkz0/eQvMShL3a
         8VfA6whnALoMPfkxvLM74PsT8bw2Cu5w0sCYw7hhpPJ5ZdJpfxb3rAvU6XN0Ltv4bs/S
         skgpyKHmm+Y7evlIHlQNqkUaJGM5qbE0GpUnfh55mxOTuBjgLMT2YPGoqKnYP7RaRPz4
         pjRFFqxKMeNTiykcvChsdhB9E4bJOeVH1sp98U0mbUEhtoBo3CJ63eZ5TQs5e5dPaRj4
         EzpiLvmfOStOY3SX3DVJH+eIoi2/UMU4qqJ1xm+WKNzlsjRR9vBOi88rkWi76X/AkXzt
         +Y1A==
Received: by 10.180.99.70 with SMTP id eo6mr4495963wib.17.1338052629182;
        Sat, 26 May 2012 10:17:09 -0700 (PDT)
Received: from [192.168.1.73] (183.24.91.79.rev.sfr.net. [79.91.24.183])
        by mx.google.com with ESMTPS id hv7sm5765605wib.0.2012.05.26.10.17.07
        (version=SSLv3 cipher=OTHER);
        Sat, 26 May 2012 10:17:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <CACsJy8Dx=HWKJ8H3LQhVAAJGtZKmMe0d5e3Q7eHER6Xo4yTAZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198566>

Le 26/05/2012 15:01, Nguyen Thai Ngoc Duy a =C3=A9crit :

>> +       if(rebase_state || rebase_interactive_state) {
>> +               if (conflict) {
>> +                       status_printf_ln(s, c, _("You are currently =
rebasing: fix conflicts and then run \"git rebase -- continue\"."));
>> +                       status_printf_ln(s, c, _("If you would prefe=
r to skip this patch, instead run \"git rebase --skip\"."));
>> +                       status_printf_ln(s, c, _("To check out  the =
original branch and stop rebasing run \"git rebase --abort\"."));
>> +               }
>> +               else {
>> +                       if (rebase_state)
>> +                               status_printf_ln(s, c, _("You are cu=
rrently rebasing: all conflicts fixed; run \"git rebase --continue\".")=
);
>> +                       else {
>> +                               status_printf_ln(s, c, _("You are cu=
rrently editing in a rebase progress."));
>> +                               status_printf_ln(s, c, _("You can am=
end the commit with"));
>> +                               status_printf_ln(s, c, _("      git =
commit --amend"));
>> +                               status_printf_ln(s, c, _("Once you a=
re satisfied with your changes, run"));
>> +                               status_printf_ln(s, c, _("      git =
rebase --continue"));
>> +                       }
>> +               }
>> +               wt_status_print_trailer(s);
>> +       }
> Should this verbose advice be controlled by advice.* config keys?
> Experienced users know by heart what to do and will appreciate screen
> estate being used more helpful (to them) info
Indeed, the advices are a bit long and could be restricted to the=20
information about the
current state but the idea is also to give the user a way to know what=20
to do next.
=46or long messages, such as the rebase case, we could actually use the=
=20
advice_status_hints
variable to display what to do next or not.

Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
