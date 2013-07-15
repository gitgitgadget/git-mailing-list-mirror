From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a
 shallow clone
Date: Mon, 15 Jul 2013 08:01:40 +0700
Message-ID: <CACsJy8Bx_o+9S1N_uieQaV8NBbc3T_MR_VCvF+fM==Dy-vt7tw@mail.gmail.com>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
 <20130713212541.GA10951@google.com> <CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
 <7vfvvhgeif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 03:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyXBP-0008D8-EY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 03:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab3GOBCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 21:02:12 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:53618 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab3GOBCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 21:02:11 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so15256138oag.30
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yktU6YWU1stB5gWXBg90vd1BsIz7o75xt4w2NzJbHA4=;
        b=msVNcXgz8uirq2IqqdaNkRGdKA7KGfx04y45ZfxWd2/3pdKk+jxv6+aiZHan1r4fXU
         gv7rR9GwuQdEnGleFRxoieQ8sX29r8uQ+IJ/ntBukxSsMa+asq2D5yiBpE4JKVElhUBi
         pufPXG9a/RL/tvEHJqBYeQ+1vJJENcTp32Emwy+4w7yHKNF0ucO61H1sXKv6BdLAAcUr
         yKxekHnz2QlvAxYA1pOIxG9KETLD+0hixji0MsAcmsT1+vD6uaYmnx7rWrqRPLzNcZlj
         kC543a31KlLG1FSJIT5j1bKnc7lw3rEAOIeOFQv1sjPAhKRFDtUxtNHgehHXBDkUQ/GX
         fGlw==
X-Received: by 10.182.214.39 with SMTP id nx7mr42124548obc.20.1373850130763;
 Sun, 14 Jul 2013 18:02:10 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sun, 14 Jul 2013 18:01:40 -0700 (PDT)
In-Reply-To: <7vfvvhgeif.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230403>

On Mon, Jul 15, 2013 at 1:52 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Jul 14, 2013 at 4:25 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>> Hi,
>>>
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>>
>>>> Since 52fed6e (receive-pack: check connectivity before concluding =
"git
>>>> push" - 2011-09-02), receive-pack is prepared to deal with broken
>>>> push, a shallow push can't cause any corruption. Update the docume=
nt
>>>> to reflect that.
>>>
>>> Hmm, what happens when pushing to servers without that commit?  Do =
you
>>> think it should be applied to Debian squeeze for server operators t=
hat
>>> haven't upgraded yet to the current stable release?
>>
>> This is pushing _from_ a shallow repo, where the sender repo's old
>> objects is a subset of the receiver's.
>
> The "subset" assumption does not necessarily hold, does it?  The
> receiver may have rewound its tips and pruned since then.
>
> Also, the sender may have cloned from the receiver (fully) and then
> fetched a different history shallowly from elsewhere.  The receiver
> may have no commit on that history, including the shallow-bottom.
>

Hmm.. right. And the receiver needs to setup proper graft to seal the
shallow bottom. So it's really not safe to do pushing from a shallow
repo without 52fed6e
--
Duy
