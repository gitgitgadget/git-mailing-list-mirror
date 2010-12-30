From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/6] Introduce sorted-array binary-search function.
Date: Thu, 30 Dec 2010 02:06:28 +0100
Message-ID: <AANLkTimkemRW1H7XvwbECWUHHWVpGnvKukn06DiQO9Ce@mail.gmail.com>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
 <1291848695-24601-2-git-send-email-ydirson@altern.org> <7vwrnhb6tm.fsf@alter.siamese.dyndns.org>
 <20101230004027.GB6639@home.lan>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Dec 30 02:07:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY6ys-0004O4-3X
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 02:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab0L3BGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 20:06:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37948 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab0L3BGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 20:06:49 -0500
Received: by fxm20 with SMTP id 20so10880300fxm.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 17:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=XlTdtICWlltS+0a7gjRWucWiEN7fXqtsfcObAZqSGYE=;
        b=u/M80sVjqDnKVnkwDW2mKNIt64tKCImWcOvKgf3DiDM3qIDTqpPA3l6rahqPXzgQW6
         0cFbavgR3M5H5zdrRVcb0Alwao0kqditD3RBOZXWrpD/UIzk+zbhs8zvstgQEMx/4tVj
         SuXyn8RsjBrV+feB7TZ37jxE6rXMQcITX9WVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=mJG4d/9jsncpBNFYzF97dKYIqBhuXo8HOjBay/RjsF8SkRkoFah2j/kL9M/OlPwiVX
         o6X9Dj0CrQuTtsiG6EjZPuKXUZfL9z7AGEVO+pGnTZDtia9N58eWg4nm4Glk4EBzTT1U
         DFKhekVq2/N3tQPA17cc0WbGsSPCMDn7gKJ+g=
Received: by 10.223.86.193 with SMTP id t1mr906968fal.147.1293671208539; Wed,
 29 Dec 2010 17:06:48 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Wed, 29 Dec 2010 17:06:28 -0800 (PST)
In-Reply-To: <20101230004027.GB6639@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164345>

On Thu, Dec 30, 2010 at 1:40 AM, Yann Dirson <ydirson@free.fr> wrote:
> On Fri, Dec 10, 2010 at 02:29:09PM -0800, Junio C Hamano wrote:
>> In addition, these macros in this patch are almost unreadable, but t=
hat
>> probably is mostly a fault of C's macro, not yours.
>
> Yes. =A0When writing those I sorely missed the readability of C++
> templates - yuck :)

Unfortunately, it's something that ends up subtracting from the value
of the change; a couple of duplicate functions is often easier to
maintain than nasty macros.

Perhaps the pre-processor is not the right tool for the job? Some
times a generator (a perl script?) can be more readable.
Unfortunately, some times it's not :P
