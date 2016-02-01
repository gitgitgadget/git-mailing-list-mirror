From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 5/6] config: select .git/common/config with --repo
Date: Mon, 1 Feb 2016 12:15:08 +0700
Message-ID: <CACsJy8Av6W3S2S+eEi=X_V1TSBYp_t4wdRn_dvrtKiS3aS_=7g@mail.gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com> <1453808685-21235-6-git-send-email-pclouds@gmail.com>
 <20160130221010.GD4978@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:16:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ6qI-00074N-5G
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 06:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbcBAFPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 00:15:40 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34386 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcBAFPj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 00:15:39 -0500
Received: by mail-lb0-f194.google.com with SMTP id oe3so5565431lbb.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 21:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NDg8LVPrpk1lcr/aWcfa7/WdNg8jz2VuBrdrOktbCZo=;
        b=idsTePHPBJ7a9kteQCi5IEHczHFUxXBPpD/Rkd/3yr2aFnK2CayjRg0DUi45SATHAG
         rY+V6p33hm5sCsLrYgN+qEdrxVUdbgNGXhlL9DwybDHLV20+gg3qvRvPqdNJKUDH3T+C
         7+DJclZ0ArRmJKCMSlSpPFgnsnAfSwBpMC+Ct4Tvxtn6hlSQXb7PKQK9368F79IP8ayW
         OBKhxXKOcgZNBEc5R0DQlU6aRyMsVGGTG3jnvyqlWZO+h/CyTSFq75wXmXynizABQuNZ
         3/Y5+dTxjhBWUMhMrxGOWx07GiZSdCDTt7UaCBOzKFdV4OcenoWYjzqwBUot3+iPc93u
         m+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=NDg8LVPrpk1lcr/aWcfa7/WdNg8jz2VuBrdrOktbCZo=;
        b=j0S6KoZFuIwNfdq6bENF2GHygiXhp+HZGmZ0eT6ys+OKgX3k7M3rNZUqKDC1ju3ZpS
         nKnZ3BRTu6i4K48n9UeJaFouJ45JCLOOAhScBmGjGIqRWmjCC8yI5LWwngYjvE5vz9a8
         0kPK6Kd7D2zYxiEbjfFJtkzw7O1h9TpxR89OCECvrVwXoY7lupo2WUQSrGVhtIQ0CAus
         r7UyhnP4jSnqsNMbGFTErJwNdzEYWFz0Owg4nzB+PPk9CboU16QVWXnz1JHuMntfxFq/
         S1bhngOLo6DV2C3LDwu7CYL0N/DswRdgH1U/quWCWfCOxQEY8y94eJujWYYzDuk2FMcX
         72XQ==
X-Gm-Message-State: AG10YOTWL0QKyamvGTqnjQtQuSDDpgJh081cRXYPj9vIw+3WQtK6POodsH4LHt7Hy7Bi4S8On3OHspp7488UUQ==
X-Received: by 10.112.209.99 with SMTP id ml3mr7428069lbc.26.1454303738126;
 Sun, 31 Jan 2016 21:15:38 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 31 Jan 2016 21:15:08 -0800 (PST)
In-Reply-To: <20160130221010.GD4978@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285185>

On Sun, Jan 31, 2016 at 5:10 AM, Max Kirillov <max@max630.net> wrote:
> On Tue, Jan 26, 2016 at 06:44:44PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> This new option allows the user to write to or read from
>> .git/common/config in worktree v1. In worktree v0, --repo is an alia=
s
>> of --local.
>
> Looks like by default a value is always set in a local
> config, which might be dangerous for remote.* or gc.*
> parameters, for example. I think that even if reading is
> done uniformly setting could depend on the actual variable
> being set if no location specified.

I grepped "git config" in scripts to see if we need to change any to
use --repo, but I forgot about builtin commands. git-remote needs to
store remote.* in the shared config file instead.

gc.* and others are set manually by the user, so they decide. We can
have a user-controlled filter that catches certain variables and
suggests they are stored in shared config instead, but this is
optional.
--=20
Duy
