From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv11 20/20] builtin-gc: Teach the new --notes option to 
	garbage-collect notes
Date: Thu, 21 Jan 2010 11:27:27 -0800
Message-ID: <780e0a6b1001211127u6304546ej4e5bffbceca12e0b@mail.gmail.com>
References: <1263762277-31419-1-git-send-email-johan@herland.net> 
	<1263762277-31419-21-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY2h8-00018p-6s
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 20:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab0AUT1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 14:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815Ab0AUT1s
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 14:27:48 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:51062 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab0AUT1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 14:27:47 -0500
Received: by pzk2 with SMTP id 2so243491pzk.21
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=foelnqqCm3W2nGGTCeXU2tbab6MMIwdlJ1kMaN4l8fk=;
        b=nFFWOPOAYask5DDocBjffMtY/UwkSlEwDN2n+tVIrTODkxBPwiiojrbkFBu+QAJ4G8
         vebcLUoUsj4+aNwWIamvzDgqNfkIzKbC07cy+CdNmMwDjmV7dAB0TT1gZTUThJvMVx0h
         qllEDxqOYAtzFEkKZsx9HmoY7AeVhCg/AvRb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=psGsBaprFixEOI0R8RIad17/yjYeTpAqcnhotJO/MQksg+W1gmtiZby3L03M+TzQTz
         ch2vECivnwR5TtDGsGqcKUsN5g6RwTAUil+ANcMOmfkeYZGC5Gg6m8pZx+rVx7ChfOOW
         UoVzNfkcOhH8Qy8KBThrEleFrxuq5DVz9yGOw=
Received: by 10.142.202.20 with SMTP id z20mr860457wff.227.1264102067080; Thu, 
	21 Jan 2010 11:27:47 -0800 (PST)
In-Reply-To: <1263762277-31419-21-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137685>

On Sun, Jan 17, 2010 at 1:04 PM, Johan Herland <johan@herland.net> wrote:
> The new --notes option triggers a call to gc_notes(), which removes note
> objects that reference non-existing objects.
>

Shouldn't notes be unconditionally garbage collected? Or maybe there's
a reason why notes should be treated differently that isn't written
here.
