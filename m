From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Show usage string for 'git http-push -h'
Date: Mon, 9 Nov 2009 16:52:48 +0800
Message-ID: <be6fef0d0911090052s158ac720ha1fac70da748106d@mail.gmail.com>
References: <20080125173149.GA10287@edna.gwendoline.at>
	 <20091108071152.GA20741@progeny.tock>
	 <20091108072604.GA21367@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 09:52:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Pzc-0001EE-Ie
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 09:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZKIIwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 03:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZKIIwn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 03:52:43 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:52080 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbZKIIwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 03:52:43 -0500
Received: by iwn10 with SMTP id 10so2210686iwn.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3EK/F/h99xPSGSpV6y2iydeyXQJTAxU9e9gmrxYfBEg=;
        b=fudD5W614XYRLbD4LL5L4MnjhF+OjJ4OrVB8IVInB9oYaVd55Sej0VBcyL5uD9X2tJ
         EI2XtQVeeA5OT/QE4AWAKHT+UBLq247MyevyEoXK5Xb1AGImLDHbQ91eH5kQ7H03L3Qp
         +56Zr8gS0Zbb0E2YsK3MQ1EYG9lu3m1Ax0VyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aOXAYaXCVtpc2dlbemqPtXyT1l9L+1W2svM2hyXycODjpr01NNRyOcXV4ukYe1nteX
         VSsEucuP8995j7oSj/hrvJghka4p1wi/oBcOM/lKpMXjJEYhSlsc4aYMP2MwrjSY/HS5
         waNgdwvrecVSVPXjCKKHajqMxHNTV/xfhOsdk=
Received: by 10.231.170.201 with SMTP id e9mr3833949ibz.16.1257756768241; Mon, 
	09 Nov 2009 00:52:48 -0800 (PST)
In-Reply-To: <20091108072604.GA21367@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132453>

Hi,

On Sun, Nov 8, 2009 at 3:26 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> @@ -1792,6 +1792,11 @@ int main(int argc, char **argv)
>
> =A0 =A0 =A0 =A0git_extract_argv0_path(argv[0]);
>
> + =A0 =A0 =A0 if (argc =3D=3D 2 && !strcmp(argv[1], "-h")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "usage: %s\n", http_pus=
h_usage);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0setup_git_directory();
>
> =A0 =A0 =A0 =A0repo =3D xcalloc(sizeof(*repo), 1);

just curious, I'm wondering why isn't the check for "-h" done in the
argv loop later on? I see this being done already in the builtins
diff, log, ls-remote and update-index.

Also, unlike grep, -h <arg> is not an option we're looking out for, so
I'm not sure if we should allow the user to mix -h with a valid set of
arguments (which is what Johnathan's patch would allow).

--=20
Cheers,
Ray Chuan
