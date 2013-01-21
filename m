From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v3 08/31] parse_pathspec: add PATHSPEC_EMPTY_MATCH_ALL
Date: Mon, 21 Jan 2013 15:12:56 -0800
Message-ID: <CANiSa6gfTxOWzMg7V19PntDBhU4kW6qpa+K2XjnWgzNRXDKRSw@mail.gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
	<1358080539-17436-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:13:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQYJ-0007pK-QH
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab3AUXM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 18:12:58 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:55593 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab3AUXM6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 18:12:58 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so1644381wey.14
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=jGrTrbMOVYzX5DCZ+hJmsg7kZ0k8kQZZ+bE6bjNHXQk=;
        b=b5amOlwtYniJU0MbwoIbCQmMBQGK1lKLfSey8rq97/Z/ipjUKS8KED4MZ9vZkw9lRO
         OnkrbKGEaSoGnGkMDUMMk8QulZYLCS/G+t6dHXl0/uPRrJS5psQRjqx4VWL+mvnv9hq4
         2Cj/TtbRXwcQ37MaWy7XcDW/XUSC82VGioFJ+w3f8xn0IPr31NzHfyFMcqOKKMt2oDlk
         /NhDIk7FTqLYcDsDLzMUQ1lxeNZn2xehoE+zmEoENsfy/fLH1dxYIwFTXmcNzdnoPSGv
         yMLWURvGPEgIf+FkBrD/LFpkxDgRBc1A9LgKpy0NJIxAz0igiWwma0sep4LqD3sOMSNa
         n6sw==
X-Received: by 10.180.85.103 with SMTP id g7mr18046158wiz.29.1358809976681;
 Mon, 21 Jan 2013 15:12:56 -0800 (PST)
Received: by 10.180.85.8 with HTTP; Mon, 21 Jan 2013 15:12:56 -0800 (PST)
In-Reply-To: <1358080539-17436-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214172>

Hi,

I was tempted to ask this before, and the recent thread regarding "add
-u/A" [1] convinced me to.

On Sun, Jan 13, 2013 at 4:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> We have two ways of dealing with empty pathspec:
>
> 1. limit it to current prefix
> 2. match the entire working directory
>
> Some commands go with #1, some with #2. get_pathspec() and
> parse_pathspec() only supports #1. Make it support #2 too via
> PATHSPEC_EMPTY_MATCH_ALL flag.

If #2 is indeed the direction we want to go, then maybe we should make
that the default behavior from parse_pathspec()? I.e. rename the flag
"PATHSPEC_EMPTY_MATCH_PREFIX" (or something). Makes sense?

Btw, Matthieu was asking where we use #1. If you do invert the name
and meaning of the flag, then the answer to that question should be
(mostly?) obvious from a re-roll of your series (i.e. all the places
where PATHSPEC_EMPTY_MATCH_PREFIX is used).

Martin

 [1] http://thread.gmane.org/gmane.comp.version-control.git/213988/focu=
s=3D214113
