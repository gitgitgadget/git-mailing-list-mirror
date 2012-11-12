From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Tue, 13 Nov 2012 00:03:21 +0100
Message-ID: <CAMP44s0B42yt8eugYSjYweoX8WOXXF1f-0N-5FuUyrY5rgCiow@mail.gmail.com>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
	<1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
	<1352760759.18715.7.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY32X-0003Eb-MI
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab2KLXDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:03:24 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45382 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab2KLXDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:03:23 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6814307obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 15:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rth9zFTJV6bz8U/gCO/ah2V8Uz2OvV4pqXEurjtPN0E=;
        b=cyN7X1An0yLYpmqsm3U57CRDsdcXJAOrvZGyoj+OKVW8TvkJbGnhB5wG1U2xhLUdGM
         qXzTRltDcFPGqJecg7/lnw5gzQJS9IEf1XB46MZcjN7AXJ29MN88p+HKkpzd+jOGoWS3
         0OtUXWe1mCPz0tyHs3cgtXeZY6vT2bTFMCvDvV0osq0NhgGjInbSd6VhKWGgRKj1kYt3
         8cRDYThTXg/tgj4QS1aGTXC02P0nCtvrlwkdWLXbVgZXy9Am4whBQRtJb++5DGP6XY6U
         bbPbXy4EueSiY0o3OCgKab7+FA+KA64oM8e0b2vJ8ffvlTWDvNYRPvxB/odT0RXGCnIX
         ypwg==
Received: by 10.60.26.234 with SMTP id o10mr15526550oeg.85.1352761401812; Mon,
 12 Nov 2012 15:03:21 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 15:03:21 -0800 (PST)
In-Reply-To: <1352760759.18715.7.camel@joe-AO722>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209539>

On Mon, Nov 12, 2012 at 11:52 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2012-11-13 at 03:21 +0530, Ramkumar Ramachandra wrote:
>> Felipe Contreras wrote:
>> > cc-cmd is only per-file, and many times receipients get lost without
>> > seing the full patch series.
>>
>> s/seing/seeing
>>
>> > [...]
>>
>> Looks good otherwise.
>
> s/receipients/recipients/ too
>
> Practically this is ok but I think it's unnecessary.
>
> Output from git format-patch is always in a single
> directory.

A temporary directory.

> My work flow is to use a script for --to and --cc
> lines that can be set to emit the same addresses for
> all files in a patch series or generate different
> addresses per patch file.

For --to-cmd and --cc-cmd? So basically you check the dirname of the
argument passed?

While that works, it means you have to run the same command multiple
times, one for each mail.

If the command is using something expensive such as 'git blame' and
you have many patches, this is particularly bad. Also, it's not
elegant :)

-- 
Felipe Contreras
