From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 16:45:15 -0500
Message-ID: <CAPig+cRHTs9q4k=CqtY2j=ZtTYMU6_SPeCHkQe4m5AGXOjg_Ww@mail.gmail.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
	<CAPig+cRozqCKdC2+nyG-UM6xFo_sSqa7OhGgcycyyDQujZHtHA@mail.gmail.com>
	<xmqqfuxt9ti3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLe6a-0007ag-0i
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbcASVqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:46:20 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35896 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757664AbcASVpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:45:16 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so11144129vkg.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=I6Yw4ykTD7P7C9u2DgQJS9eCxEUkoe8J0+Bn7kkGDFM=;
        b=0wVn5WV0GK+9eRAn8i0DdQiS93HcCwEfxybtOSSiAgw2zRBc0KD4xenYzap7UG8O06
         VCoQ80KoXpljj/VZR4kGjzajVzTTUJcZr0oGIGh5y7JzIFGlkd2S30Qrg/bw3ltqYcvg
         55iDP2cAHKwTTpWUb7I/+pdFgXWwXjlG+FIuOu3QXRbnZm0bTgp01r45GCdnOzIJT6OM
         qXaRMjJFMJVKxrZ4tJ5R7hh5YCxOncTF0YTZjpEZ07NrgyOyjbQ6X1wXmRjEcsBgM9km
         5++9LSNRBOKbw4L0iXJ93IYA/L8YgL73VP/LibOnSqf+pJOr1G7eNfvdUeVKZBr0IP+7
         V0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I6Yw4ykTD7P7C9u2DgQJS9eCxEUkoe8J0+Bn7kkGDFM=;
        b=RoMdOOzJss9wnG/k28O4fkcxVNs7h9vM7jRDJfaKEAuRJWn9CLwUOeOISsPEdVEZW9
         OSVBsbSzgeRXBEzA7k495ZGQ7o5dTysuBQTsI7cpgKdZI6MDivBGEaDn1SKTdYErmxnX
         kDRTNlUpwuAPvbNBUMqbWNq4wHq9eaesq+pBKN0hNczSyODNRTENCnT+ytUZ9EhcFwiU
         ddoChMTYBZagrDZX8aN/FMJwikuJ9KelgaqswXTqkUnuRzGeL15XY8uOi7+UbqdFHhqE
         BGbXsTDOCXPYadNT2Zw9DBWXJoAlq/bkolInbPeeeU9sFDJ87pAUrbQGezIw8LaWXCBd
         GBmw==
X-Gm-Message-State: ALoCoQk+unHUGUomtjDUFfznY55vR/sJ8YiT9ZtZceGc82fOkO2WMe01XTjGabnvdUqcc095ocyGR727iT6E12LZnZyg7eCfEg==
X-Received: by 10.31.164.78 with SMTP id n75mr23205305vke.14.1453239915706;
 Tue, 19 Jan 2016 13:45:15 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 19 Jan 2016 13:45:15 -0800 (PST)
In-Reply-To: <xmqqfuxt9ti3.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: hKJnvd3BG_lh8o6tKnTEbsO8m74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284382>

On Tue, Jan 19, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> My understanding is that SANITY is an expectation that directory
>> permissions work in an expected POSIXy way: that is, a file can't be
>> deleted when its containing directory lacks 'write', and a file can't
>> be read/accessed when the directory has neither 'read' nor 'execute'.
>> This doesn't say anything about root not being allowed to read a file
>> when the file itself lacks 'read'.
>
> In short, SANITY is "does looking at permission bits sufficient to
> anticipate what the filesystem would do?" while POSIXPERM is "can
> chmod be used to tweak permission bits of the filesystem" (a
> filesystem that lacks permission bits support would qualify as
> !POSIXPERM, as there is nothing to tweak in the first place).
>
> I suspect the comment added by f400e51c and its patch description
> stressed too much about permission of a directory affecting what we
> can do to files inside the directory, and failed to describe another
> criteria for a sane environment: "files whose permission bits say
> you shouldn't be able to read or write cannot be read or written".

You suspect correctly. It was exactly the comment added by f400e51c
that misled me. (t/README does, on the other hand, mention "root", as
I noticed after reading your previous response.)

Thanks for spelling all this out. Hopefully, others reading your reply
(now and later) will be less confused than I.
