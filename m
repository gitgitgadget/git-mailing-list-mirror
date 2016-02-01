From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 6/6] worktree add: switch to worktree version 1
Date: Mon, 1 Feb 2016 13:05:05 +0700
Message-ID: <CACsJy8Am7rQ=pm0C7bw0gQ=aic3opmBos+3+1Awrko8TT2uHrg@mail.gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com> <1453808685-21235-7-git-send-email-pclouds@gmail.com>
 <20160201053333.GE4978@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 07:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ7cK-0002TM-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 07:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbcBAGFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 01:05:37 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34031 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcBAGFg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 01:05:36 -0500
Received: by mail-lf0-f65.google.com with SMTP id 78so1170817lfy.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 22:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EZZyY8XR/4aqPz9MrQZ+fR4q8PHXP7loqkro0H9xuAw=;
        b=Ks2SUNpzE28jFJHrSQDiLrVh5Pq4rNwl+6kwLobILqSO2i8yJea5sOKBRiqxb35wTW
         v4YpPHllDymBajlWprWsifif4qDdzLjVa+J/zDcwBzBIfzhTBFMsb7PA2JFaP5Ykdmv7
         Jo07d5E2YhFOixnWdWtltzaZyE5ZpQq3ApkEiSZ2n90KUKAdHA5ZNqXTYUSDajSYPJgA
         7rylDxIT87qYpz+rTuP+vK83kNT6Gx+epgU71I21a22p6kiRrlSX6RBKWFft0HVqHyJr
         4g/m7tnntr0CR6UulNqdEDvtb2+ffE+SjwmiH8/OB4NVAMgXispvPf8uk1xtQ7ZMCMI3
         ZUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=EZZyY8XR/4aqPz9MrQZ+fR4q8PHXP7loqkro0H9xuAw=;
        b=fpX2UM9gEsGMC1kDT5NNe4ir+ov2KcLFVdhFxHcGdhim1sJYAkRqRLBkaevK1wBW9I
         mslZDgx2MkW/xg7Fxgu7OQcqNfN6EcNliiqgT67a1GtG4Z/+7k5qmdp0Cyr15PODmI28
         wyq4sOKESoiexileAA7cwJkDNVLm1Hyt8Q1BDm1Z3zgFiZwwKFh+blvsHCLij2r1Re/l
         8L4E1GTqaji1Crcww/GVL8redPebc0kajJG/movzHYls7A+pZbIV9sfqViEyL2vaSVir
         p3GPO0RvpyBXGIU0PnFYCeqq65hahRJGbxY6dGrkB3WHaBqRWrDB/jlbLS+EHE88G02f
         PQZA==
X-Gm-Message-State: AG10YOThYT/yeMgo75APWSPemLIarY4agXyLpve1iZRNk19qHlziIg52WJHkD5dcjvirUdcrUTmSEqSt4Njkyw==
X-Received: by 10.25.134.137 with SMTP id i131mr2121225lfd.94.1454306735230;
 Sun, 31 Jan 2016 22:05:35 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 31 Jan 2016 22:05:05 -0800 (PST)
In-Reply-To: <20160201053333.GE4978@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285188>

On Mon, Feb 1, 2016 at 12:33 PM, Max Kirillov <max@max630.net> wrote:
> On Tue, Jan 26, 2016 at 06:44:45PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> +             for (key_p =3D per_wortree_keys; *key_p; key_p++) {
>> +                     const char *key =3D *key_p;
>> +                     char *value =3D get_key(sb.buf, key);
>> +
>> +                     if (value) {
>> +                             if (git_config_set(key, value))
>> +                                     die(_("failed to keep %s in ma=
in worktree's config file"), key);
>> +                             if (git_config_set_in_file(sb.buf, key=
, NULL))
>> +                                     die(_("failed to delete %s in =
shared config file"), key);
>> +                             free(value);
>> +                     }
>> +             }
>
> 1. For submodules (which must be left per-worktree) this
> approach is not going to work, because you don't know all
> variables in advance. You could scan the config file and
> match those actual keys which are there with patterns.

Hmm.. we could keep existing submodule.* per-worktree. New variables
are per-worktree by default, unless you do "git config --repo" in
git-submodule.sh. Am I missing something?

> 2. This migrates variables to the default (or current?)
> worktree, what about others existing?

In v0, $C/config contains all shared variables, once we move these
shared vars to $C/common/config, they will be visible to all other
worktrees. Or do you replicate per-worktree vars in $C/config to all
worktrees ?
--=20
Duy
