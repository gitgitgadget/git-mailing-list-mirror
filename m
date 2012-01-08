From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/6] revert: decouple sequencer actions from builtin commands
Date: Mon, 9 Jan 2012 01:23:43 +0530
Message-ID: <CALkWK0kHn+SDaeRHa8bUHWvOEVkr01sVDzvnw9E+-Nne2cii1Q@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-3-git-send-email-artagnon@gmail.com> <20120108193454.GG1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:54:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjyol-0002al-6X
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab2AHTyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 14:54:06 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49516 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab2AHTyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 14:54:05 -0500
Received: by wgbdr10 with SMTP id dr10so1049238wgb.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KRjHBTp+YRzB4EaGScaaBZXuOO56koMVo7tX7oHuiXA=;
        b=hNbZsgcFBMObag0oASShajC0kNrZ04P6NqTdzmtbRnc2TEW5SPFgq8HET+pm2ol/C5
         fEkknWLCs632Djgu3azOfO6zj1i/5D0jBlowd12JAdHkBhMaqJxziZ99Ez/bxeUWYeV1
         yAttHP+XRKjfh/y6SWfj4JL31d+wZgn1cWHB0=
Received: by 10.180.77.200 with SMTP id u8mr345443wiw.18.1326052444236; Sun,
 08 Jan 2012 11:54:04 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 11:53:43 -0800 (PST)
In-Reply-To: <20120108193454.GG1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188121>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0So, while a future
>> instruction sheet would look like:
>>
>> =C2=A0 pick next~4
>> =C2=A0 action3 b74fea
>> =C2=A0 revert rr/moo^2~34
>>
>> the actions "pick", "action3" and "revert" need not necessarily
>> correspond to the specific builtins.
>
> So what change does the patch actually make? =C2=A0Is this a renaming=
?

Yes, it renames "action" to "command" where appropriate.

> [...]
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
> [...]
>> @@ -64,16 +64,21 @@ struct replay_opts {
>>
>> =C2=A0#define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>>
>> -static const char *action_name(const struct replay_opts *opts)
>> +static const char *command_name(struct replay_opts *opts)
>
> Why is the const being dropped? =C2=A0I'm lost, so not reading furthe=
r.

Minor error.  The rest of the patch should be fine.

-- Ram
