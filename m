From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is it possible to list unpushed tags without accessing remote?
Date: Thu, 26 Jun 2014 09:13:53 -0700
Message-ID: <CAJo=hJvdMURuaEZA3XEWE_Uuq8QRZ+mt8K2H8XrbTuZsVX9gKQ@mail.gmail.com>
References: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:14:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0CJW-0005Op-Ip
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbaFZQOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 12:14:14 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:46795 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbaFZQOO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 12:14:14 -0400
Received: by mail-ig0-f169.google.com with SMTP id c1so937455igq.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f3fmd729gg1ony+eSxMWCQc9NW8yg435BMTxq9lToSA=;
        b=PYYNWYalWMJreS/C1rmjRp/iRRU7t/q/yFnF46vwR+Pc7GR786z9VFu2MJgVOAJBtO
         cZkX2FhNXQpLifz52FUxuaq3pAhGH6ubPKNg/1jN6pUoPNoNRIIQa2+Od/30nlq1EyU6
         LzX7O0JQtrD/I+a3kh71LxcjaliSKhPKBp9JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=f3fmd729gg1ony+eSxMWCQc9NW8yg435BMTxq9lToSA=;
        b=aacIZz2DX22pGHFQhObF7OdGVwV2sfy/842j4aXSNysrSUPHphjMrNjrz1Vvd1Np7Y
         /ERwVi5TVp3Sj20Q4JmPVLmLu9fpENmCWFXywBHzH55lLr6TXTzWDTyWcpBmHW7EptTh
         w+JQFAmEx1zMCS76M9J3MRUNOAPBVAMHp0qgtiEQHovPa2JUYfTDfIxyzMN+7TgFyAAe
         Z8kRkYbOOYXmgtVWsnpz9gdr8hfb3bZpjV3tS7gRBu1hCdWZvDhIeYONS4ciMojbhs6C
         Ri6magb58jN7MFg28AWsZ8hajAf1F1+2tJPeJNhLXZnfH2e32kg1sscQMBz4VbFQtWWa
         uxIg==
X-Gm-Message-State: ALoCoQl7LOYkDYN6xZIO9kH/aFUomWj8BTK8emaPgk/T8y2/JGpNlcoqznkWWK8ltZLyjo9mqjcE
X-Received: by 10.50.97.104 with SMTP id dz8mr5545134igb.3.1403799253094; Thu,
 26 Jun 2014 09:14:13 -0700 (PDT)
Received: by 10.64.208.12 with HTTP; Thu, 26 Jun 2014 09:13:53 -0700 (PDT)
In-Reply-To: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252503>

On Thu, Jun 26, 2014 at 5:42 AM, Kirill Likhodedov
<kirill.likhodedov@jetbrains.com> wrote:
> is it possible to know which tags are not yet pushed to a remote via =
a completely local command?
>
> (e.g. the list of unpushed _commits_ may be received by =E2=80=98git =
log <upstream>..=E2=80=99)
>
> I know it is possible to execute 'git ls-remote=E2=80=99 or 'git push=
 --dry-run=E2=80=99, but both ask the remote server.
> I=E2=80=99m almost sure that the answer is =E2=80=9CNO=E2=80=9D, but =
want to receive a confirmation from Git gurus :)

No. The client doesn't track what tags the remote has.

You may be able to guess by looking at `git log --decorate upstream..`
and seeing which tags, if any show up.
