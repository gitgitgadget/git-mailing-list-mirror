From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Fri, 27 Jan 2012 10:33:32 +0100
Message-ID: <CACBZZX5MH7bEY_0081zTQbofQ5FCHGR7AQBpxXXd2c9oFUo=+A@mail.gmail.com>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126073752.GA30474@sigill.intra.peff.net>
 <CACBZZX5_qjC6WZsZ9hKvSR5vQJPs=jgWn-R4EnWZGVq+RvjRyg@mail.gmail.com> <20120127003241.GA15165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 10:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqiC0-0000w0-S3
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 10:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab2A0Jdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 04:33:55 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39253 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751323Ab2A0Jdx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 04:33:53 -0500
Received: by lagu2 with SMTP id u2so838812lag.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+FLirTk1Sbdd7MlYl5AVErtTmzk8yJDEWNgX6T6hZaw=;
        b=Gkac1Crj7N9RhesiXaU3E/Tfy5/knrqnbaWD0UzGVIJhYMlOH6jJUJn6010OI1Xptf
         CjGO1A0byM7Vmh1IgHQCFpKCDWtyQPgC7hCOHLewQxDLhduNRbM0LsmFIZb2qenWmzg+
         GJGyVA68NG/uHKc+TI+7AOzoyB72aCksCxkSI=
Received: by 10.152.105.175 with SMTP id gn15mr3110766lab.23.1327656832185;
 Fri, 27 Jan 2012 01:33:52 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Fri, 27 Jan 2012 01:33:32 -0800 (PST)
In-Reply-To: <20120127003241.GA15165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189209>

On Fri, Jan 27, 2012 at 01:32, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 27, 2012 at 01:02:52AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Thu, Jan 26, 2012 at 08:37, Jeff King <peff@peff.net> wrote:
>> > This patch introduces an include directive for config files.
>> > It looks like:
>> >
>> > =C2=A0[include]
>> > =C2=A0 =C2=A0path =3D /path/to/file
>>
>> Very nice, I'd been meaning to resurrect my gitconfig.d series, and
>> this series implements a lot of the structural changes needed for th=
at
>> sort of thing.
>
> Yeah, that seems like a reasonable thing to do. It could make life
> easier for package managers (I think the only reason it has not come =
up
> much is that there simply isn't a lot of third-party git config).
>
>> What do you think of an option (e.g. include.gitconfig_d =3D true) t=
hat
>> would cause git to look in:
>>
>> =C2=A0 =C2=A0 /etc/gitconfig.d/*
>> =C2=A0 =C2=A0 ~/.gitconfig.d/*
>> =C2=A0 =C2=A0 .git/config.d/*
>
> Hmm. Is that really worth having an option? I.e., why not just always
> check those directories?

You're right, always just including those directories is a much better
option, an extra stat() doesn't cost us much.

Thanks again for working on this.
