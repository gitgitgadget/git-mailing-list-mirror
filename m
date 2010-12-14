From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname concatenation
Date: Tue, 14 Dec 2010 14:10:59 +0700
Message-ID: <AANLkTintP4dMbJnterPBpWUJY77_JdmHJd+PWmKzzfuJ@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com> <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
 <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com> <7vvd2wvs0m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 08:11:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSP2v-00082O-CP
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 08:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab0LNHLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 02:11:32 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53133 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0LNHLb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 02:11:31 -0500
Received: by wyb28 with SMTP id 28so233873wyb.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 23:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=b/fxQ2ajpK5oOEwhqkGbMDLimyGYVmz/YRhRvb0w0T4=;
        b=Vf+w4TLSe40Q2jEFo9M4diMcr+Wry7zq9O1NL3IPjoxpB8DuJ9EKjAeehVfHK5/HEV
         40nUmcvYg52n032edU9jazp5VbmP/P9hwMZWzwuC3Z5QupXfG6zic+IdxdRLn8/3nxx8
         Ly2THdAqsBcH82v2cCKdT0mTdy9fyza+7rMU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WHDLOc8FmlcMGZRLqgKzG0+dLeuVhwK9iQIrdc+N5SKby0M878bwgjtOzdO+tJ33i2
         0ziXkD/xSmCtZBtUrNEvuk2+QJLUZPzBTZjxxRUvyq8V3EJnNY0+TJFeaTsUfpLsqIOC
         3RGSre3Eax00dYh1gI26u7ul1EuVrYcNKxixY=
Received: by 10.216.169.71 with SMTP id m49mr5525042wel.4.1292310689925; Mon,
 13 Dec 2010 23:11:29 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Mon, 13 Dec 2010 23:10:59 -0800 (PST)
In-Reply-To: <7vvd2wvs0m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163630>

On Tue, Dec 14, 2010 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> All paths should not exceed PATH_MAX, right?
>
> Your PATH_MAX may be a lot shorter than the PATH_MAX on the system I
> created my trees on that you are reading. =C2=A0Besides, you can crea=
te
> arbitrarily deep tree structure without busting the limit on the
> filesystem by writing tree objects by hand.
>
> In other words, all paths shouldn't exceed PATH_MAX, but the responsi=
blity
> to verify that is _yours_.

OK. I can check and die if any path exceeds PATH_MAX.
--=20
Duy
