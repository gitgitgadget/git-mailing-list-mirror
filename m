From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 00:41:13 +1000
Message-ID: <CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<1312284545-2426-6-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 16:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoG9n-0002w5-MM
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 16:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab1HBOlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 10:41:15 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab1HBOlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 10:41:14 -0400
Received: by vxh35 with SMTP id 35so5031980vxh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FOBigEuYNcW90VjB0eMBDH+aRCEMtFIL+U2JO2i4Rts=;
        b=x3o/WpaipOUybO5BNUtVvEMGsF93oGMGbqyr2ow6UvWyurm8PiuR91dCPzpV09A95k
         AY+1tJNakFle8dUjCKDUs8muGqUjKKqhEOOJNLbwu76l/LXRJkK8Kt8bJjYD4Y9Wk7e6
         7HQysi1tLn4z29iVx9n8eZspsdBJWrM2jEDYQ=
Received: by 10.52.93.113 with SMTP id ct17mr2488804vdb.231.1312296073268;
 Tue, 02 Aug 2011 07:41:13 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Tue, 2 Aug 2011 07:41:13 -0700 (PDT)
In-Reply-To: <CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178470>

On Tue, Aug 2, 2011 at 10:04 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Aug 2, 2011 at 1:29 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
>> @@ -34,6 +34,8 @@ require_work_tree
>> =C2=A0_x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>> =C2=A0_x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>>
>> +BISECT_MODE=3D$(test -f "$GIT_DIR/BISECT_MODE" && cat "$GIT_DIR/BIS=
ECT_MODE")
>
> Could you put this line just where it is needed, that is in
> bisect_next() and bisect_reset()?
>

Ultimately, it is also needed in paths that call bisect_state(), such
as bisect_run() and bisect_skip() so I am not keen to do this.

If I was to do this, I'd prefer to change uses of $BISECT_MODE with a
call to a function bisect_mode() that does the same thing.

jon.
