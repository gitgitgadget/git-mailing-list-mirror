From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 03:12:51 -0400
Message-ID: <CAPig+cTFSuorbayPWLLbFLtm69LQ2wme1f=V0tTO4FVVYZireQ@mail.gmail.com>
References: <1376110736-11748-1-git-send-email-stephen@exigencecorp.com>
	<CAPig+cQ2NhMJGTBLHNH2zcfqKUv_ZNF4zGEiXjvHz-LS307kqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	avarab@gmail.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 09:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Ppi-0003Kc-JD
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 09:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab3HKHMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 03:12:54 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:38291 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab3HKHMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 03:12:53 -0400
Received: by mail-lb0-f177.google.com with SMTP id r11so4071344lbv.36
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ODp9bPyE7BUzlOO75d9HFIPsX2GqIfj/PS/sS9edSr0=;
        b=SR0cMOs4ozDWpEHPsW0w3n6rcwECfEK+rFFoEKpQMqMt8gX8ff04O+zPs8NXGyCOas
         kcsAdtSA7jJo1cQPTGOrJp52fXjfzq5kCgm7xL11dsc3AN6rTCEDPV/Mp3oaUYcvlCaP
         ACrZa8+P87fwDf0I8+b1/LziizSpip6GvsQ24HYWwQrxx3gJ7Dkc/Kxp1SR0cYub3OOu
         chw9SxepJssiyR2t+xhImj63qFVCeSJGJ/u7GzG2ROvWS2j1zFmtle9f+nkV2cO0uF0L
         hwYkRytiUdcPEYcN/lh5GXbKC0N0LD3lt01Zi/4cw7lIUuosgyIMmdRRHWbXMS3vJddP
         kwow==
X-Received: by 10.112.138.37 with SMTP id qn5mr7302455lbb.52.1376205171938;
 Sun, 11 Aug 2013 00:12:51 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 11 Aug 2013 00:12:51 -0700 (PDT)
In-Reply-To: <CAPig+cQ2NhMJGTBLHNH2zcfqKUv_ZNF4zGEiXjvHz-LS307kqw@mail.gmail.com>
X-Google-Sender-Auth: D5UbR0VqcRrFDPSSdO6IV9F2DAY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232125>

On Sun, Aug 11, 2013 at 2:16 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Also, it's not clear from the documentation how one would override
> pull.rebase=preserve in order to do a normal non-preserving rebase.
> From reading the code, one can see that --preserve=true (or

s/--preserve=true/--rebase=true/

> --no-rebase followed by --rebase) will override pull.rebase=preserve,
> but it would be hard for someone to guess this. One could imagine
> people thinking that --rebase alone would intuitively override
> pull.rebase=preserve, or that --preserve=no-preserve would do so, but
> that's getting ugly.
