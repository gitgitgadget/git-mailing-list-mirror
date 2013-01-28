From: =?UTF-8?B?0JDQvdC00YDQtdC5INCR0LDRgNCw0L3QvtCy?= 
	<admin@andrej-andb.ru>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Tue, 29 Jan 2013 05:33:49 +0700
Message-ID: <CAJjU7bQtgaV1XBeeGnuwtz8m3bDtmRYxQE-QasWkoGHNb_NPjQ@mail.gmail.com>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
	<20130128205834.GC7759@google.com>
	<7vfw1lug6f.fsf@alter.siamese.dyndns.org>
	<20130128221026.GE7759@google.com>
	<7v7gmxuekl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzxHI-0003XC-5m
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 23:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab3A1Wdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 17:33:51 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:52660 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3A1Wdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 17:33:50 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so3329482oag.37
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrej-andb.ru; s=google;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=IHdRG8dga9RzpfzrquJhbxE0XXEkNELLleUPKrQJNs0=;
        b=NtL2Q8NYZbDPutGDgbXMnFO0Qqg35A7vJ3ZmWU2wBr1vgBBvICzvpQGX8oAqN4Wo4i
         TVnYxblRcy3I71eQMqJS9LRzlYicxgsSJQjV2KsztKuerPqGE0WMpNUDmQVJrnycn6op
         TC0Bcw9Dz21z9kvP/bxeCAO9jQUbW4SZVIfN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=IHdRG8dga9RzpfzrquJhbxE0XXEkNELLleUPKrQJNs0=;
        b=TD0NI+kL4hS+1LOF2oCKu5KRJG+QPT6SkAoiydo5o4etZUeh8qxL94pEnQjKbl9MAP
         PWNK9Q3uucipj8AEm2C96CrlP4O9HfQjxnjXrZp6EEnDP9gSTd0rGo66NwZHk8EnchBI
         o/YmiLlK1XnIXjBvzeHrItH09rGXzFHuxCWdsGZqxvYWLAID0epPiq0pdwGBkrnIowIK
         LtwHJ3GwP8rFxm9EFgMQS0UuHT0CwJqD1+ZS7w15sUTML10RE3G0hxCxMa9opgPv6rso
         jQZOa6VNw+homCFtFHTsxH+ftRFA+34Fajc5e3UzKIe3pub0A/m/KnptNcg+gg2CqK/d
         cYRw==
X-Received: by 10.182.95.173 with SMTP id dl13mr12622125obb.43.1359412429744;
 Mon, 28 Jan 2013 14:33:49 -0800 (PST)
Received: by 10.76.9.35 with HTTP; Mon, 28 Jan 2013 14:33:49 -0800 (PST)
X-Originating-IP: [90.188.9.189]
In-Reply-To: <7v7gmxuekl.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmraZf/5pKyHGBaSq5an7+DznuS69lVoufC00OcuAxVfFuHg30FoRyFUzLCx8qe8ce1dPit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214883>

Or maybe option like:
/etc/gitweb.conf:
$feature{'ssl'}{'default'} = ['allways']; ['auto']; ['none'];

but it's hard for me :) i don't know perl

2013/1/29 Junio C Hamano <gitster@pobox.com>:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>>> Andrej Andb wrote:
>>
>>>>> --- a/gitweb/gitweb.perl
>>>>> +++ b/gitweb/gitweb.perl
>>>>> @@ -2068,7 +2068,7 @@ sub picon_url {
>>>>>    if (!$avatar_cache{$email}) {
>>>>>            my ($user, $domain) = split('@', $email);
>>>>>            $avatar_cache{$email} =
>>>>> -                  "http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>>>>> +                  "//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>> [...]
>>> Intuitively it feels strange that the above lets the site that gave
>>> you the base URL dictate over what scheme sites unrelated to it has
>>> to serve their resources.
>>
>> The main effect is to slightly improve privacy.  A man in the middle
>> can still see the size of avatars and when you fetched them, but at
>> least this way when you are using HTTPS they do not see the names of
>> authors of commits you are looking at.
>>
>> It also avoids a mixed content warning.
>>
>> On the other hand, it hurts caching by proxies.
>
> I am sure mixed content warning was the primary motivation of the
> patch.  Do we know these external sites actually server what we want
> over https://?
>
