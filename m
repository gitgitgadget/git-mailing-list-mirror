From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] diff --no-index: support more than one file pair
Date: Fri, 13 Jan 2012 00:40:27 +0700
Message-ID: <CACsJy8B460CwtACV+o0wnwqi1On_oEavLfDAL8f=w6kyfktKcQ@mail.gmail.com>
References: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
 <vpq39bll1ua.fsf@bauges.imag.fr> <CACsJy8BvA_o1+xrOx4hYhmwNWpsRnh5+mftb471h3yFW2b6vhA@mail.gmail.com>
 <vpqmx9te08z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOeB-00053v-L7
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab2ALRlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:41:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58262 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab2ALRlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 12:41:00 -0500
Received: by bkvi17 with SMTP id i17so1391605bkv.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jBuakYqtyccpTT/xojmNX4T/a7PCh+oP4M7KzhhY32M=;
        b=mNDvOjC/nOPxCcPKu1MRUz1+xFhuRNaSz1J2ffAv/IcnFvJY2wQlfQ/QzU9TZMthr7
         +Gu4fiAYMTbBliJ1fHOm9tH+5+VsLMpakv/VoLLjBljr+WiNT/XMDFEh/E0aFi89XH2I
         Y1W+efehZkfMZu6nkGfDa2ol+zZIJUN03rHyw=
Received: by 10.204.154.136 with SMTP id o8mr1588438bkw.112.1326390059249;
 Thu, 12 Jan 2012 09:40:59 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Thu, 12 Jan 2012 09:40:27 -0800 (PST)
In-Reply-To: <vpqmx9te08z.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188461>

On Thu, Jan 12, 2012 at 4:30 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> =C2=A0- might be easier to script (just throw them all to xargs)
>
> I don't see a use-case where a command produces old1 new1 old2 new2, =
but
> if there is one, then "| xargs -n 2 diff" is the solution. You don't
> need your patch.

Unthorough thought. I agree with you.

>> =C2=A0- hell, i might even benefit from git copy/modify detection
>
> I don't see how, if you specify explicitely the pairs (old, new). You
> may have such benefit if you let the command-line express "here's a
> bunch of old files, and a bunch of new ones", but not with your propo=
sed
> syntax.

That's what git gives to diff machinery: a set of file pairs, and the
diff machinery has to figure out copy/modify pairs, shuffling them up
if necessary. I simply cut of tree traversal part out and feed file
pairs directly to diff machinery. I remember long long time ago Junio
asked for assistance about code moving support within a file. It has
not come up (at least in public), but one can hope it'll come someday.
--=20
Duy
