From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Mon, 4 May 2009 11:39:53 -0700
Message-ID: <780e0a6b0905041139x3a764768ocbbd8d9353ea568f@mail.gmail.com>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org> <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Mon May 04 20:40:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M135V-0003Ng-JE
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 20:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZEDSkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2009 14:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZEDSkO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 14:40:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:16085 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbZEDSkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 14:40:13 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2321020yxj.1
        for <git@vger.kernel.org>; Mon, 04 May 2009 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vB/WpHYLMmhlqppA8L6GbIh7WmQ76JXNz50O9M8s/OY=;
        b=MQ71EYNynpK4UVoGDqrAC+wGaQHrjVw89JFrTldxlzoEwXryY5Fly5qfAasv/EULTn
         YT0vgo6xwqNg7Ch8GE5ShvzVVwOuoKcuGZw7H9MUwbmIwlEC5amPSGKWYfUirzqkKf1E
         IOw2Ea5meIk9s5Kk8Zp17z7wGdZHqRnjXWHwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s3lXOui7DFUPRkdurF/Aqd0WqjzdiyfGregZ530K6JncwlRWx04/oLEF2Lct7I4uKd
         3Gnsk39NG5gVRhDEnx3pdn/3CEDTqP4/wt8b+6mLqAvqInTqMr12GGIK5avXm1tTwslB
         XQtsVSLauIvE1XeATbullJLzoKwJDdmuuEFlA=
Received: by 10.100.6.13 with SMTP id 13mr13726960anf.98.1241462413229; Mon, 
	04 May 2009 11:40:13 -0700 (PDT)
In-Reply-To: <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118255>

On Mon, May 4, 2009 at 2:59 AM, Frank Terbeck <ft@bewatermyfriend.org> =
wrote:
> An exception is if it is called using the --stdout option,
> which disables format.coverauto, because users of --stdout
> (like git-rebase.sh) usually are not interested in
> cover letters at all.
>

Would it make more sense to just have git-rebase.sh use
--cover-letter=3Dnever? I thought configuration variables were defaults
which have to be overridden.

Also, why does this variable even exist? I think Jeff's suggestion is
best, where you can set format.coverletter to always, never, or some
number.

> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp(var, "format.coverauto")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cover_letter =3D g=
it_config_bool(var, value);;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }

Double semi-colon?

=46inally, this option is very useful, so keep up the good work.
