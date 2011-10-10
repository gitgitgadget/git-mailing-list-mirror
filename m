From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Tue, 11 Oct 2011 05:09:41 +0530
Message-ID: <CAMK1S_jNhB_cuTV0u+o_RwOdMKa-xXNZp8KGQ63yqFc70zTm5g@mail.gmail.com>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
	<7vbotwdbjg.fsf@alter.siamese.dyndns.org>
	<CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
	<7vty7oblpu.fsf@alter.siamese.dyndns.org>
	<CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
	<20111006125658.GB18709@sita-lt.atc.tcs.com>
	<7v62k210pj.fsf@alter.siamese.dyndns.org>
	<20111006181522.GA2936@sita-lt.atc.tcs.com>
	<7vwrcgtvh4.fsf@alter.siamese.dyndns.org>
	<20111008131015.GA28213@sita-lt.atc.tcs.com>
	<7v8voslg4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 01:39:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPRj-0007cc-KT
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 01:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab1JJXjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 19:39:43 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55772 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1JJXjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 19:39:42 -0400
Received: by qadb15 with SMTP id b15so4309639qad.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lsY5U6Vua2tuA+4+dxP33bl+bXJ3IhWp1Q1ClP2tu2E=;
        b=XdhzP2l90YR7iIuBJeK0n48h5wboyV5IsXPhEkszheyPFTAyCwpG3zWqYTZo+Rh8Du
         a7bDZtsxwSFmWRYM6o8hOexxb8lFZSy9aZrdr6E/6Q4BSmTfheVbK50iySdD/0SUaOgM
         q5FuEye3UCOv2gp9XxfYM3B00SR/7SOTC+3Zc=
Received: by 10.224.218.9 with SMTP id ho9mr12705839qab.56.1318289981801; Mon,
 10 Oct 2011 16:39:41 -0700 (PDT)
Received: by 10.224.20.67 with HTTP; Mon, 10 Oct 2011 16:39:41 -0700 (PDT)
In-Reply-To: <7v8voslg4l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183269>

On Tue, Oct 11, 2011 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:

> I also wondered if this is easier to read:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe | stdin_contains m2 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! pipe | stdin_contains master

> but I do not think it is (we cannot say "pipe | ! stdin_contains mast=
er").

Agreed on both counts.

"pipe | ( ! grep master )" does work, but I suspect that is an
inconsistency in the shell so I didn't want to use it.  IIRC the "(
list )" constrict is not supposed to make *that* much difference.
Have to check when I have time.

> In any case, here is what I ended up queuing. =C2=A0Thanks.

> +stdin_doesnot_contain()
> +{
> + =C2=A0 =C2=A0 =C2=A0 ! stdin_contains "$1"
> =C2=A0}

(facepalm) Why didn't I think of that!

Thanks :-)
