From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Fri, 11 Oct 2013 19:02:15 -0700
Message-ID: <CAJo=hJu30M-vk5oavfi8TAS8B551MRmABx7EqN5GGxq_Hd9g=A@mail.gmail.com>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
 <20131009193054.GA3767@sigill.intra.peff.net> <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
 <20131009213742.GA8362@sigill.intra.peff.net> <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
 <CAJo=hJtBapzmF7BEawwRGJ0NKH1W0J5P4c4iGK6G_==gZahhgg@mail.gmail.com> <20131011223151.GC79408@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 04:02:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUoXS-0002jf-3o
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 04:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab3JLCCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 22:02:38 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:37043 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3JLCCh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 22:02:37 -0400
Received: by mail-we0-f181.google.com with SMTP id t60so5055276wes.12
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 19:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U7WuLyKUbCmwrhV7SUgsNeM1EfDKOJz82fpyh9aT5LM=;
        b=F4JuakP1TgV98x8TWm2rI+mdBCh+6EuZH3l7aNK1lgopPz4TRCCd/2UCOnRqprhZbR
         cTQcv1vaaXLWqovvx9SogjBZzi17d6DRqE02/FLtS4yCRxj/lFnm+LOXB0laNazs83rd
         izuuib0E0kTqXuqwqfoA3+rANyMMoPSqkKo9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=U7WuLyKUbCmwrhV7SUgsNeM1EfDKOJz82fpyh9aT5LM=;
        b=GZ1n5OLgaFBdiSLUWZXMjAdWzHvbgb/TEDjNlOBglixGZ11ECEFeJKAn+mrj61sVvr
         WEcxlLKLQUCbe0wl9J2oDlsJtaWDnRK5RGysnZ3r0H59K9zxr291mDgBg+XpvLwtbbOS
         O4w8Sn3aXKEw6WEtSdw1lzQnpeQukHx2LHpHLaBsbr0V5mF09URYLXkt7iheBIdcP4fk
         tFtpbPvR6ypEM372qzlMVdXDXdXv5UpVR7Y7M/ui/kGIBt42iBmC9lGbdD1DLjE1KM23
         Qs8OUl02sEH6IlNzakQMDa2X6JY+d839mdLcJHDLCnyePwNKyvloaz6ZH9KmlAP51wEr
         2N9w==
X-Gm-Message-State: ALoCoQl7MAP8jFUusitOikWXwBFtJuug6tvc7KYhyJo+G/hL3ptQJcJO+d7mGJu04ebrl4sRG2vn
X-Received: by 10.194.77.167 with SMTP id t7mr19657142wjw.27.1381543355681;
 Fri, 11 Oct 2013 19:02:35 -0700 (PDT)
Received: by 10.227.204.72 with HTTP; Fri, 11 Oct 2013 19:02:15 -0700 (PDT)
In-Reply-To: <20131011223151.GC79408@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235937>

On Fri, Oct 11, 2013 at 3:31 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Oct 10, 2013 at 01:14:28AM -0700, Shawn Pearce wrote:
>> Even if you want to live in the fairy land where all servers support
>> 100-continue, I'm not sure clients should pay that 100-160ms latency
>> penalty during ancestor negotiation. Do 5 rounds of negotiation and
>> its suddenly an extra half second for `git fetch`, and that is a
>> fairly well connected client. Let me know how it works from India to a
>> server on the west coast of the US, latency might be more like 200ms,
>> and 5 rounds is now 1 full second of additional lag.
>
> There shouldn't be that many rounds of negotiation.  HTTP retrieves the
> list of refs over one connection, and then performs the POST over
> another two.

Why two connections? This should be a single HTTP connection with HTTP
Keep-Alive semantics allowing the same TCP stream and the same SSL
stream to be used for all requests. Which is nearly equivalent to SSH.
Where SSH wins is the multi_ack protocol allowing the server to talk
while the client is talking.

>  Regardless, you should be using SSL over that connection,
> and the number of round trips required for SSL negotiation in that case
> completely dwarfs the overhead for the 100 continue, especially since
> you'll do it thrice (even though the session is usually reused).  The
> efficient way to do push is SSH, where you can avoid making multiple
> connections and reuse the same encrypted connection at every stage.

SSH setup is also not free. Like SSL its going to require a round trip
or two on top of what Git needs.
