From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Tue, 27 Aug 2013 09:25:27 +0200
Message-ID: <vpqsixvfvdk.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
	<xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
	<vpqhaeckfbh.fsf@anie.imag.fr> <vpqr4dgizhm.fsf@anie.imag.fr>
	<CAMP44s1dNHi5Xg9KPp_717BMfAem-H8YOv5c+K9-2b-Aewpe3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 09:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEDf9-0002UP-Es
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 09:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab3H0HZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 03:25:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47431 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab3H0HZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 03:25:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7R7PRgd025161
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Aug 2013 09:25:27 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEDea-0002HQ-6r; Tue, 27 Aug 2013 09:25:28 +0200
In-Reply-To: <CAMP44s1dNHi5Xg9KPp_717BMfAem-H8YOv5c+K9-2b-Aewpe3w@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 26 Aug 2013 11:28:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Aug 2013 09:25:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7R7PRgd025161
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378193133.04984@+PnxvG6/pJhkXPeWyaFJxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233076>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Aug 26, 2013 at 4:16 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>
>>> Ideally, it would be possible to ask for a non-update without a fatal
>>> error on old Git versions, but this is not possible (hence, my fix is
>>> the "portable" one, that works on Git 1.8.4).
>>>
>>> But that's probably the best we can do now.
>>
>> ... and a patch implementing that would look like:
>
> This is exactly what I meant by only update when a feature has been
> flagged.

OK, I didn't understand you meant patching Git itself for that. So it
makes sense to turn my toy patch into a real patch I guess. Any comment
on the capability name? I used dont-update-private, which is a bit long.
The actual precise name would be dont-update-private-for-push, but
that's really long. Any better idea?

Just to be sure: you originally wrote "update the remote namespace only
when a certain feature has been flagged". My patch differs in two ways:
it's opt-out, not opt-in, and it's about updating the _private_
namespace, not the remote. Any comment on what's the best behavior?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
