From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple estimated time remaning
Date: Sun, 30 Aug 2015 09:52:50 -0700
Message-ID: <xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
	<CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
	<CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
	<CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Gabor Bernat <bernat@primeranks.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 18:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW5qj-00088v-Nh
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 18:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbbH3Qwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 12:52:53 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36213 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbbH3Qww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 12:52:52 -0400
Received: by pabpg12 with SMTP id pg12so6719187pab.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=M4uR1jy5bAVwDT6csXibliH53FX2OMNXBaws0U0rXP8=;
        b=mYJqM0Y3SC3tlmWKq1/g/lk/yY/PZW6zGzJEHVKGGWEeBZ4wEGZctRYKdOVfTauViZ
         NCjFqp2rSqPWRZgZvEy83ztlwQZhNxeNXo5D+dYPcro6awp/pm7bv/ChBT6LSt3xBp+0
         JIZ/mGemh00D1v9vIWx7mD3Yk41yED0B0SEdc5jsEcmNtonmJvbYyu0acJ7zWKFhvYzs
         gMQWt7L5v0o3XujM2l/S6r30Oz09/WKda4nyZI0DOUGS3mHqBGL+5gfG1RSbSpqBtVUY
         xypJUrfUsMH7qFngp6U9nUROZzfnyMdIiSRKL9UIjIQJGHuAuo+shubjkZur6ajCY+Ly
         fKIQ==
X-Received: by 10.68.113.37 with SMTP id iv5mr31370118pbb.104.1440953572211;
        Sun, 30 Aug 2015 09:52:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7887:edde:b54f:7986])
        by smtp.gmail.com with ESMTPSA id qu8sm11870664pab.29.2015.08.30.09.52.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 30 Aug 2015 09:52:51 -0700 (PDT)
In-Reply-To: <CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 30 Aug 2015 04:14:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276823>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>> Most portable likely would be Perl, however, that's probably too
>>> heavyweight inside a loop like this, even if called only once each N
>>> iterations.

I think that is true.  Now, when it is too heavy to spawn perl,
would it be light enough to spawn awk, I have to wonder.  Even if
the implementation uses awk, I think the time measurement should be
done only once each N iterations (e.g. every 1000 commits measure
the rate and divide the remaining commits with that rate while
displaying the progress; if you are chewing 100 commits per minute
and have 2000 commits to go, you know it will take 20 more minutes).

>> http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell
>> Found this,
>>
>> awk 'BEGIN{srand();print srand()}'
>>
>> srand() in awk returns the previous seed value, and calling it without
>> an argument sets it to time of day, so the above sequence should
>> return seconds since the epoch, or at least something in seconds that
>> is relative to a fixed point which is all that's needed in this
>> thread.

In practice this should work, but it makes me feel somewhat uneasy.

POSIX says "Set the seed value for rand to expr or use the time of
day if expr is omitted. The previous seed value shall be returned."
but I do not see anything that says that "the time of day" is
counted in seconds around there (which is the crucial bit for this
application).

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html
(4.15 Seconds since the Epoch) says "The relationship between the
actual time of day and the current value for seconds since the Epoch
is unspecified."
