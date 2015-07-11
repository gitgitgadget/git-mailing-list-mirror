From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git Smart HTTP with HTTP/2.0
Date: Sat, 11 Jul 2015 16:10:06 -0700
Message-ID: <CAJo=hJuM70o8+U3Wt3rRzyrB1O=Q+wz3bGZVFa07zRQ0Ughk9g@mail.gmail.com>
References: <BLU403-EAS33258611CF3B5B553B1C996A09E0@phx.gbl>
 <20150711070055.GA4061@LK-Perkele-VII> <CAJo=hJs21m1C6+rdvCid311-TapK=QKLkqrH8aUZmzHH7CpVug@mail.gmail.com>
 <20150711182657.GA8589@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ForceCharlie <fbcharlie@outlook.com>, git <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jul 12 01:10:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE3ui-0005AB-NG
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 01:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbbGKXK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 19:10:27 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36223 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbGKXK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 19:10:27 -0400
Received: by widjy10 with SMTP id jy10so40558098wid.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z0kw4RhDP2RU+M1YuRtxijxE1le00pfD+p7dyX2Ai7w=;
        b=OJH4F8Yigj2S5Gydj3/KlsGWunyyFrj2RYngB7eOqTJuIcIY7n++OhNn4PuSw3lpJH
         QlV2M3Q5YmTP/2e/JBr7kvAWX8Vfw4hY2vrNqKHmLUuYQeyc7tls/lZqfNy2wmC9cjVT
         a1hHmeZxQvSh4oB220prB0YLzAqD05VmvXzgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Z0kw4RhDP2RU+M1YuRtxijxE1le00pfD+p7dyX2Ai7w=;
        b=SVuf93sB9XZAeTslpCrVHaR38IETlNRkDo42LEiicmIblgUGn+2gymThrU5DG8x6aj
         WTZPBgwhkcuEMmgmb2kO9bAEku5U6ca/ftncqSHOCtBL0C4TfLlXIKcpV6eYtmx73cVM
         i/Ze73LNTDqhjEskrK4EQGBba9ssvmNqyi/L994J5aK58nRfNBua13tBTpTcz8gEXFJs
         WmB0x8OQlJHpb0NERaQ49Z79nqVBMwo7Za4Z6JwGaZLzkOsPyLTLSFg2HeVZ4VrHj4Ld
         vlufss4g9BnoZkwbphzrCQq5dzdRnjwScdOb6Fgz2wC8/rdBUJMf4L0ZgJXi3g6eEMs+
         izWg==
X-Gm-Message-State: ALoCoQmX9gG+hfavC9dTqkoKbirUEm7yJ8ovVofQiScAZj5uJlwki2wZjJq+1dOFwsKbeDronpGQ
X-Received: by 10.194.52.105 with SMTP id s9mr53744665wjo.53.1436656225619;
 Sat, 11 Jul 2015 16:10:25 -0700 (PDT)
Received: by 10.28.228.70 with HTTP; Sat, 11 Jul 2015 16:10:06 -0700 (PDT)
In-Reply-To: <20150711182657.GA8589@LK-Perkele-VII>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273878>

On Sat, Jul 11, 2015 at 11:26 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Sat, Jul 11, 2015 at 10:23:09AM -0700, Shawn Pearce wrote:
>>
>> > Websockets over HTTP/2 (a.k.a. "websockets2") has not been defined yet.
>> > With Websockets(1), it would probably already be possible to tunnel the
>> > native git smart transport protocol over it. Probably not worth it.
>>
>> Another option is to tunnel using gRPC (grpc.io). libcurl probably
>> can't do this. And linking grpc.io library into git-core is crazy. So
>> its probably a non-starter. But food for thought.
>
> Wouldn't it link into git-remote-http (and on the server side, one
> could use pipes to talk to git)?
>
> But supporting websockets in git-remote-http could get annoying,
> especially for wss:// (https://). Dunno how bad gRPC would be.

We wrote it as git-remote-$THING, invoked with $THING:// URLs. And
git-remote-$THING just implements the "connect" helper protocol. Its
much simpiler than git-remote-http.

Maybe its done that way in git-core as http2:// aka git-remote-http2.

Or the git-remote-http helper connects to the remote system and tries
to guess if it supports Git on HTTP/2 before responding to the
capabilities request from transport code. If yes, it replies with
connect, if no, it does the current fetch and push protocol.
