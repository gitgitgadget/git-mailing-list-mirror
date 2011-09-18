From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH/RFC 0/2] fast-import: commit from null_sha1
Date: Mon, 19 Sep 2011 03:40:43 +0600
Message-ID: <CA+gfSn_WG_S+QJK5O_4D62KV78-77QO_gyy7PeFGRJYW4cQu8A@mail.gmail.com>
References: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
	<20110918213050.GJ2308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5P6X-000888-1J
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639Ab1IRVko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 17:40:44 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58208 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab1IRVko convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 17:40:44 -0400
Received: by qyk30 with SMTP id 30so2188080qyk.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Vhsj7exdq9Rgjj1uCeUUHG2WiYRQl+HbmNZG3DX93vE=;
        b=FkUSA1c+N5xz00DP885P1JvG9nO6uvQT/MtxspHFPKx9ikooo8dFaf/4OBgEysNfQ4
         WLKsxAzRYITrwqZITlI/GhIoWzxEcM/8v5pJq6bT7bKEcydQ2+HNjntu2pUnIVQGnOY9
         +BzdCF5U+iMEAjp03Z/P1v8QNbFmqHZkfXoWY=
Received: by 10.229.232.213 with SMTP id jv21mr1426821qcb.206.1316382043592;
 Sun, 18 Sep 2011 14:40:43 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Sun, 18 Sep 2011 14:40:43 -0700 (PDT)
In-Reply-To: <20110918213050.GJ2308@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181647>

On Mon, Sep 19, 2011 at 3:30 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dmitry Ivankov wrote:
>
>> These patches make fast-import treat
>> =A0 =A0 commit refs/heads/master
>> =A0 =A0 ...
>> =A0 =A0 from `null_sha1`
>> like any other missing parent sha1 - reject such input.
>
> Are you sure the existing support for "from 0{40}" is not deliberate
> and that no one is relying on it?
It is hard to guess. There is no test for it in t/t9300-fast-import.sh,=
 no
mention in the Documentation, but sometimes a user can see null_sha1
from git. I hope that it pops up only when something is read to simplif=
y
the format and never accepted in 'write' commands or as an argument.

> =A0If and only if you are, then this
> seems like a good idea (a single patch that both makes the behavior
> change and adds a test for it should be easier to review).
>
