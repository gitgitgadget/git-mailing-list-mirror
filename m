From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: add the ability to show side-by-side diff on commitdiff.
Date: Mon, 17 Oct 2011 11:33:49 +0900
Message-ID: <CAFo4x0KPP1yZec+98_rn9tG_fhtB-DYAcdi90TwiwUPq+DP90g@mail.gmail.com>
References: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com>
 <7vobxgpixo.fsf@alter.siamese.dyndns.org> <CAFo4x0+_Uy=yjbO61qj8krS0-iovzC5WnBE8-1n5OzxgGeg6JA@mail.gmail.com>
 <7vbotgper8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd3f-0001OH-Qc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab1JQCeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 22:34:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56759 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab1JQCeK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 22:34:10 -0400
Received: by bkbzt19 with SMTP id zt19so3120685bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ubCV0JrWFSRZsAwrLlBfBAu++qGstkkTY6NoIiE6cyg=;
        b=gDJyTgI1F+SUV5l9tXJCqxTO2qf0qVnBW1du7jw03jRXysN4gCnWRjd0ONNLl2tpKa
         sLTZg4v7RgbS/nYl0N0hkRs6g8be7abnSbYCTCqZ7PkU7Gci6vUN7bJykbOWQTSWmOg2
         q0CCrvqlJ4AvkTRY2PE+bBgLC6vQswMUIBmYU=
Received: by 10.204.157.142 with SMTP id b14mr3740684bkx.44.1318818849128;
 Sun, 16 Oct 2011 19:34:09 -0700 (PDT)
Received: by 10.204.36.132 with HTTP; Sun, 16 Oct 2011 19:33:49 -0700 (PDT)
In-Reply-To: <7vbotgper8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183752>

On Mon, Oct 17, 2011 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> I think a better organization would be
>
> =A0[1/2] change code so that $diff_class does not have leading SP
> =A0 =A0 =A0 optionally catch a case where $diff_class stays empty as =
an error?
>

I think we don't have to treat empty $diff_class as an error because
$diff_class will be an empty when $line is around modification
(ex. foo or quux).

  foo
- bar
+ baz
  quuz

And class attributes are CDATA. "diff[SP]" and "diff" have same
meanings.
http://www.w3.org/TR/html401/struct/global.html#h-7.5.2
http://www.w3.org/TR/html401/types.html#type-cdata

--=20
Kato Kazuyoshi
