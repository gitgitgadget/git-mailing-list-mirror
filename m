From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] branch: teach --edit-description option
Date: Sun, 25 Sep 2011 15:21:17 +1000
Message-ID: <CACsJy8BdLKdT-CiBBD1FmnSo3ZBcRQmMst7FN2fmDrgvzqbyng@mail.gmail.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <1316729362-7714-4-git-send-email-gitster@pobox.com> <20110923094721.GA8397@duynguyen-vnpc>
 <7v62kjulkf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 07:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7hAK-0005qm-Ao
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 07:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030Ab1IYFVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 01:21:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51704 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1IYFVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 01:21:48 -0400
Received: by bkbzt4 with SMTP id zt4so4670068bkb.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mNyfA3xivpRvtq46LmxPiL+JVsMdA5nn6GfjRnO1zkU=;
        b=upGWa1+72FHdf5M0iFa+fGe3SmC+n4tnBUY+8/O1bzR7HyPOJQwtIDx/mDsUlOW5pR
         H72wywN/HfYl7eoM+kJMXUVHwEBI6cP2Ga2siyHiuAOJx6GSwv4Ago/9GDmY4w9JCm+w
         tMVMn3qbkrGpTo3YeojFi80SGJBhP/F4biIIw=
Received: by 10.204.145.25 with SMTP id b25mr490734bkv.27.1316928107227; Sat,
 24 Sep 2011 22:21:47 -0700 (PDT)
Received: by 10.205.114.134 with HTTP; Sat, 24 Sep 2011 22:21:17 -0700 (PDT)
In-Reply-To: <7v62kjulkf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182059>

On Sat, Sep 24, 2011 at 5:04 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Sep 22, 2011 at 03:09:19PM -0700, Junio C Hamano wrote:
>>> + =C2=A0 =C2=A0if (launch_editor(git_path(edit_description), &buf, =
NULL)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_release(&buf);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>>> + =C2=A0 =C2=A0}
>>> + =C2=A0 =C2=A0stripspace(&buf, 1);
>>> +
>>> + =C2=A0 =C2=A0strbuf_addf(&name, "branch.%s.description", branch_n=
ame);
>>> + =C2=A0 =C2=A0status =3D git_config_set(name.buf, buf.buf);
>>
>> I suppose a Windows editor mave save the description with \r\n
>> ending. Perhaps a patch like this to avoid messing up config file?
>
> Doesn't stripspace() cleanse that already?
>

Yes, isspace() indeed treats \r as a space and stripspace() does the
right thing.
--=20
Duy
