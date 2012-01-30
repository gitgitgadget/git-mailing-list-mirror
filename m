From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 21:22:50 +0200
Message-ID: <CAMP44s0dU5zQLnen_DSONOum7P1UsPTASSkF1sJE2m7kAwx21A@mail.gmail.com>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
	<1327944197-6379-5-git-send-email-felipec@infradead.org>
	<20120130175324.GH10618@burratino>
	<CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
	<20120130182547.GA22549@burratino>
	<7vliopatxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:23:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrwoa-0007me-1c
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2A3TWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 14:22:52 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:54861 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753202Ab2A3TWv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:22:51 -0500
Received: by lbom4 with SMTP id m4so333474lbo.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bVcI38NyTkUrn5r/7SJvq4b5s85xN6xvHw0LWM+Kee8=;
        b=hBQ6SaZ1corbPhxfAo0Z+WyR3IvVYW59TbTxuXpvmqifHU8uz4ffUswEScpBAx5Rr3
         ywY2hBZ4CnppiNY7+pyniLjysxEm1zqP4sE3Rn/nPlH3pZ3T093dQRS1Uw5IOAIIlbmD
         t3wEo3CqipQ8Bk5pa9aqFmVGZXXVuXdI7dhak=
Received: by 10.112.48.65 with SMTP id j1mr4777003lbn.76.1327951370050; Mon,
 30 Jan 2012 11:22:50 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 11:22:50 -0800 (PST)
In-Reply-To: <7vliopatxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189404>

2012/1/30 Junio C Hamano <gitster@pobox.com>:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Felipe Contreras wrote:
>> ..., so I suppose consistency is the only reason to
>> prefer one over another.
>
> Yes. And the script may probably use [[ very heavily.
>
> Early return after || i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A || return
> =C2=A0 =C2=A0 =C2=A0 =C2=A0B
>
> simply looks ugly and misleading, especially when the remainder B is =
just
> a single line. =C2=A0But I stopped caring about the styles in this pa=
rticular
> script long time ago, so...

What would you rather use?

[ "$__git_merge_strategies" ] &&
__git_merge_strategies=3D$(__git_list_merge_strategies)

That's 90 characters long. Although much better without the 2>/dev/null=
=2E

if [ "$__git_merge_strategies" ]; then
  __git_merge_strategies=3D$(__git_list_merge_strategies)
fi

That's even more lines =3D/

--=20
=46elipe Contreras
