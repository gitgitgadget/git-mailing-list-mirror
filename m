From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC] Add support for the google-chrome web browser
Date: Tue, 5 Jan 2010 13:56:13 -0500
Message-ID: <32541b131001051056o5853b1d2xd57d75d9a62f9f1a@mail.gmail.com>
References: <20100105051906.GA22799@efarrerlx.appsig.com> <7vr5q56rew.fsf@alter.siamese.dyndns.org> 
	<32541b131001050920j2a569ec8u8811f1b0358f21ef@mail.gmail.com> 
	<7v8wccz99g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Evan Farrer <evan.farrer@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:56:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSEaB-0006EB-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab0AES4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 13:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165Ab0AES4f
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:56:35 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:39837 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab0AES4f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 13:56:35 -0500
Received: by yxe26 with SMTP id 26so15892315yxe.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eFaXcs/GnffB8k6bCzeebDtejQyUoV5WRIHgfN5bYxo=;
        b=rE0RTKPueGSZfvfNHlUjiAVmrGinYXVk5PTf8vnYGf0SCGJu7YjSf8gFtZ0amPHpo7
         jR5IPhr8mn6GIpUzW6mjEbO2t7nG/5SoZeJ34CPJpwWW8c6la9IU+2kryAYO+jN2DG9F
         l1kTDvbvzW2xnqfCYv+GxLwo46X6eha0RbdUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Emz7xe29e2ZJ6FFCEarYUbLEErvHZSztnl1B7o/JmIRX5gnh5P7lqSm5Dw/8VGvKjZ
         QFaHz3nW+zwrXurS6GacByN8o5l2aAE4KqZ9l1de+zBatUV+5eUkhNfcB8gZmilZ2ZbG
         uqDkdvaeVqVIgGzmNBKsoQ9UEH8wh6g6zvlXk=
Received: by 10.150.65.9 with SMTP id n9mr10627197yba.187.1262717794075; Tue, 
	05 Jan 2010 10:56:34 -0800 (PST)
In-Reply-To: <7v8wccz99g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136203>

On Tue, Jan 5, 2010 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> On Tue, Jan 5, 2010 at 12:40 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Then we don't even have to add any specific support for "google-chr=
ome" or
>>> anything that takes "$command $path..." and opens the documents.
>>>
>>> Is there a downside in this approach?
>>
>> If someone has another firefox-derived browser installed with a
>> different name and tries to use it, this default wouldn't do the rig=
ht
>> "firefoxy" thing, and would instead fail strangely. =A0On the other
>> hand, right now it'll fail anyway, just not strangely.
>
> You probably didn't notice/understand why I singled out w3m/links/ope=
n and
> excluded firefox from the set. =A0There is no question that the ones =
that
> need custom command line need custom support. =A0But to support a new
> browser that takes a bog standard "command then args" command line, t=
here
> is no reason to add cruft, every time somebody comes up with a new br=
owser.

Yes, I'm probably missing something, that would be normal :)

My point is that, given a random browser name, you don't know whether
it's an easy one *or* if it needs to work more like firefox.

The current behaviour will barf right away (I think) because it
doesn't know.  If it instead had a default case that just assumed
non-firefox behaviour, then it would fail *strangely* (instead of
predictably) on browsers that needed special workarounds, such as an
as-yet-unknown firefox derivative.

Maybe this isn't important though.

Avery
