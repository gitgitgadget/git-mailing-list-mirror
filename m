From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git diff --chunk-pickaxe?
Date: Mon, 22 Jun 2009 23:04:06 +1000
Message-ID: <fcaeb9bf0906220604ubb9db7v9ea37416080eecd7@mail.gmail.com>
References: <fcaeb9bf0906220507q45a61dc3w25ad41a4a65a2d5a@mail.gmail.com> 
	<4A3F7DAC.3090709@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 22 15:04:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjCM-0001hJ-4d
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbZFVNEZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 09:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbZFVNEY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:04:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:19671 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZFVNEX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2009 09:04:23 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1857849ywb.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eeGkLO1jAvVHOHsYh59cOz28SlkpYnOEG7xdCraMH2I=;
        b=SeKzvf2qLIIwgMKLnx/U8aJtC/HneLuitF+bSeYUmDGmedG+p4EetH04DDe7AIoej5
         Nr6j52CB1fJ6B9471GtOXqE3jdulYCHM19Ij3qz8l7PR4BFrwVaPxYz6SgnrHJASd1Gn
         h8aq1VTtMaWvmfitYs6XR8c3DQRSkSqMWKB8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=US4zuu6jc7XT29/ztLs5eGpKOpLDLOoU0+lSZfefZp4vSCyHkMwZ8tzrWw8lTfBPja
         RNMoHV6UQR6hmfy44RoQnQipVb9RwwChYl3/em3ZUROwSwzKbblFteIe10nVR3XvTe2K
         i53n7hlj3jA7MBS7w39h8M/A9HTQF/Bx9LdlM=
Received: by 10.100.255.7 with SMTP id c7mr8059523ani.171.1245675866121; Mon, 
	22 Jun 2009 06:04:26 -0700 (PDT)
In-Reply-To: <4A3F7DAC.3090709@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122034>

On Mon, Jun 22, 2009 at 10:48 PM, Ren=C3=A9
Scharfe<rene.scharfe@lsrfire.ath.cx> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>> What I want is only show diff chunks that add or remove a line that
>> does not start with '#', something like a chunk-level pickaxe. Any
>> pointer where to start? It looks like I can start from
>> xdi_diff_outf(). Just wanted to make sure I won't follow a wrong way
>> from the beginning.
>
> How about creating an external diff driver instead? =C2=A0It could re=
move all
> lines starting with '#', or normalize such lines to just '#' in case =
you
> need the line numbers to remain unchanged, then write the filtered
> result into temporary files and compare them with diff. =C2=A0Perhaps=
 this is
> sufficient for your purposes? =C2=A0It should be easier to implement.

Yep. Jakub mentioned textconv privately, which should be enough for
review purpose. However I'm not completely satisfied with it. Let's
say I'm done review and happy with most of the translated strings. I'd
like to commit those strings only (whether comments are committed does
not really matter because I can filter them out with textconv). If I
start "git add -p" up, I'm in trouble again.
--=20
Duy
