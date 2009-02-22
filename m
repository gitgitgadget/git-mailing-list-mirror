From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B v4 1/5] git config: reorganize to use parseopt
Date: Sun, 22 Feb 2009 19:19:07 +0200
Message-ID: <94a0d4530902220919t729915dleed932b010ee76b@mail.gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
	 <7vskm62z9w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbI0N-0006Du-44
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbZBVRTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 12:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754343AbZBVRTK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:19:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:50707 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbZBVRTJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 12:19:09 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2540348fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ibGkyAlmSDmHI0w58/fPr25xCK5PmS6cxS8S/L8kB68=;
        b=ufsHNG7nJzOfzmmUkq/tkKCb6z4VivMQs2WgNJK9rdPBIFrqTMDhnouzfUGpedhrVD
         Rzjn+UvQ1x60bloBbsso5dI03v7PI/WM7TkmEcjDbmJLp7sPph4b36j9OU3D/0bes01K
         LEtJsxS/sVjE8AUdYVqJ71f0WCNhuXd5WC1mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=arQEwv1OL/Xrutm8AD5Z3hif7DRQ55ceO7XrdHGTENLusnJgoxVZBnq6HKyAT0Nobh
         lqJN0CVVPk1yYUsLVR81GpQNARoqyvdz/P+NGbA7KriCqpjfUjmH0DvAqaodeSkCPkhY
         xRPnFgqt5eSASWjcaCdmAFLfYsl0ykuYbSido=
Received: by 10.86.78.4 with SMTP id a4mr2365136fgb.64.1235323147285; Sun, 22 
	Feb 2009 09:19:07 -0800 (PST)
In-Reply-To: <7vskm62z9w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111025>

On Sun, Feb 22, 2009 at 6:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> + =C2=A0 =C2=A0 else if (actions =3D=3D ACTION_GET_COLORBOOL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (argc =3D=3D 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 stdout_is_tty =3D git_config_bool("command line", argv[0]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (argc =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 stdout_is_tty =3D isatty(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_colorbool(arg=
c !=3D 0);
>> + =C2=A0 =C2=A0 }
>
> I see you fixed this from the last series...

Yes, argc !=3D 1 was wrong. Now I've made sure all the tests pass.

--=20
=46elipe Contreras
