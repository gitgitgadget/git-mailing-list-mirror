From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH 1/2] diff/status: refactor opportunistic index update
Date: Mon, 21 Mar 2011 19:46:22 +0100
Message-ID: <AANLkTinUqzgpiX_X+kpUuOSxNqRVp+OC1HOreEkF6yhX@mail.gmail.com>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
	<7vipvcs9xt.fsf@alter.siamese.dyndns.org>
	<7vtyewqtmk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1k7Y-000397-2K
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab1CUSqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 14:46:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53446 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1CUSqW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 14:46:22 -0400
Received: by vws1 with SMTP id 1so5304812vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t5spNjxWiR5PJ8AEwLLnQC3AZdg9wqbLXe0UaJQr3sQ=;
        b=iq7rFXKPlfjim7NV2PIryDeYOsv//kdW3an9KQ2lGj2sfq8bEgKyHIGVKXF0D98sNH
         wwA79F+ac4fMQrk63lQySnY5grX8EP3Laqi4htGil39Eo0SDj6/iWssTcqaSbI+X3vwd
         MFedjxqFWk0gnHH05vJ2P9CstinA97EmWPL1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kGV0W/bPlwBpPY7fo4QAKhFxW2YCO4pLXzesM1SOTxRLheocadr1Zi8bkv0P7mOx7Z
         iJnlFNFSgmh1g7Nrwa10FNwzNTDoIUI3xXmQ/lxL+NysG6CrMvX7r9DLQ6RKn5zd/2Ug
         nU4QrwfcyxYB9h9G+NlRmzA8jlZYbJdJU97gc=
Received: by 10.220.37.13 with SMTP id v13mr1282566vcd.31.1300733182052; Mon,
 21 Mar 2011 11:46:22 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Mon, 21 Mar 2011 11:46:22 -0700 (PDT)
In-Reply-To: <7vtyewqtmk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169642>

On Mon, Mar 21, 2011 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> +void update_index_if_able(struct index_state *istate, struct lock_fi=
le *lockfile)
> +{
> + =A0 =A0 =A0 if (istate->cache_changed) &&
> + =A0 =A0 =A0 =A0 =A0 !write_index(istate, lockfile->fd))

Mismatched parenthesis? Should be sth like

+ =A0 =A0 =A0 if (istate->cache_changed &&
+ =A0 =A0 =A0 =A0 =A0 !write_index(istate, lockfile->fd))

--=20
Piotr Krukowiecki
